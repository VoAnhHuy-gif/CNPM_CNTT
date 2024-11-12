using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
	public interface IVerificationCodeService
	{
		Task<string> GenerateCodeForEmail(string email);
		Task<bool> VerifyCode(string email, string code);
	}
}
