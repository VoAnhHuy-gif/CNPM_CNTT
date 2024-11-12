using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class LifePlaceDirectionService : ILifePlaceDirectionService
    {
        private ILifePlaceDirectionRepo lifePlaceDirectionRepo;

        public LifePlaceDirectionService()
        {
            lifePlaceDirectionRepo = new LifePlaceDirectionRepo();
        }

        public async Task<LifePalaceDirection> GetLifePlaceDirectionById(string lifePalace, string direction) => await lifePlaceDirectionRepo.GetLifePlaceDirectionById(lifePalace, direction);

        public async Task<List<LifePalaceDirection>> GetLifePlaceDirections() => await lifePlaceDirectionRepo.GetLifePlaceDirections();

        public async Task<List<(string EightMansions, string Description)>> GetEightMansionsAndDescriptions() => await lifePlaceDirectionRepo.GetEightMansionsAndDescriptions();

        public async Task<bool> AddLifePlaceDirection(LifePalaceDirection lifePlaceDirection) => await lifePlaceDirectionRepo.AddLifePlaceDirection(lifePlaceDirection);

        public async Task<bool> DeleteLifePlaceDirection(string lifePalace, string direction) => await lifePlaceDirectionRepo.DeleteLifePlaceDirection(lifePalace, direction);

        public async Task<bool> UpdateLifePlaceDirection(LifePalaceDirection lifePlaceDirection) => await lifePlaceDirectionRepo.UpdateLifePlaceDirection(lifePlaceDirection);

        public async Task<List<LifePalaceDirection>> GetGoodDirectionByLifePalace(string LifePalace) => await lifePlaceDirectionRepo.GetGoodDirectionByLifePalace(LifePalace);
    }
}