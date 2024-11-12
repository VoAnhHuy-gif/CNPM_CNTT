using FengShuiKoi_BO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IAdvertisementService
    {

        Task<Advertisement> GetAdvertisementByAdID(string AdID);
        Task<List<Advertisement>> GetAdvertisements();
        Task<bool> AddAdvertisement(Advertisement advertisement);
        Task<bool> DeleteAdvertisement(string adID);
        Task<bool> UpdateAdvertisement(Advertisement updatedAdvertisement);
        Task<List<Advertisement>> GetAdvertisementByUserIdAndStatus(string userId, string status);
        Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSortedAdmin();

		Task<List<Advertisement>> GetAdvertisementStatus(string status);

        Task<List<Advertisement>> GetAdvertisementsSortted();
        Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSorted();
		public Task<List<Advertisement>> GetAdvertisementByUserID(string userdID);

        public Task UpdateExpiredAdvertisementsAsync();

	}
}

