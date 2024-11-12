using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class ShapeDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static ShapeDAO instance = null;
        public static ShapeDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new ShapeDAO();
                }
                return instance;
            }
        }

        public ShapeDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Shape> GetShapeById(string id)
        {
            return await dbContext.Shapes.FirstOrDefaultAsync(s => s.ShapeId == id);
        }
        public async Task<Shape> GetShapeByImg(string img)
        {
            return await dbContext.Shapes.FirstOrDefaultAsync(s => s.Image == img);
        }

        public async Task<List<Shape>> GetShapes()
        {
            return await dbContext.Shapes.ToListAsync();
        }

        public async Task<bool> AddShape(Shape shape)
        {
            bool isSuccess = false;
            Shape existingShape = await this.GetShapeById(shape.ShapeId);
            try
            {
                if (existingShape == null)
                {
                    await dbContext.Shapes.AddAsync(shape);
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

        public async Task<bool> DeleteShape(string id)
        {
            bool isSuccess = false;
            Shape shape = await this.GetShapeById(id);
            try
            {
                if (shape != null)
                {
                    dbContext.Shapes.Remove(shape);
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

        public async Task<bool> UpdateShape(Shape shape)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<Shape>(shape).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                await dbContext.SaveChangesAsync();
                isSuccess = true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }
		public async Task<bool> UpdateShapeImg(string shapeId, string Img)
		{
			try
			{
				var shape = await dbContext.Shapes.FindAsync(shapeId);

				if (shape == null)
				{
					return false;
				}
				shape.Image = Img;
				dbContext.Entry(shape).Property(x => x.Image).IsModified = true;
				await dbContext.SaveChangesAsync();

				return true;
			}
			catch (Exception ex)
			{
				throw new Exception($"Lỗi khi cập nhật ảnh Shape: {ex.Message}", ex);
			}
		}
	}
}