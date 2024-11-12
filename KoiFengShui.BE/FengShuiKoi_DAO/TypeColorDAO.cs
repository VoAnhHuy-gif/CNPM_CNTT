using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class TypeColorDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static TypeColorDAO instance = null;

        public static TypeColorDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new TypeColorDAO();
                }
                return instance;
            }
        }

        public TypeColorDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<TypeColor> GetPercentage(string color, string type)
        {
            return await dbContext.TypeColors.SingleOrDefaultAsync(m => m.Color.Equals(color) && m.KoiType.Equals(type));
        }

        public async Task<List<TypeColor>> GetAllType()
        {
            return await dbContext.TypeColors.ToListAsync();
        }

        public async Task<List<TypeColor>> GetColorsAndPercentages(string koiType)
        {
            var allTypes = await this.GetAllType();
            return allTypes.Where(item => item.KoiType == koiType).ToList();
        }

        public async Task<TypeColor> GetTypeByColorID(string colorId)
        {
            return await dbContext.TypeColors.FirstOrDefaultAsync(tc => tc.ColorId == colorId);
        }

        public async Task<List<TypeColor>> GetTypeByColor(string color)
        {
            var allTypes = await this.GetAllType();
            return allTypes.Where(item => item.ColorId == color).ToList();
        }

        public async Task<List<TypeColor>> GetTypeByKoiType(string KoiType)
        {
            var allTypes = await this.GetAllType();
            return allTypes.Where(item => item.KoiType == KoiType).ToList();
        }

        public async Task<bool> DeleteTypeColorsByColorId(string colorId)
        {
            try
            {
                var colorsToRemove = await dbContext.TypeColors
                    .Where(tc => tc.ColorId == colorId)
                    .ToListAsync();

                if (colorsToRemove.Any())
                {
                    var koiTypesToRemove = colorsToRemove.Select(tc => tc.KoiType).Distinct().ToList();

                    var typeKoisToRemove = await dbContext.TypeColors
                        .Where(tk => koiTypesToRemove.Contains(tk.KoiType))
                        .ToListAsync();

                    dbContext.TypeColors.RemoveRange(typeKoisToRemove);
                    dbContext.TypeColors.RemoveRange(colorsToRemove);
                    await dbContext.SaveChangesAsync();
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw new Exception($"Đã xảy ra lỗi khi xóa màu và loại Koi: {ex.Message}", ex);
            }
        }

        public async Task<bool> DeleteTypeColorsByKoiType(string koiType)
        {
            try
            {
                var typeColorsToDelete = await dbContext.TypeColors
                    .Where(tc => tc.KoiType == koiType)
                    .ToListAsync();

                if (typeColorsToDelete.Any())
                {
                    dbContext.TypeColors.RemoveRange(typeColorsToDelete);
                    await dbContext.SaveChangesAsync();
                    return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public async Task<bool> AddKoiTypeColor(TypeColor koiFish)
        {
            try
            {
                if (koiFish == null)
                {
                    return false;
                }

                var koiTypeColor = new TypeColor
                {
                    KoiType = koiFish.KoiType,
                    ColorId = koiFish.ColorId,
                    Percentage = koiFish.Percentage
                };

                await dbContext.TypeColors.AddAsync(koiTypeColor);
                await dbContext.SaveChangesAsync();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}