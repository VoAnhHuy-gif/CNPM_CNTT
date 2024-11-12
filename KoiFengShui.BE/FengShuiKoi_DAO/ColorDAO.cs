using FengShuiKoi_BO;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class ColorDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static ColorDAO instance = null;
        public static ColorDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new ColorDAO();
                }
                return instance;
            }
        }

        public ColorDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Color> GetColorById(string id)
        {
            return await dbContext.Colors.FirstOrDefaultAsync(c => c.ColorId == id);
        }

        public async Task<List<Color>> GetColors()
        {
            return await dbContext.Colors.ToListAsync();
        }

        public async Task<bool> AddColor(Color color)
        {
            bool isSuccess = false;
            Color existingColor = await this.GetColorById(color.ColorId);
            try
            {
                if (existingColor == null)
                {
                    await dbContext.Colors.AddAsync(color);
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

        public async Task<bool> DeleteColor(string id)
        {
            bool isSuccess = false;
            Color color = await this.GetColorById(id);
            try
            {
                if (color != null)
                {
                    dbContext.Colors.Remove(color);
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

        public async Task<bool> UpdateColor(Color color)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<Color>(color).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
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