using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class LifePlaceDirectionDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static LifePlaceDirectionDAO instance = null;
        public static LifePlaceDirectionDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new LifePlaceDirectionDAO();
                }
                return instance;
            }
        }

        public LifePlaceDirectionDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<LifePalaceDirection> GetLifePlaceDirectionById(string lifePalace, string direction)
        {
            return await dbContext.LifePalaceDirections.SingleOrDefaultAsync(lpd => lpd.LifePalaceId == lifePalace && lpd.DirectionId == direction);
        }

        public async Task<List<LifePalaceDirection>> GetLifePlaceDirections()
        {
            return await dbContext.LifePalaceDirections.ToListAsync();
        }

        public async Task<bool> AddLifePlaceDirection(LifePalaceDirection lifePlaceDirection)
        {
            bool isSuccess = false;
            LifePalaceDirection existingLifePlaceDirection = await this.GetLifePlaceDirectionById(lifePlaceDirection.LifePalaceId, lifePlaceDirection.DirectionId);
            try
            {
                if (existingLifePlaceDirection == null)
                {
                    await dbContext.LifePalaceDirections.AddAsync(lifePlaceDirection);
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

        public async Task<bool> DeleteLifePlaceDirection(string lifePalace, string direction)
        {
            bool isSuccess = false;
            LifePalaceDirection lifePlaceDirection = await this.GetLifePlaceDirectionById(lifePalace, direction);
            try
            {
                if (lifePlaceDirection != null)
                {
                    dbContext.LifePalaceDirections.Remove(lifePlaceDirection);
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

        public async Task<bool> UpdateLifePlaceDirection(LifePalaceDirection lifePlaceDirection)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<LifePalaceDirection>(lifePlaceDirection).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                await dbContext.SaveChangesAsync();
                isSuccess = true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }

        public async Task<List<LifePalaceDirection>> GetGoodDirectionByLifePalace(string LifePalace)
        {
            var allDirections = await this.GetLifePlaceDirections();
            return allDirections.Where(item => item.PointOfDirection == 1 && item.LifePalaceId.Equals(LifePalace)).ToList();
        }

        public async Task<List<(string EightMansions, string Description)>> GetEightMansionsAndDescriptions()
        {
            List<string> sortOrder = new List<string>
            {
                "Sinh khí", "Thiên y", "Diên niên", "Phục vị",
                "Tuyệt mệnh", "Ngũ quỷ", "Lục sát", "Họa hại"
            };

            Dictionary<string, string> uniquePairs = new Dictionary<string, string>();
            var allDirections = await this.GetLifePlaceDirections();

            foreach (LifePalaceDirection item in allDirections)
            {
                uniquePairs[item.EightMansions] = item.Description;
                if (uniquePairs.Count == 8)
                    break;
            }

            return sortOrder
                .Where(mansion => uniquePairs.ContainsKey(mansion))
                .Select(mansion => (mansion, uniquePairs[mansion]))
                .ToList();
        }
    }
}