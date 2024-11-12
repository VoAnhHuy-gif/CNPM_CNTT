using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class DirectionRepo : IDirectionRepo
    {
        public async Task<Direction> GetDirectionById(string id) => await DirectionDAO.Instance.GetDirectionById(id);

        public async Task<List<Direction>> GetDirections() => await DirectionDAO.Instance.GetDirections();

        public async Task<bool> AddDirection(Direction direction) => await DirectionDAO.Instance.AddDirection(direction);

        public async Task<bool> DeleteDirection(string id) => await DirectionDAO.Instance.DeleteDirection(id);

        public async Task<bool> UpdateDirection(Direction direction) => await DirectionDAO.Instance.UpdateDirection(direction);
    }
}