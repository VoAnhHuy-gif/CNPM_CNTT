using FengShuiKoi_BO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IAdvertisementRepo
    {

        Task<Advertisement> GetAdvertisementByAdID(string AdID);
        Task<List<Advertisement>> GetAdvertisements();
        Task<bool> AddAdvertisement(Advertisement advertisement);
        Task<bool> DeleteAdvertisement(string adID);
        Task<bool> UpdateAdvertisement(Advertisement updatedAdvertisement);
        Task<List<Advertisement>> GetAdvertisementByUserIdAndStatus(string userId, string status);
        Task<List<Advertisement>> GetAdvertisementStatus(string status);

        Task<List<Advertisement>> GetAdvertisementsSortted();
        Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSorted();
        Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSortedAdmin();
		public Task<List<Advertisement>> GetAdvertisementByUserID(string userdID);

        public Task<List<Advertisement>> GetExpiredAdvertisements();

   }
}
