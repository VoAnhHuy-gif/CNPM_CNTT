using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Linq;

namespace KoiFengShui.BE.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class VNPayController : ControllerBase
	{
		private readonly string _vnpayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
		private readonly string _tmnCode = "62AU6ZXW";
		private readonly string _hashSecret = "F30RSQ69LUD3SJKFXLYVFQRD1A0EFF4J";

		[HttpPost("create-payment")]
		public IActionResult CreatePayment([FromBody] PaymentInformationModel model)
		{
			var vnpayTxnRef = DateTime.Now.Ticks.ToString();
			var vnpayCreateDate = DateTime.Now.ToString("yyyyMMddHHmmss");
			var price = (long)(model.Amount * 100);

			var vnpayParams = new SortedList<string, string>
			{
				{ "vnp_Version", "2.1.0" },
				{ "vnp_Command", "pay" },
				{ "vnp_TmnCode", _tmnCode },
				{ "vnp_Amount", price.ToString() },
				{ "vnp_CreateDate", vnpayCreateDate },
				{ "vnp_CurrCode", "VND" },
				{ "vnp_IpAddr", HttpContext.Connection.RemoteIpAddress.ToString() },
				{ "vnp_Locale", "vn" },
				{ "vnp_OrderInfo", $"Thanh toan don hang: {vnpayTxnRef}" },
				{ "vnp_OrderType", "other" },
				{ "vnp_ReturnUrl", "http://localhost:5173/payment-success" },
				{ "vnp_TxnRef", vnpayTxnRef },
				{ "vnp_BankCode", "" },
				{ "vnp_ExpireDate", DateTime.Now.AddMinutes(15).ToString("yyyyMMddHHmmss") }
			};

			var signData = string.Join("&", vnpayParams
				.Where(kv => !string.IsNullOrEmpty(kv.Value))
				.OrderBy(kv => kv.Key)
				.Select(kv => $"{kv.Key}={WebUtility.UrlEncode(kv.Value)}"));

			var vnpSecureHash = HmacSHA512(_hashSecret, signData);
			vnpayParams.Add("vnp_SecureHash", vnpSecureHash);

			Console.WriteLine($"SignData: {signData}");
			Console.WriteLine($"SecureHash: {vnpSecureHash}");

			var paymentUrl = $"{_vnpayUrl}?" + string.Join("&", vnpayParams
				.Where(kv => !string.IsNullOrEmpty(kv.Value))
				.OrderBy(kv => kv.Key)
				.Select(kv => $"{kv.Key}={WebUtility.UrlEncode(kv.Value)}"));

			return Ok(new { PaymentUrl = paymentUrl });
		}

		[HttpGet("payment-callback")]
		public IActionResult PaymentCallback()
		{
			var vnpayData = HttpContext.Request.Query;
			var vnpSecureHash = vnpayData["vnp_SecureHash"].ToString();
			var orderInfo = vnpayData["vnp_OrderInfo"].ToString();
			var vnpResponseCode = vnpayData["vnp_ResponseCode"].ToString();

			var inputData = vnpayData
				.Where(kv => kv.Key.StartsWith("vnp_") && kv.Key != "vnp_SecureHash")
				.OrderBy(kv => kv.Key)
				.ToDictionary(kv => kv.Key, kv => kv.Value.ToString());

			var checkSignature = ValidateSignature(inputData, vnpSecureHash);

			if (checkSignature)
			{
				if (vnpResponseCode == "00")
				{
					return Ok(new { Message = "Thanh toán thành công", OrderInfo = orderInfo });
				}
				else
				{
					return BadRequest(new { Message = "Thanh toán thất bại hoặc bị hủy", OrderInfo = orderInfo });
				}
			}
			else
			{
				return BadRequest(new { Message = "Chữ ký không hợp lệ" });
			}
		}

		private string HmacSHA512(string key, string inputData)
		{
			var hash = new StringBuilder();
			byte[] keyBytes = Encoding.UTF8.GetBytes(key);
			byte[] inputBytes = Encoding.UTF8.GetBytes(inputData);
			using (var hmac = new HMACSHA512(keyBytes))
			{
				byte[] hashValue = hmac.ComputeHash(inputBytes);
				foreach (var theByte in hashValue)
				{
					hash.Append(theByte.ToString("x2"));
				}
			}

			return hash.ToString();
		}

		private bool ValidateSignature(Dictionary<string, string> inputData, string vnpSecureHash)
		{
			var signData = string.Join("&", inputData
				.Where(kv => !string.IsNullOrEmpty(kv.Value))
				.Select(kv => $"{WebUtility.UrlEncode(kv.Key)}={WebUtility.UrlEncode(kv.Value)}"));

			var computedHash = HmacSHA512(_hashSecret, signData);
			return computedHash.Equals(vnpSecureHash, StringComparison.InvariantCultureIgnoreCase);
		}
	}

	public class PaymentInformationModel
	{
		public decimal Amount { get; set; }
	}
}