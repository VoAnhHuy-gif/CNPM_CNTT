using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class AdvertisementDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static AdvertisementDAO instance = null;
        public static AdvertisementDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AdvertisementDAO();
                }
                return instance;
            }
        }
        public AdvertisementDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }
        public async Task<Advertisement> GetAdvertisementByAdID(string AdID)
        {
            return await dbContext.Advertisements.SingleOrDefaultAsync(m => m.AdId.Equals(AdID));
        }

        public async Task<List<Advertisement>> GetAdvertisements()
        {
            return await dbContext.Advertisements.ToListAsync();
        }
		public async Task<List<Advertisement>> GetAdvertisementsSortted()
		{
			var now = DateTime.Now;
			return await dbContext.Advertisements
				.Join(dbContext.AdsPackages,
					ad => ad.AdId,
					ap => ap.AdId,
					(ad, ap) => new { Advertisement = ad, AdsPackage = ap })
				.Where(x => x.AdsPackage.StartDate <= now && x.AdsPackage.ExpiredDate >= now)
				.OrderBy(x => x.AdsPackage.Rank == "Diamond" ? 0 :
							  x.AdsPackage.Rank == "Gold" ? 1 :
							  x.AdsPackage.Rank == "Silver" ? 2 : 3)
				.ThenByDescending(x => x.AdsPackage.StartDate)
				.Select(x => x.Advertisement)
				.ToListAsync();
		}

		public async Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSortedAdmin()
		{
			return await dbContext.Advertisements
				.Join(dbContext.AdsPackages,
					ad => ad.AdId,
					ap => ap.AdId,
					(ad, ap) => new AdvertisementWithPackageDTO
					{
						AdId = ad.AdId,
						Heading = ad.Heading,
						Image = ad.Image,
						Link = ad.Link,
						UserId = ad.UserId,
						ElementId = ad.ElementId,
						Status = ad.Status,
						Rank = ap.Rank,
						StartDate = ap.StartDate,   
						ExpiredDate = ap.ExpiredDate,
						Quantity = ap.Quantity,
						Total = ap.Total,
						CreateAt = ap.CreateAt 
					})
				.OrderBy(x => x.Rank == "Diamond" ? 0 :
							  x.Rank == "Gold" ? 1 :
							  x.Rank == "Silver" ? 2 : 3)
				.ThenByDescending(x => x.StartDate)
				.ToListAsync();
		}
		public async Task<List<AdvertisementWithPackageDTO>> GetAdvertisementsWithPackageSorted()
		{
			var now = DateTime.Now;
			return await dbContext.Advertisements
				.Join(dbContext.AdsPackages,
					ad => ad.AdId,
					ap => ap.AdId,
					(ad, ap) => new AdvertisementWithPackageDTO
					{
						AdId = ad.AdId,
						Heading = ad.Heading,
						Image = ad.Image,
						Link = ad.Link,
						UserId = ad.UserId,
						ElementId = ad.ElementId,
						Status = ad.Status,
						Rank = ap.Rank,
						StartDate = ap.StartDate,
						ExpiredDate = ap.ExpiredDate,
						Quantity = ap.Quantity,
						Total = ap.Total,
						CreateAt = ap.CreateAt
					})
				.Where(x => x.StartDate <= now && x.ExpiredDate >= now && x.Status == "Approved")
				.OrderBy(x => x.Rank == "Diamond" ? 0 :
							  x.Rank == "Gold" ? 1 :
							  x.Rank == "Silver" ? 2 : 3)
				.ThenByDescending(x => x.StartDate)
				.ToListAsync();
		}
		public async Task<List<Advertisement>> GetAdvertisementByUserID(string userdID)

        {
            return await dbContext.Advertisements
                .Where(m => m.UserId.Equals(userdID))
                .ToListAsync();
        }
        

            public async Task<List<Advertisement>> GetAdvertisementStatus(string status)
        {
            return await dbContext.Advertisements.Where(m => m.Status.Equals(status)).ToListAsync();
        }

        public async Task<List<Advertisement>> GetAdvertisementByUserIdAndStatus(string userId, string status)
        {
            return await dbContext.Advertisements.Where(m => m.UserId.Equals(userId) && m.Status.Equals(status)).ToListAsync();
        }

        public async Task<bool> AddAdvertisement(Advertisement advertisement)
        {
            try
            {
                await dbContext.Advertisements.AddAsync(advertisement);
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> DeleteAdvertisement(string adID)
        {
            try
            {
                var advertisement = await GetAdvertisementByAdID(adID);
                if (advertisement != null)
                {
                    dbContext.Advertisements.Remove(advertisement);
                    await dbContext.SaveChangesAsync();
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> UpdateAdvertisement(Advertisement updatedAdvertisement)
        {
            bool isSuccess = false;

            try
            {
                var advertisement = await GetAdvertisementByAdID(updatedAdvertisement.AdId);
                if (advertisement != null)
                {
                    advertisement.Heading = updatedAdvertisement.Heading;
                    advertisement.Image = updatedAdvertisement.Image;
                    advertisement.Link = updatedAdvertisement.Link;
                    advertisement.Status = updatedAdvertisement.Status;
                    advertisement.ElementId = updatedAdvertisement.ElementId;
                    dbContext.Entry(advertisement).State = EntityState.Modified;
                    await dbContext.SaveChangesAsync();
                    isSuccess = true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }

        public async Task<List<Advertisement>> GetExpiredAdvertisements()
        {
            return await dbContext.Advertisements
                .Where(a => (a.Status == "Approved" || a.Status =="Pending") && a.AdsPackages.Any(ap => ap.ExpiredDate < DateTime.Now))
                .ToListAsync();
        }
    }
}


