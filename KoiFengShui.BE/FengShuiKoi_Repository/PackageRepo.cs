using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class PackageRepo : IPackageRepo
    {
        public async Task<Package> GetPackageByRank(string rank) => await PackageDAO.Instance.GetPackageByRank(rank);

        public async Task<List<Package>> GetPackages() => await PackageDAO.Instance.GetPackages();

        public async Task<bool> AddPackage(Package package) => await PackageDAO.Instance.AddPackage(package);

        public async Task<bool> DeletePackage(string rank) => await PackageDAO.Instance.DeletePackage(rank);

        public async Task<bool> UpdatePackage(Package package) => await PackageDAO.Instance.UpdatePackage(package);
    }
}