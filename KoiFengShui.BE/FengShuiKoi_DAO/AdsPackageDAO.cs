using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class AdsPackageDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;

        private static AdsPackageDAO instance = null;

        public static AdsPackageDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AdsPackageDAO();
                }
                return instance;
            }
        }
        public AdsPackageDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

         public Dictionary<string, double> GetRevenueByPackage()
        {
            try
            {
                dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
                var adsPackages = dbContext.AdsPackages.AsNoTracking().ToList();
                var revenueByPackage = new Dictionary<string, double>();

                foreach (var package in adsPackages)
                {
                    if (!revenueByPackage.ContainsKey(package.Rank))
                    {
                        revenueByPackage[package.Rank] = 0;
                    }
                    revenueByPackage[package.Rank] += package.Total;
                }
                return revenueByPackage;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi trong GetRevenueByPackage: {ex.Message}");
                return new Dictionary<string, double>();
            }
        }

        public async Task<List<AdsPackage>> GetAdsPackages()
        {
            return await dbContext.AdsPackages.ToListAsync();
        }

        public async Task<AdsPackage> GetAdsPackageByAdIDRankTime(string AdID, string Rank, DateTime CreateAt)
        {
            return await dbContext.AdsPackages.SingleOrDefaultAsync(m => m.AdId.Equals(AdID) && m.Rank.Equals(Rank) && m.CreateAt.Equals(CreateAt));
        }
        public async Task<AdsPackage> GetAdsPackageByAdID(string AdID) => await dbContext.AdsPackages.SingleOrDefaultAsync(m => m.AdId.Equals(AdID));

        public async Task<List<AdsPackage>> GetListAdsPackageByAdID(string AdID)
        {
            return await dbContext.AdsPackages.Where(m => m.AdId.Equals(AdID)).ToListAsync();
        }

        public async Task<List<AdsPackage>> GetListAdsPackageByRank(string Rank)
        {
            var now = DateTime.Now;
            return await dbContext.AdsPackages
                .Where(m => m.Rank.Equals(Rank) && m.StartDate <= now && m.ExpiredDate >= now)
                .OrderByDescending(m => m.StartDate)
                .ToListAsync();
        }

        public async Task<bool> AddAdsPackage(AdsPackage ads)
        {
            AdsPackage adsPackage = await this.GetAdsPackageByAdIDRankTime(ads.AdId, ads.Rank, ads.CreateAt);
            if (adsPackage != null) return false;

            try
            {
                await dbContext.AdsPackages.AddAsync(ads);
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> UpdateAdsPackage(AdsPackage newAdsPackage)
        {
            AdsPackage ads = await this.GetAdsPackageByAdIDRankTime(newAdsPackage.AdId, newAdsPackage.Rank, newAdsPackage.CreateAt);
            if (ads == null) return false;

            ads.StartDate = newAdsPackage.StartDate;
            ads.ExpiredDate = newAdsPackage.ExpiredDate;
            ads.Quantity = newAdsPackage.Quantity;
            ads.Total = newAdsPackage.Total;
            ads.CreateAt = newAdsPackage.CreateAt;

            try
            {
                dbContext.Entry(ads).State = EntityState.Modified;
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> DeleteAdsPackage(string AdID, string Rank, DateTime CreateAt)
        {
            AdsPackage ads = await this.GetAdsPackageByAdIDRankTime(AdID, Rank, CreateAt);
            if (ads == null) return false;

            try
            {
                dbContext.AdsPackages.Remove(ads);
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Dictionary<string, double> GetTotalRevenueByMonth(int year)
        {
            try
            {
                dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
                var totalRevenueByMonth = new Dictionary<string, double>();

                for (int month = 1; month <= 12; month++)
                {
                    var startDate = new DateTime(year, month, 1);
                    var endDate = startDate.AddMonths(1);

                    var monthlyRevenue = dbContext.AdsPackages
                        .Where(p => p.CreateAt >= startDate && p.CreateAt < endDate)
                        .Join(dbContext.Advertisements,
                              package => package.AdId,
                              advertisement => advertisement.AdId,
                              (package, advertisement) => new { package, advertisement })
                        .Where(x => x.advertisement.Status == "Approved" || x.advertisement.Status == "Expired" || x.advertisement.Status == "Pending")
                        .Sum(p => p.package.Total);

                    totalRevenueByMonth[$"{month}/{year}"] = monthlyRevenue;
                }
                return totalRevenueByMonth;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi trong LayDoanhThuTheoNam: {ex.Message}");
                return new Dictionary<string, double>(); // Return an empty dictionary in case of an error
            }
        }
        public Dictionary<string, double> GetDailyRevenueToDate(int year, int month, int day)
        {
            try
            {
                dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
                var specifiedDate = new DateTime(year, month, day);
                var startDate = specifiedDate.AddDays(-7); 
                var currentDate = specifiedDate; 

                var dailyRevenue =  dbContext.AdsPackages
                    .Join(dbContext.Advertisements,
                          package => package.AdId,
                          advertisement => advertisement.AdId,
                          (package, advertisement) => new { package, advertisement })
                    .Where(x => x.package.CreateAt.Date <= currentDate.Date &&
                                (x.advertisement.Status == "Approved" || x.advertisement.Status == "Expired" || x.advertisement.Status == "Pending"))
                    .GroupBy(x => x.package.CreateAt.Date)
                    .Select(g => new { Date = g.Key, TotalRevenue = g.Sum(p => p.package.Total) })
                    .OrderBy(x => x.Date)
                    .ToDictionary(x => x.Date.ToShortDateString(), x => x.TotalRevenue); 

             
                var result = new Dictionary<string, double>();
                for (var date = startDate; date <= currentDate.Date; date = date.AddDays(1))
                {
                    if (dailyRevenue.TryGetValue(date.ToShortDateString(), out double revenue))
                    {
                        result[date.ToShortDateString()] = revenue;
                    }
                    else
                    {
                        result[date.ToShortDateString()] = 0; 
                    }
                }

                return result; 
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi trong GetDailyRevenueFromSpecifiedDate: {ex.Message}");
                return new Dictionary<string, double>(); // Return an empty dictionary on error
            }
        }
    }
}
