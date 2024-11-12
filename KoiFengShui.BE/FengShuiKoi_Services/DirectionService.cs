using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class DirectionService : IDirectionService
    {
        private IDirectionRepo directionRepo;

        public DirectionService()
        {
            directionRepo = new DirectionRepo();
        }

        public async Task<Direction> GetDirectionById(string id) => await directionRepo.GetDirectionById(id);

        public async Task<List<Direction>> GetDirections() => await directionRepo.GetDirections();

        public async Task<bool> AddDirection(Direction direction) => await directionRepo.AddDirection(direction);

        public async Task<bool> DeleteDirection(string id) => await directionRepo.DeleteDirection(id);

        public async Task<bool> UpdateDirection(Direction direction) => await directionRepo.UpdateDirection(direction);
    }
}