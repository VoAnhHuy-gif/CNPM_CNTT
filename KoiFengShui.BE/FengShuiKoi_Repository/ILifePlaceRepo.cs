using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface ILifePlaceRepo
    {
        Task<LifePalace> GetLifePlaceById(string id);
        Task<List<LifePalace>> GetLifePlaces();
        Task<bool> AddLifePlace(LifePalace lifePlace);
        Task<bool> DeleteLifePlace(string id);
        Task<bool> UpdateLifePlace(LifePalace lifePlace);
    }
}