using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface ILifePlaceService
    {
        Task<LifePalace> GetLifePlaceById(string id);
        Task<List<LifePalace>> GetLifePlaces();
        Task<bool> AddLifePlace(LifePalace lifePlace);
        Task<bool> DeleteLifePlace(string id);
        Task<bool> UpdateLifePlace(LifePalace lifePlace);

        string CalculateFate(int birthYear, string Gender);
    }
}