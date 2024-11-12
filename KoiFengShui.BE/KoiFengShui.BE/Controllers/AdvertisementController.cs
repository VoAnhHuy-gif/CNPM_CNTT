using FengShuiKoi_BO;
using FengShuiKoi_Services;
using KoiFengShui.BE.Attributes;
using KoiFengShui.BE.Model;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class AdvertisementController : ControllerBase
    {
        private readonly IPackageService _packageService;
        private readonly IElementService _elementService;
        private readonly IAccountService _accountService;
        private readonly IAdsPackageService _adsPackageService;
        private readonly IAdvertisementService _advertisementService;
        private readonly IEmailService _emailService;
        public AdvertisementController(IPackageService packageService, IAdvertisementService advertisementService, IAdsPackageService adsPackageService, IAccountService accountService, IElementService elementService, IEmailService emailService)
        {
            _packageService = packageService;
            _adsPackageService = adsPackageService;
            _advertisementService = advertisementService;
            _accountService = accountService;
            _elementService = elementService;
            _emailService = emailService;
        }

        [HttpGet("GetAllAdvertisement")]
        public async Task<IActionResult> GetAllAdvertisement()
        {
            try
            {
                var listAdvertisement = await _advertisementService.GetAdvertisements();
                if (listAdvertisement == null)
                {
                    return NotFound("Không có quảng cáo nào.");
                }
                return Ok(listAdvertisement);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }
        [HttpGet("GetAllAdvertisementSortted")]
        public async Task<IActionResult> GetAllAdvertisementSortted()
        {
            try
            {
                var listAdvertisement = await _advertisementService.GetAdvertisementsSortted();
                if (listAdvertisement == null)
                {
                    return NotFound("Không có quảng cáo nào.");
                }
                return Ok(listAdvertisement);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpGet("GetAllAdvertisemenWithPackageSortted")]
        public async Task<IActionResult> GetAllAdvertisemenWithPackageSortted()
        {
            try
            {
                var listAdvertisement = await _advertisementService.GetAdvertisementsWithPackageSorted();
                if (listAdvertisement == null)
                {
                    return NotFound("Không có quảng cáo nào.");
                }
                return Ok(listAdvertisement);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [AuthorizeRoles("Admin")]
        [HttpGet("GetAdvertisementsWithPackageSortedAdmin")]
		public async Task<IActionResult> GetAdvertisementsWithPackageSortedAdmin()
		{
			try
			{
				var listAdvertisement = await _advertisementService.GetAdvertisementsWithPackageSortedAdmin();
				if (listAdvertisement == null)
				{
					return NotFound("Không có quảng cáo nào.");
				}
				return Ok(listAdvertisement);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Lỗi server: {ex.Message}");
			}
		}


		[HttpGet("GetAdvertisementByAdId")]
        public async Task<IActionResult> GetAdvertisementByAdId(string adId)
        {
            try
            {
                var advertisements = await _advertisementService.GetAdvertisementByAdID(adId);
                if (advertisements == null)
                {
                    return NotFound("Không tìm thấy quảng cáo");
                }
                return Ok(advertisements);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }


        [Authorize ()]
        [HttpGet("GetAdvertisementByUserId")]
        public async Task<IActionResult> GetAdvertisementByUserId(string UserId)
        {
            try
            {
                var advertisements = await _advertisementService.GetAdvertisementByUserID(UserId);
                if (advertisements == null)
                {
                    return NotFound("Người dùng chưa có quảng cáo");
                }
                return Ok(advertisements);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }
        [HttpGet("CheckAdIdExist")]
        public async Task<IActionResult> CheckAdIdExist(string adId)

        {
            try
            {
                var advertise = await _advertisementService.GetAdvertisementByAdID(adId);
                return Ok(advertise != null ? "True" : "False");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpGet("GetAdvertisementByUserIDandStatus")]
        public async Task<IActionResult> GetAdvertisementByUserIDandStatus(string userID, string status)
        {
            try
            {
                var advertisements = await _advertisementService.GetAdvertisementByUserIdAndStatus(userID, status);
                if (advertisements == null)
                {
                    return BadRequest("Không tìm thấy quảng cáo");
                }
                return Ok(advertisements);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpGet("GetAdvertisementByRank")]
        public async Task<IActionResult> GetAdvertisementByRank(string rank)
        {
            List<Advertisement> listAd = new List<Advertisement>();
            try
            {
                List<AdsPackage> list = await _adsPackageService.GetListAdsPackageByRank(rank);
                foreach (AdsPackage ad in list)
                {
                    Advertisement ads = await _advertisementService.GetAdvertisementByAdID(ad.AdId);

                    if (ads.Status.Equals("Approved"))

                    {

                        var advertisement = await _advertisementService.GetAdvertisementByAdID(ad.AdId);
                        if (advertisement != null)
                        {
                            listAd.Add(advertisement);
                        }

                    }
                }
                if (listAd.Count == 0)
                {
                    return BadRequest("Không tìm thấy quảng cáo");
                }
                return Ok(listAd);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [AuthorizeRoles("Admin")]
        [HttpGet("GetAdvertisementByStatusAdmin")]
        public async Task<IActionResult> GetAdvertisementByStatusAdmin(string status)
        {
            try
            {
                var advertisements = await _advertisementService.GetAdvertisementStatus(status);
                if (advertisements == null)
                {
                    return BadRequest("Không tìm thấy quảng cáo có trạng thái" + status);
                }
                return Ok(advertisements);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpPost("SaveAdvertisementDraft")]
        public async Task<IActionResult> SaveAdvertisementDraft(AdvertisementDTO advertisementDto)
        {
            try
            {
                if (string.IsNullOrEmpty(advertisementDto.UserId))
                {
                    return BadRequest("ID người dùng là bắt buộc.");
                }

                if (string.IsNullOrEmpty(advertisementDto.ElementId))
                {
                    return BadRequest("Mệnh của bài đăng là bắt buộc.");
                }
                if (await _accountService.GetAccountByUserID(advertisementDto.UserId) == null)
                {
                    return BadRequest("Không tìm thấy ID của người dùng.");
                }
                string adId = await GenerateOrValidateAdId(advertisementDto.AdId);
                if (adId == null)
                {
                    return StatusCode(500, "Không tạo được ID quảng cáo. Vui lòng thử lại.");
                }
                Advertisement advertisement = await _advertisementService.GetAdvertisementByAdID(adId);
                bool isNewAdvertisement = advertisement == null;


                if (isNewAdvertisement)
                {
                    advertisement = new Advertisement
                    {
                        AdId = adId,
                        Heading = advertisementDto.Heading,
                        Image = advertisementDto.Image,
                        Link = advertisementDto.Link,
                        UserId = advertisementDto.UserId,
                        ElementId = advertisementDto.ElementId,

                        Status = "Draft"
                    };
                }

                // Cập nhật thuộc tính quảng cáo
                advertisement.Heading = advertisementDto.Heading?.Trim();
                advertisement.Image = advertisementDto.Image?.Trim();
                advertisement.Link = advertisementDto.Link?.Trim();
                advertisement.ElementId = advertisementDto.ElementId;

                bool result = isNewAdvertisement
                    ? await _advertisementService.AddAdvertisement(advertisement)
                    : await _advertisementService.UpdateAdvertisement(advertisement);

                if (result)
                {
                    return Ok(new { Message = isNewAdvertisement ? "Tạo bản nháp quảng cáo thành công" : "Cập nhật bản nháp quảng cáo thành công", AdId = advertisement.AdId });
                }
                else
                {
                    return BadRequest(isNewAdvertisement ? "Tạo bản nháp quảng cáo thất bại" : "Cập nhật bản nháp quảng cáo thất bại");
                }
            }
            catch (Exception ex)
            {
                // Ghi log chi tiết lỗi ở đây
                return StatusCode(500, "Đã xảy ra lỗi khi xử lý yêu cầu. Vui lòng thử lại sau.");
            }
        }

        private async Task<string> GenerateOrValidateAdId(string adId)
        {
            string pattern = @"^AD\d{3}$";
            if (Regex.IsMatch(adId, pattern))
            {
                return adId;
            }

            const int maxAttempts = 10;
            for (int i = 0; i < maxAttempts; i++)
            {
                string newAdId = GenerateUniqueAdId();
                if (await _advertisementService.GetAdvertisementByAdID(newAdId) == null)
                {
                    return newAdId;
                }
            }
            return null;
        }

        private string GenerateUniqueAdId()
        {
            Random random = new Random();
            int randomNumber = random.Next(0, 1000); // Tạo số ngẫu nhiên từ 0 đến 999
            return $"AD{randomNumber:D3}";
        }

        [HttpPost("AddAdvertisementDraft")]
        public async Task<IActionResult> AddAdvertisementDraft(AdvertisementDTO advertisementDto)
        {
            try
            {
                // Validate input
                if (await _accountService.GetAccountByUserID(advertisementDto.UserId) == null)
                {
                    return BadRequest(" Không tìm thấy ID của người dùng. ");
                }
                // Generate unique AdId
                string adId = GenerateUniqueAdId();
                int attempts = 0;
                const int maxAttempts = 10;

                while (await _advertisementService.GetAdvertisementByAdID(adId) != null && attempts < maxAttempts)
                {
                    adId = GenerateUniqueAdId();
                    attempts++;
                }

                if (attempts == maxAttempts)
                {
                    return StatusCode(500, "Không tạo được ID quảng cáo. Vui lòng thử lại.");
                }
                // Create new Advertisement object
                var advertisement = new Advertisement
                {
                    AdId = adId,
                    Heading = advertisementDto.Heading?.Trim(),
                    Image = advertisementDto.Image?.Trim(),
                    Link = advertisementDto.Link?.Trim(),
                    UserId = advertisementDto.UserId,
                    ElementId = advertisementDto.ElementId,
                    Status = "Draft",
                };
                // Add advertisement
                bool result = await _advertisementService.AddAdvertisement(advertisement);

                if (result)
                {
                    return Ok(new { Message = "Tạo quảng cáo thành công", AdId = adId });
                }
                else
                {
                    return BadRequest("Tạo quảng cáo thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Lỗi server. Vui lòng thử lại.");
            }
        }

        [AuthorizeRoles("Admin")]
        [HttpPut("ApproveAdvertisement")]
        public async Task<IActionResult> ApproveAdvertisement(string adId, string elementID, string status)
        {
            try
            {
                var advertise = await _advertisementService.GetAdvertisementByAdID(adId);
                if (advertise == null)
                {
                    return BadRequest("Không tìm thấy bài quảng cáo");
                }
                else
                {
                    advertise.ElementId = elementID;
                    advertise.Status = status;
                    bool check = await _advertisementService.UpdateAdvertisement(advertise);
                    if (check)
                    {
                        return Ok("Cập nhật thành công");
                    }
                    else
                    {
                        return BadRequest("Cập nhật thất bại");
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }
        [HttpPut("UpdateAdvertisementStatus")]
        public async Task<IActionResult> UpdateAdvertisementStatus(string adId, string status)

        {
            try
            {
                var advertise = await _advertisementService.GetAdvertisementByAdID(adId);
                if (advertise == null)
                {
                    return BadRequest("Không tìm thấy bài quảng cáo");
                }
                else
                {
                    advertise.Status = status;
                    bool check = await _advertisementService.UpdateAdvertisement(advertise);
                    if (check)
                    {
                        return Ok("Cập nhật thành công");
                    }
                    else
                    {
                        return BadRequest("Cập nhật thất bại");
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }


        [HttpPut("UpdateDaftAdvertisement")]
        public async Task<IActionResult> UpdateDaftAdvertisement(AdvertisementDTO advertisement)
        {
            try
            {
                var existingAdvertisement = await _advertisementService.GetAdvertisementByAdID(advertisement.AdId);
                if (existingAdvertisement == null)
                {
                    return NotFound("Không tìm thấy quảng cáo");
                }
                existingAdvertisement.Image = advertisement.Image;
                existingAdvertisement.Heading = advertisement.Heading;
                existingAdvertisement.Link = advertisement.Link;
                existingAdvertisement.Status = "Draft";
                bool result1 = await _advertisementService.UpdateAdvertisement(existingAdvertisement);
                if (result1)
                {
                    return Ok("Cập nhật Draft thành công");
                }
                else
                {
                    return BadRequest("Cập nhật gói thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpPut("UpdateAdvertisement")]
        public async Task<IActionResult> UpdateAdvertisement(AdvertisementDTO advertisement, string Rank, string Status, DateTime startDate, DateTime CreateAt, int quantity, float total)

        {
            try
            {
                var existingAdvertisement = await _advertisementService.GetAdvertisementByAdID(advertisement.AdId);
                if (existingAdvertisement == null)
                {
                    return NotFound("Không tìm thấy quảng cáo");
                }
                if (await _elementService.GetElementAndMutualism(advertisement.ElementId) == null)
                {
                    return BadRequest("Không tìm thấy nguyên tố phù hợp ");
                }
                existingAdvertisement.ElementId = advertisement.ElementId;
                existingAdvertisement.Status = Status;
                bool result1 = await _advertisementService.UpdateAdvertisement(existingAdvertisement);
                AdsPackage adsPackage = await _adsPackageService.GetAdsPackageByAdIDRankTime(advertisement.AdId, Rank, CreateAt);
                Package package = await _packageService.GetPackageByRank(Rank);
                if (adsPackage == null)
                {
                    AdsPackage newads = new AdsPackage();
                    newads.AdId = advertisement.AdId;
                    newads.Rank = Rank;
                    newads.StartDate = startDate;
                    newads.ExpiredDate = startDate.AddDays(package.Duration * quantity);
                    newads.Quantity = quantity;
                    newads.Total = total;
                    newads.CreateAt = CreateAt;
                    bool result2 = await _adsPackageService.AddAdsPackage(newads);
                    if (result2)
                    {
                        return Ok("Thêm quảng cáo thành công");
                    }
                }
                if (result1)
                {
                    return Ok("Cập nhật gói thành công");
                }
                else
                {
                    return BadRequest("Cập nhật gói thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpPost("CreateAdvertisement")]
        public async Task<IActionResult> CreateAdvertisement(AdvertisementDTO advertisement, string Rank, DateTime startDate, DateTime CreateAt, int quantity, float total, string TransactionCode, string BankCode)

        {
            try
            {
                Advertisement existingAdvertisement = null;
                bool isNewAd = !Regex.IsMatch(advertisement.AdId ?? "", @"^AD\d{3}$");

                if (!isNewAd)
                {
                    existingAdvertisement = await _advertisementService.GetAdvertisementByAdID(advertisement.AdId);
                    if (existingAdvertisement == null)
                    {
                        return NotFound("Không tìm thấy bản nháp quảng cáo");
                    }
                }

                if (await _elementService.GetElementAndMutualism(advertisement.ElementId) == null)
                {
                    return BadRequest("Không tìm thấy nguyên tố phù hợp");
                }

                Advertisement newAd;
                if (isNewAd)
                {
                    string newAdId = GenerateUniqueAdId();
                    newAd = new Advertisement
                    {
                        AdId = newAdId,
                        UserId = advertisement.UserId,
                        Heading = advertisement.Heading,
                        Image = advertisement.Image,
                        Link = advertisement.Link,
                        ElementId = advertisement.ElementId,
                        Status = "Pending"
                    };
                }
                else
                {
                    newAd = existingAdvertisement;
                    newAd.Heading = advertisement.Heading;
                    newAd.Image = advertisement.Image;
                    newAd.Link = advertisement.Link;
                    newAd.ElementId = advertisement.ElementId;
                    newAd.Status = "Pending";
                }

                bool result;
                if (isNewAd)
                {
                    result = await _advertisementService.AddAdvertisement(newAd);
                }
                else
                {
                    result = await _advertisementService.UpdateAdvertisement(newAd);
                }

                if (!result)
                {
                    return BadRequest("Tạo quảng cáo thất bại");
                }

                Package package = await _packageService.GetPackageByRank(Rank);
                if (package == null)
                {
                    return BadRequest("Không tìm thấy gói quảng cáo phù hợp");
                }

                AdsPackage newAdsPackage = new AdsPackage
                {
                    AdId = newAd.AdId,
                    Rank = Rank,
                    StartDate = startDate,
                    ExpiredDate = startDate.AddDays(package.Duration * quantity),
                    Quantity = quantity,
                    Total = total,
                    CreateAt = CreateAt
                };

                bool adsPackageResult = await _adsPackageService.AddAdsPackage(newAdsPackage);
                if (!adsPackageResult)
                {
                    return BadRequest("Thêm gói quảng cáo thất bại");
                }

                // Gửi email thông báo
                var account = await _accountService.GetAccountByUserID(advertisement.UserId);
                if (account != null && !string.IsNullOrEmpty(account.Email))
                {
                    string emailBody = $@"
                    <html>
                    <body>
                        <h2>Thông tin Quảng Cáo</h2>
                        <table border='1' style='border-collapse: collapse;'>
                            <tr>
                                <td><strong>Mã giao dịch:</strong></td>
                                <td>{TransactionCode}</td>
                            </tr>
                            <tr>
                                <td><strong>Mã ngân hàng:</strong></td>
                                <td>{BankCode}</td>
                            </tr>
                            <tr>
                                <td><strong>Mã Quảng Cáo:</strong></td>
                                <td>{newAd.AdId}</td>
                            </tr>
                            <tr>
                                <td><strong>Tiêu đề:</strong></td>
                                <td>{newAd.Heading}</td>
                            </tr>
                            <tr>
                                <td><strong>Trạng thái:</strong></td>
                                <td>{newAd.Status}</td>
                            </tr>
                            <tr>
                                <td><strong>Gói:</strong></td>
                                <td>{newAdsPackage.Rank}</td>
                            </tr>
                            <tr>
                                <td><strong>Ngày bắt đầu:</strong></td>
                                <td>{newAdsPackage.StartDate:dd/MM/yyyy}</td>
                            </tr>
                            <tr>
                                <td><strong>Ngày kết thúc:</strong></td>
                                <td>{newAdsPackage.ExpiredDate:dd/MM/yyyy}</td>
                            </tr>
                            <tr>
                                <td><strong>Số lượng:</strong></td>
                                <td>{newAdsPackage.Quantity}</td>
                            </tr>
                            <tr>
                                <td><strong>Tổng tiền:</strong></td>
                                <td>{newAdsPackage.Total:N0} đ</td>
                            </tr>
                            <tr>
                                <td><strong>Ngày tạo:</strong></td>
                                <td>{newAdsPackage.CreateAt:dd/MM/yyyy HH:mm:ss}</td>
                            </tr>
                        </table>
                    </body> 
                    </html>";

                    await _emailService.SendEmailAsync(account.Email, "Thông báo tạo quảng cáo thành công", emailBody);
                }

                return Ok(new { Message = "Tạo quảng cáo thành công", AdId = newAd.AdId });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpDelete("DeleteAdvertisement/{adId}")]
        public async Task<IActionResult> DeleteAdvertisement(string adId)
        {
            try
            {
                var existingAdvertisement = await _advertisementService.GetAdvertisementByAdID(adId);
                if (existingAdvertisement == null)
                {
                    return NotFound("Không tìm thấy quảng cáo");
                }

                bool result = await _advertisementService.DeleteAdvertisement(adId);
                if (result)
                {
                    return Ok("Xóa quảng cáo thành công");
                }
                else
                {
                    return BadRequest("Xóa quảng cáo thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        [HttpPost("TransferNotification")]
        public async Task<IActionResult> TransferNotification([FromBody] PaymentNotificationDTO model)
        {
            var account = await _accountService.GetAccountByEmail(model.Email);
            if (account == null)
            {
                return NotFound("Email không tồn tại trong hệ thống.");
            }

            string emailBody = $@"
            <html>
            <body>
                <h2>Thông tin thanh toán</h2>
                <table border='1' style='border-collapse: collapse;'>
                    <tr>
                        <td><strong>Số tiền:</strong></td>
                        <td>{model.Amount:N0} đ</td>
                    </tr>
                    <tr>
                        <td><strong>Thông tin đơn hàng:</strong></td>
                        <td>{model.OrderInfo}</td>
                    </tr>
                    <tr>
                        <td><strong>Mã giao dịch:</strong></td>
                        <td>{model.TransactionCode}</td>
                    </tr>
                    <tr>
                        <td><strong>Mã ngân hàng:</strong></td>
                        <td>{model.BankCode}</td>
                    </tr>
                    <tr>
                        <td><strong>Ngày thanh toán:</strong></td>
                        <td>{model.PaymentDate:dd/MM/yyyy HH:mm:ss}</td>
                    </tr>
                </table>
            </body>
            </html>";

            await _emailService.SendEmailAsync(model.Email, "Thông báo thanh toán thành công", emailBody);

            return Ok("Thông báo thanh toán đã được gửi đến email của bạn.");
        }

        [HttpPost("RefundNotification")]
        public async Task<IActionResult> RefundNotification(string adId)
        {
            try
            {
                // Get the advertisement details
                var advertisement = await _advertisementService.GetAdvertisementByAdID(adId);
                if (advertisement == null)
                {
                    return NotFound("Advertisement not found");
                }

                // Get the AdsPackage details
                var adsPackage = await _adsPackageService.GetAdsPackageByAdID(adId);
                if (adsPackage == null)
                {
                    return NotFound("AdsPackage not found");
                }

                // Get the user's account details
                var account = await _accountService.GetAccountByUserID(advertisement.UserId);
                if (account == null)
                {
                    return NotFound("User account not found");
                }

                // Prepare the email body
                string emailBody = $@"
                <html>
                <body>
                    <h2>Thông báo hoàn tiền quảng cáo</h2>
                    <p>Kính gửi quý khách hàng,</p>
                    <p>Chúng tôi xin thông báo rằng khoản tiền quảng cáo của bạn đã được hoàn trả. Chi tiết như sau:</p>
                    <table border='1' style='border-collapse: collapse;'>
                        <tr>
                             <td><strong>Tiêu Đề Quảng Cáo:</strong></td>
 			     <td>{advertisement.Heading}</td>
                        </tr>
                        <tr>
                            <td><strong>Gói Quảng Cáo:</strong></td>
                            <td>{adsPackage.Rank}</td>
                        </tr>
                        <tr>
                            <td><strong>Số tiền hoàn trả:</strong></td>
                            <td>{adsPackage.Total:N0} đ</td>
                        </tr>
                        <tr>
                            <td><strong>Thời gian:</strong></td>
                            <td>{DateTime.Now}</td>
                        </tr>
                    </table>
                    <p>Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi.</p>
                    <p>Trân trọng,<br>Đội ngũ hỗ trợ khách hàng</p>
                </body>
                </html>";

                await _emailService.SendEmailAsync(account.Email, "Thông báo hoàn tiền quảng cáo", emailBody);
                advertisement.Status = "Refunded";
                bool success = await _advertisementService.UpdateAdvertisement(advertisement);
			    return Ok("Thông báo hoàn tiền đã được gửi đến email của khách hàng.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

    }
}
