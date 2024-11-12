using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FengShuiKoi_Services;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace FengShuiKoi_Services
{
	public class AdvertisementExpirationService : BackgroundService
	{
		private readonly IServiceProvider _services;
		private readonly TimeSpan _checkInterval = TimeSpan.FromHours(0.05);

		public AdvertisementExpirationService(IServiceProvider services)
		{
			_services = services;
		}

		protected override async Task ExecuteAsync(CancellationToken stoppingToken)
		{
			while (!stoppingToken.IsCancellationRequested)
			{
				using (var scope = _services.CreateScope())
				{
					var advertisementService =
						scope.ServiceProvider
							.GetRequiredService<IAdvertisementService>();

					advertisementService.UpdateExpiredAdvertisementsAsync();
				}
				await Task.Delay(_checkInterval, stoppingToken);
			}
		}
	}
}
