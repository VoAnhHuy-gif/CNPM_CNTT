using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using FengShuiKoi_Repository;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class AdsPackageService : IAdsPackageService
    {
        private IAdsPackageRepo iAdsPackageRepo;
        public AdsPackageService()
        {
            iAdsPackageRepo = new AdsPackageRepo();
        }
        public async Task<bool> AddAdsPackage(AdsPackage ads)
        {
            return await iAdsPackageRepo.AddAdsPackage(ads);
        }
        public  Dictionary<string, double> GetRevenueByPackage()
        {
            return  iAdsPackageRepo.GetRevenueByPackage();
        }

        public async Task<bool> DeleteAdsPackage(string AdID, string Rank, DateTime CreateAt)
        {
            return await iAdsPackageRepo.DeleteAdsPackage(AdID, Rank, CreateAt);
        }
		public async Task<AdsPackage> GetAdsPackageByAdID(string AdID) => await iAdsPackageRepo.GetAdsPackageByAdID(AdID);

		public async Task<AdsPackage> GetAdsPackageByAdIDRankTime(string AdID, string Rank, DateTime CreateAt)
        {
            return await iAdsPackageRepo.GetAdsPackageByAdIDRankTime(AdID, Rank, CreateAt);
        }

        public async Task<List<AdsPackage>> GetAdsPackages()
        {
            return await iAdsPackageRepo.GetAdsPackages();
        }

        public async Task<List<AdsPackage>> GetListAdsPackageByAdID(string AdID)
        {
            return await iAdsPackageRepo.GetListAdsPackageByAdID(AdID);
        }
        public async Task<List<AdsPackage>> GetListAdsPackageByRank(string Rank)
        {
            return await iAdsPackageRepo.GetListAdsPackageByRank(Rank);
        }
        public async Task<bool> UpdateAdsPackage(AdsPackage newAdsPackage)
        {
            return await iAdsPackageRepo.UpdateAdsPackage(newAdsPackage);
        }
        public Dictionary<string, double> GetTotalRevenueByMonth(int year)
        {
            return  iAdsPackageRepo.GetTotalRevenueByMonth(year);
        }
         public Dictionary<string, double> GetDailyRevenueToDate(int year, int month, int day) =>  iAdsPackageRepo.GetDailyRevenueToDate(year,month,day);
    }
}