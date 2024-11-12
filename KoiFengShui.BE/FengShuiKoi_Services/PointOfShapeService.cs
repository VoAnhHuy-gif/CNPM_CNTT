using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class PointOfShapeService : IPointOfShapeService
    {
        private IPointOfShapeRepo pointOfShapeRepo;

        public PointOfShapeService()
        {
            pointOfShapeRepo = new PointOfShapeRepo();
        }

        public async Task<PointOfShape> GetPointOfShape(string element, string shape) => await pointOfShapeRepo.GetPointOfShape(element, shape);

        public async Task<List<PointOfShape>> GetPointOfShapes() => await pointOfShapeRepo.GetPointOfShapes();

        public async Task<bool> AddPointOfShape(PointOfShape pointOfShape) => await pointOfShapeRepo.AddPointOfShape(pointOfShape);

        public async Task<bool> DeletePointOfShape(string element, string shape) => await pointOfShapeRepo.DeletePointOfShape(element, shape);

        public async Task<bool> UpdatePointOfShape(PointOfShape pointOfShape) => await pointOfShapeRepo.UpdatePointOfShape(pointOfShape);
        public async Task<PointOfShape> GetPointOfShapeByShapeID(string shape) => await pointOfShapeRepo.GetPointOfShapeByShapeID(shape);
        public async Task<bool> DeletePointOfShapeByShapeID(string shapeID) => await pointOfShapeRepo.DeletePointOfShapeByShapeID(shapeID);
        public async Task<List<PointOfShape>> GetGoodShapeByElemnet(string element) => await pointOfShapeRepo.GetGoodShapeByElemnet(element);
    }
}