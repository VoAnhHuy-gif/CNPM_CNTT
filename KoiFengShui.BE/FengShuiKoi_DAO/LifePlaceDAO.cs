using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class LifePlaceDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static LifePlaceDAO instance = null;
        public static LifePlaceDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new LifePlaceDAO();
                }
                return instance;
            }
        }

        public LifePlaceDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<LifePalace> GetLifePlaceById(string id)
        {
            return await dbContext.LifePalaces.SingleOrDefaultAsync(lp => lp.LifePalaceId == id);
        }

        public async Task<List<LifePalace>> GetLifePlaces()
        {
            return await dbContext.LifePalaces.ToListAsync();
        }

        public async Task<bool> AddLifePlace(LifePalace lifePlace)
        {
            bool isSuccess = false;
            LifePalace existingLifePlace = await this.GetLifePlaceById(lifePlace.LifePalaceId);
            try
            {
                if (existingLifePlace == null)
                {
                    await dbContext.LifePalaces.AddAsync(lifePlace);
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

        public async Task<bool> DeleteLifePlace(string id)
        {
            bool isSuccess = false;
            LifePalace lifePlace = await this.GetLifePlaceById(id);
            try
            {
                if (lifePlace != null)
                {
                    dbContext.LifePalaces.Remove(lifePlace);
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

        public async Task<bool> UpdateLifePlace(LifePalace lifePlace)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<LifePalace>(lifePlace).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
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