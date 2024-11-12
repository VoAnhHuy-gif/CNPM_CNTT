using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class PointOfShapeDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static PointOfShapeDAO instance = null;
        public static PointOfShapeDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new PointOfShapeDAO();
                }
                return instance;
            }
        }

        public PointOfShapeDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<PointOfShape> GetPointOfShape(string element, string shape)
        {
            return await dbContext.PointOfShapes.FirstOrDefaultAsync(p => p.ElementId == element && p.ShapeId == shape);
        }
        public async Task<PointOfShape> GetPointOfShapeByShapeID(string shape)
        {
            return await dbContext.PointOfShapes.FirstOrDefaultAsync(p => p.ShapeId == shape);
        }

        public async Task<List<PointOfShape>> GetPointOfShapes()
        {
            return await dbContext.PointOfShapes.ToListAsync();
        }

        public async Task<bool> AddPointOfShape(PointOfShape pointOfShape)
        {
            bool isSuccess = false;
            PointOfShape existingPointOfShape = await this.GetPointOfShape(pointOfShape.ElementId, pointOfShape.ElementId);
            try
            {
                if (existingPointOfShape == null)
                {
                    await dbContext.PointOfShapes.AddAsync(pointOfShape);
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

        public async Task<bool> DeletePointOfShape(string element, string shape)
        {
            bool isSuccess = false;
            PointOfShape pointOfShape = await this.GetPointOfShape(element, shape);
            try
            {
                if (pointOfShape != null)
                {
                    dbContext.PointOfShapes.Remove(pointOfShape);
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
        public async Task<bool> DeletePointOfShapeByShapeID(string shapeID)
        {
            try
            {
                var pointsToRemove = await dbContext.PointOfShapes
                    .Where(pos => pos.ShapeId == shapeID)
                    .ToListAsync();

                if (pointsToRemove.Any())
                {
                    dbContext.PointOfShapes.RemoveRange(pointsToRemove);

                    var shapeToRemove = await dbContext.Shapes
                        .FirstOrDefaultAsync(s => s.ShapeId == shapeID);

                    if (shapeToRemove != null)
                    {
                        dbContext.Shapes.Remove(shapeToRemove);
                    }

                    var elementShapesToRemove = await dbContext.PointOfShapes
                        .Where(es => es.ShapeId == shapeID)
                        .ToListAsync();

                    if (elementShapesToRemove.Any())
                    {
                        dbContext.PointOfShapes.RemoveRange(elementShapesToRemove);
                    }

                    await dbContext.SaveChangesAsync();
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw new Exception($"Đã xảy ra lỗi khi xóa Shape và các thực thể liên quan: {ex.Message}", ex);
            }
        }

        public async Task<bool> UpdatePointOfShape(PointOfShape pointOfShape)
        {
            bool isSuccess = false;
            try
            {
                dbContext.Entry<PointOfShape>(pointOfShape).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                await dbContext.SaveChangesAsync();
                isSuccess = true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }

        public async Task<List<PointOfShape>> GetGoodShapeByElemnet(string element)
        {
            var allShapes = await this.GetPointOfShapes();
            return allShapes.Where(item => item.Point >= 0.75 && item.ElementId.Equals(element)).ToList();
        }
    }
}