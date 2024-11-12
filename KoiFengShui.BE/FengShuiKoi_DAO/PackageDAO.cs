using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class PackageDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static PackageDAO instance = null;
        public static PackageDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new PackageDAO();
                }
                return instance;
            }
        }

        public PackageDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Package> GetPackageByRank(string rank)
        {
            return await dbContext.Packages.SingleOrDefaultAsync(p => p.Rank == rank);
        }

        public async Task<List<Package>> GetPackages()
        {
            return await dbContext.Packages.ToListAsync();
        }

        public async Task<bool> AddPackage(Package package)
        {
            bool isSuccess = false;
            Package existingPackage = await this.GetPackageByRank(package.Rank);
            try
            {
                if (existingPackage == null)
                {
                    await dbContext.Packages.AddAsync(package);
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

        public async Task<bool> DeletePackage(string rank)
        {
            bool isSuccess = false;
            Package package = await this.GetPackageByRank(rank);
            try
            {
                if (package != null)
                {
                    dbContext.Packages.Remove(package);
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

        public async Task<bool> UpdatePackage(Package package)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<Package>(package).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                await dbContext.SaveChangesAsync();
                isSuccess = true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }
    }
}