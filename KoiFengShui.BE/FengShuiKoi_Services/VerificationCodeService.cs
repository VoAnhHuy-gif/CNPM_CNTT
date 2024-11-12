using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
	public class VerificationCodeService : IVerificationCodeService
	{
		private readonly Dictionary<string, (string Code, DateTime ExpirationTime)> _codes = new Dictionary<string, (string, DateTime)>();
		private const string AllowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		private const int CodeLength = 8;
		private const int CodeExpirationMinutes = 15;

		public Task<string> GenerateCodeForEmail(string email)
		{
			var code = GenerateCode();
			_codes[email] = (code, DateTime.UtcNow.AddMinutes(CodeExpirationMinutes));
			return Task.FromResult(code);
		}

		public Task<bool> VerifyCode(string email, string code)
		{
			if (_codes.TryGetValue(email, out var storedData))
			{
				var (storedCode, expirationTime) = storedData;
				if (DateTime.UtcNow <= expirationTime && string.Equals(storedCode, code, StringComparison.OrdinalIgnoreCase))
				{
					_codes.Remove(email);
					return Task.FromResult(true);
				}
			}
			return Task.FromResult(false);
		}

		private string GenerateCode()
		{
			var random = new Random();
			var code = new char[CodeLength];

			for (int i = 0; i < CodeLength; i++)
			{
				code[i] = AllowedChars[random.Next(0, AllowedChars.Length)];
			}

			string generatedCode = new string(code);
			return generatedCode;
		}
	}
}
