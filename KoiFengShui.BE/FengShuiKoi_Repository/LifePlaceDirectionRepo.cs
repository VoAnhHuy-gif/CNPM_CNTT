using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class LifePlaceDirectionRepo : ILifePlaceDirectionRepo
    {
        public async Task<LifePalaceDirection> GetLifePlaceDirectionById(string lifePalace, string direction) => await LifePlaceDirectionDAO.Instance.GetLifePlaceDirectionById(lifePalace, direction);

        public async Task<List<LifePalaceDirection>> GetLifePlaceDirections() => await LifePlaceDirectionDAO.Instance.GetLifePlaceDirections();

        public async Task<bool> AddLifePlaceDirection(LifePalaceDirection lifePlaceDirection) => await LifePlaceDirectionDAO.Instance.AddLifePlaceDirection(lifePlaceDirection);

        public async Task<bool> DeleteLifePlaceDirection(string lifePalace, string direction) => await LifePlaceDirectionDAO.Instance.DeleteLifePlaceDirection(lifePalace, direction);

        public async Task<bool> UpdateLifePlaceDirection(LifePalaceDirection lifePlaceDirection) => await LifePlaceDirectionDAO.Instance.UpdateLifePlaceDirection(lifePlaceDirection);

        public async Task<List<(string EightMansions, string Description)>> GetEightMansionsAndDescriptions() => await LifePlaceDirectionDAO.Instance.GetEightMansionsAndDescriptions();

        public async Task<List<LifePalaceDirection>> GetGoodDirectionByLifePalace(string LifePalace) => await LifePlaceDirectionDAO.Instance.GetGoodDirectionByLifePalace(LifePalace);
    }
}