using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class PointOfShapeRepo : IPointOfShapeRepo
    {
        public async Task<PointOfShape> GetPointOfShape(string element, string shape) => await PointOfShapeDAO.Instance.GetPointOfShape(element, shape);

        public async Task<List<PointOfShape>> GetPointOfShapes() => await PointOfShapeDAO.Instance.GetPointOfShapes();

        public async Task<bool> AddPointOfShape(PointOfShape pointOfShape) => await PointOfShapeDAO.Instance.AddPointOfShape(pointOfShape);

        public async Task<bool> DeletePointOfShape(string element, string shape) => await PointOfShapeDAO.Instance.DeletePointOfShape(element, shape);
        public async Task<bool> DeletePointOfShapeByShapeID(string shapeID) => await PointOfShapeDAO.Instance.DeletePointOfShapeByShapeID(shapeID);
        public async Task<bool> UpdatePointOfShape(PointOfShape pointOfShape) => await PointOfShapeDAO.Instance.UpdatePointOfShape(pointOfShape);
        public async Task<PointOfShape> GetPointOfShapeByShapeID(string shape) => await PointOfShapeDAO.Instance.GetPointOfShapeByShapeID(shape);
        public async Task<List<PointOfShape>> GetGoodShapeByElemnet(string element) => await PointOfShapeDAO.Instance.GetGoodShapeByElemnet(element);
    }
}