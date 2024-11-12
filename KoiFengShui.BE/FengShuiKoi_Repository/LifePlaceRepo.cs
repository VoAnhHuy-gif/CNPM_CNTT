using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class LifePlaceRepo : ILifePlaceRepo
    {
        public async Task<LifePalace> GetLifePlaceById(string id) => await LifePlaceDAO.Instance.GetLifePlaceById(id);

        public async Task<List<LifePalace>> GetLifePlaces() => await LifePlaceDAO.Instance.GetLifePlaces();

        public async Task<bool> AddLifePlace(LifePalace lifePlace) => await LifePlaceDAO.Instance.AddLifePlace(lifePlace);

        public async Task<bool> DeleteLifePlace(string id) => await LifePlaceDAO.Instance.DeleteLifePlace(id);

        public async Task<bool> UpdateLifePlace(LifePalace lifePlace) => await LifePlaceDAO.Instance.UpdateLifePlace(lifePlace);
    }
}