using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class AdvertisementRepo : IAdvertisementRepo
    {
        public async Task<bool> AddAdvertisement(Advertisement advertisement)
        {
            return await AdvertisementDAO.Instance.AddAdvertisement(advertisement);
        }

        public async Task<bool> DeleteAdvertisement(string adID)
        {
            return await AdvertisementDAO.Instance.DeleteAdvertisement(adID);
        }

        public async Task<Advertisement> GetAdvertisementByAdID(string AdID)
        {
            return await AdvertisementDAO.Instance.GetAdvertisementByAdID(AdID);
        }

        public async Task<List<Advertisement>> GetAdvertisementStatus(string status)
            => await AdvertisementDAO.Instance.GetAdvertisementStatus(status);

		public async Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSortedAdmin() => await AdvertisementDAO.Instance.GetAdvertisementsWithPackageSortedAdmin();

		public async Task<List<Advertisement>> GetAdvertisementByUserIdAndStatus(string userId, string status)
        {
            return await AdvertisementDAO.Instance.GetAdvertisementByUserIdAndStatus(userId, status);
        }

		public async Task<List<Advertisement>> GetAdvertisementByUserID(string userdID) => await AdvertisementDAO.Instance.GetAdvertisementByUserID(userdID);


        public async Task<List<Advertisement>> GetAdvertisements()
        {
            return await AdvertisementDAO.Instance.GetAdvertisements();
        }

        public async Task<bool> UpdateAdvertisement(Advertisement updatedAdvertisement)
        {
            return await AdvertisementDAO.Instance.UpdateAdvertisement(updatedAdvertisement);
        }


		public async Task<List<Advertisement>> GetExpiredAdvertisements() => await AdvertisementDAO.Instance.GetExpiredAdvertisements();
    public async Task<List<Advertisement>> GetAdvertisementsSortted() => await AdvertisementDAO.Instance.GetAdvertisementsSortted();
		public async Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSorted() => await AdvertisementDAO.Instance.GetAdvertisementsWithPackageSorted();
	}
}

