using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IAdsPackageService
    {

		    Task<AdsPackage> GetAdsPackageByAdIDRankTime(string AdID, string Rank, DateTime CreateAt);

        Task<List<AdsPackage>> GetListAdsPackageByAdID(string AdID);
        Task<List<AdsPackage>> GetListAdsPackageByRank(string Rank);
        Dictionary<string, double> GetRevenueByPackage();
        Task<List<AdsPackage>> GetAdsPackages();
        Task<bool> AddAdsPackage(AdsPackage ads);
        Task<bool> UpdateAdsPackage(AdsPackage newAdsPackage);
        Task<AdsPackage> GetAdsPackageByAdID(string AdID);
		Task<bool> DeleteAdsPackage(string AdID, string Rank, DateTime CreateAt);
     Dictionary<string, double> GetTotalRevenueByMonth(int year);
        Dictionary<string, double> GetDailyRevenueToDate(int year, int month, int day);
    }
}