using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class ElementColorDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static ElementColorDAO instance = null;
        public static ElementColorDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new ElementColorDAO();
                }
                return instance;
            }
        }

        public ElementColorDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<ElementColor> GetElementColorById(string element, string color)
        {
            return await dbContext.ElementColors.SingleOrDefaultAsync(ec => ec.ElementId == element && ec.ColorId == color);
        }

        public async Task<ElementColor> GetElementColorByColorId(string color)
        {
            return await dbContext.ElementColors.FirstOrDefaultAsync(ec => ec.ColorId == color);
        }

        public async Task<bool> DeleteElementColorByColorId(string colorId)
        {
            try
            {
                var elementsToRemove = await dbContext.ElementColors
                    .Where(ec => ec.ColorId == colorId)
                    .ToListAsync();

                if (elementsToRemove.Any())
                {
                    dbContext.ElementColors.RemoveRange(elementsToRemove);
                    await dbContext.SaveChangesAsync();
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw new Exception($"An error occurred while deleting the element colors: {ex.Message}", ex);
            }
        }

        public async Task<List<ElementColor>> GetElementColors()
        {
            return await dbContext.ElementColors.ToListAsync();
        }

        public async Task<float> GetPointElementColor(string element, string color)
        {
            try
            {
                ElementColor existingElementColor = await this.GetElementColorById(element, color);

                if (existingElementColor != null)
                {
                    return (float)existingElementColor.ColorPoint;
                }

                return 0.0f;
            }
            catch (Exception ex)
            {
                throw new Exception($"An error occurred while getting the color point: {ex.Message}", ex);
            }
        }

        public async Task<bool> AddElementColor(ElementColor elementColor)
        {
            bool isSuccess = false;
            ElementColor existingElementColor = await this.GetElementColorById(elementColor.ElementId, elementColor.ColorId);
            try
            {
                if (existingElementColor == null)
                {
                    await dbContext.ElementColors.AddAsync(elementColor);
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

        public async Task<bool> DeleteElementColor(string element, string color)
        {
            bool isSuccess = false;
            ElementColor elementColor = await this.GetElementColorById(element, color);
            try
            {
                if (elementColor != null)
                {
                    dbContext.ElementColors.Remove(elementColor);
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

        public async Task<bool> UpdateElementColor(ElementColor elementColor)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<ElementColor>(elementColor).State = EntityState.Modified;
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