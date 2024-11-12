using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IAdsPackageRepo
    {
        Task<AdsPackage> GetAdsPackageByAdIDRankTime(string AdID, string Rank, DateTime CreateAt);
	    Task<List<AdsPackage>> GetListAdsPackageByAdID(string AdID);
        Task<List<AdsPackage>> GetListAdsPackageByRank(string Rank);
        Task<AdsPackage> GetAdsPackageByAdID(string AdID);

		Task<List<AdsPackage>> GetAdsPackages();
        Task<bool> AddAdsPackage(AdsPackage ads);
        Task<bool> UpdateAdsPackage(AdsPackage newAdsPackage);
        Dictionary<string, double> GetRevenueByPackage();

		Task<bool> DeleteAdsPackage(string AdID, string Rank, DateTime CreateAt);
        Dictionary<string, double> GetTotalRevenueByMonth(int year);
        Dictionary<string, double> GetDailyRevenueToDate(int year, int month, int day);
    }
}