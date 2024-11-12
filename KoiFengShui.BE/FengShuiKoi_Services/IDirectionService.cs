using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IDirectionService
    {
        Task<Direction> GetDirectionById(string id);
        Task<List<Direction>> GetDirections();
        Task<bool> AddDirection(Direction direction);
        Task<bool> DeleteDirection(string id);
        Task<bool> UpdateDirection(Direction direction);
    }
}