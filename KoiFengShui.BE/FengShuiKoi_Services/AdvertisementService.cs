using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class AdvertisementService : IAdvertisementService
    {
        private IAdvertisementRepo iAdvertisementRepo;
        public AdvertisementService()
        {
            iAdvertisementRepo = new AdvertisementRepo();
        }
        public async Task<bool> AddAdvertisement(Advertisement advertisement)
        {
            return await iAdvertisementRepo.AddAdvertisement(advertisement);
        }

        public async Task<bool> DeleteAdvertisement(string adID)
        {
            return await iAdvertisementRepo.DeleteAdvertisement(adID);
        }
        public async Task<List<Advertisement>> GetAdvertisementStatus(string status)
            => await iAdvertisementRepo.GetAdvertisementStatus(status);
        public async Task<Advertisement> GetAdvertisementByAdID(string AdID)
        {
            return await iAdvertisementRepo.GetAdvertisementByAdID(AdID);
        }


        public async Task<List<Advertisement>> GetAdvertisementByUserIdAndStatus(string userId, string status)
        {
            return await iAdvertisementRepo.GetAdvertisementByUserIdAndStatus(userId, status);
        }


        public async Task<List<Advertisement>> GetAdvertisementByUserID(string userdID) => await iAdvertisementRepo.GetAdvertisementByUserID(userdID);
		public async Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSortedAdmin() => await iAdvertisementRepo.GetAdvertisementsWithPackageSortedAdmin();

		public async Task<List<Advertisement>> GetAdvertisementsSortted() => await iAdvertisementRepo.GetAdvertisementsSortted();
		    public async Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSorted() => await iAdvertisementRepo.GetAdvertisementsWithPackageSorted();

		    public async Task<List<Advertisement>> GetAdvertisements()

        {
            return await iAdvertisementRepo.GetAdvertisements();
        }

        public async Task<bool> UpdateAdvertisement(Advertisement updatedAdvertisement)
        {
            return await iAdvertisementRepo.UpdateAdvertisement(updatedAdvertisement);
        }


		    public async Task UpdateExpiredAdvertisementsAsync()
		    {
			    var expiredAds = await iAdvertisementRepo.GetExpiredAdvertisements();
			    foreach (var ad in expiredAds)
			  {

				ad.Status = "Expired";
				iAdvertisementRepo.UpdateAdvertisement(ad);
			  }
		}

	}
}

