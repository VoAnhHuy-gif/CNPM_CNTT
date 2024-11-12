using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface ILifePlaceDirectionService
    {
        Task<LifePalaceDirection> GetLifePlaceDirectionById(string lifePalace, string direction);
        Task<List<LifePalaceDirection>> GetLifePlaceDirections();
        Task<bool> AddLifePlaceDirection(LifePalaceDirection lifePlaceDirection);
        Task<bool> DeleteLifePlaceDirection(string lifePalace, string direction);
        Task<bool> UpdateLifePlaceDirection(LifePalaceDirection lifePlaceDirection);
        Task<List<(string EightMansions, string Description)>> GetEightMansionsAndDescriptions();
        Task<List<LifePalaceDirection>> GetGoodDirectionByLifePalace(string LifePalace);
    }
}