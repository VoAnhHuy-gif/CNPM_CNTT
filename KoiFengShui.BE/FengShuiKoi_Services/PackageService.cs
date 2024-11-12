using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class PackageService : IPackageService
    {
        private IPackageRepo packageRepo;

        public PackageService()
        {
            packageRepo = new PackageRepo();
        }

        public async Task<Package> GetPackageByRank(string rank) => await packageRepo.GetPackageByRank(rank);

        public async Task<List<Package>> GetPackages() => await packageRepo.GetPackages();

        public async Task<bool> AddPackage(Package package) => await packageRepo.AddPackage(package);

        public async Task<bool> DeletePackage(string rank) => await packageRepo.DeletePackage(rank);

        public async Task<bool> UpdatePackage(Package package) => await packageRepo.UpdatePackage(package);
    }
}