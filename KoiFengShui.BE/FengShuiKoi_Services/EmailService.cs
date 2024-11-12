using FengShuiKoi_Services;
using Microsoft.Extensions.Configuration;
using System.Net;
using System.Net.Mail;

public class EmailService : IEmailService
{
	private readonly string _smtpServer;
	private readonly int _smtpPort;
	private readonly string _smtpUsername;
	private readonly string _smtpPassword;

	public EmailService(IConfiguration configuration)
	{
		_smtpServer = configuration["EmailSettings:SmtpServer"];
		_smtpPort = int.Parse(configuration["EmailSettings:SmtpPort"]);
		_smtpUsername = configuration["EmailSettings:SmtpUsername"];
		_smtpPassword = configuration["EmailSettings:SmtpPassword"];
	}

	public async Task SendEmailAsync(string to, string subject, string body)
	{
		using var client = new SmtpClient(_smtpServer, _smtpPort)
		{
			Credentials = new NetworkCredential(_smtpUsername, _smtpPassword),
			EnableSsl = true
		};

		await client.SendMailAsync(new MailMessage(_smtpUsername, to, subject, body)
		{
			IsBodyHtml = true
		});
	}
}