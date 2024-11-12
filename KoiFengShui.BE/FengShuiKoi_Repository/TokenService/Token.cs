using FengShuiKoi_BO;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace KoiFengShui.BE.TokenService
{
	public class Token : IToken
	{
		private readonly SymmetricSecurityKey _key;
		private readonly string _issuer;
		private readonly string _audience;

		public Token(IConfiguration config)
		{
			var signingKey = Environment.GetEnvironmentVariable("JWT_SIGNING_KEY");
			_issuer = Environment.GetEnvironmentVariable("JWT_ISSUER");
			_audience = Environment.GetEnvironmentVariable("JWT_AUDIENCE");

			if (string.IsNullOrEmpty(signingKey) || string.IsNullOrEmpty(_issuer) || string.IsNullOrEmpty(_audience))
			{
				throw new InvalidOperationException("JWT configuration is missing in environment variables");
			}
			_key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(signingKey));
		}

		public string CreateToken(Account user)
		{
			var authClaims = new List<Claim>
			{
				new Claim(JwtRegisteredClaimNames.Sub, user.UserId),
				new Claim(JwtRegisteredClaimNames.Email, user.Email ?? ""),
				new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
				new Claim(CustomClaimTypes.Role, user.Role ?? ""),
				new Claim(CustomClaimTypes.UserId, user.UserId)
			};

			var tokenHandler = new JwtSecurityTokenHandler();
			var tokenDescriptor = new SecurityTokenDescriptor
			{
				Subject = new ClaimsIdentity(authClaims),
				Expires = DateTime.UtcNow.AddMinutes(1440), // Short-lived token
				Issuer = _issuer,
				Audience = _audience,
				SigningCredentials = new SigningCredentials(_key, SecurityAlgorithms.HmacSha256Signature)
			};

			var token = tokenHandler.CreateToken(tokenDescriptor);
			return tokenHandler.WriteToken(token);
		}
	}

	public static class CustomClaimTypes
	{
		public const string Role = "Role";
		public const string UserId = "UserId";
	}
}
