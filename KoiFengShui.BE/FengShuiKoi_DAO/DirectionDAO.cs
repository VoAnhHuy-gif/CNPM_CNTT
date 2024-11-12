using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class DirectionDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static DirectionDAO instance = null;
        public static DirectionDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new DirectionDAO();
                }
                return instance;
            }
        }

        public DirectionDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Direction> GetDirectionById(string id)
        {
            return await dbContext.Directions.SingleOrDefaultAsync(d => d.DirectionId == id);
        }

        public async Task<List<Direction>> GetDirections()
        {
            return await dbContext.Directions.ToListAsync();
        }

        public async Task<bool> AddDirection(Direction direction)
        {
            bool isSuccess = false;
            Direction existingDirection = await this.GetDirectionById(direction.DirectionId);
            try
            {
                if (existingDirection == null)
                {
                    await dbContext.Directions.AddAsync(direction);
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

        public async Task<bool> DeleteDirection(string id)
        {
            bool isSuccess = false;
            Direction direction = await this.GetDirectionById(id);
            try
            {
                if (direction != null)
                {
                    dbContext.Directions.Remove(direction);
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

        public async Task<bool> UpdateDirection(Direction direction)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<Direction>(direction).State = EntityState.Modified;
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