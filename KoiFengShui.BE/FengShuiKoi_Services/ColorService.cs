using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class ColorService : IColorService
    {
        private IColorRepo colorRepo;

        public ColorService()
        {
            colorRepo = new ColorRepo();
        }

        public async Task<Color> GetColorById(string id) => await colorRepo.GetColorById(id);

        public async Task<List<Color>> GetColors() => await colorRepo.GetColors();

        public async Task<bool> AddColor(Color color) => await colorRepo.AddColor(color);

        public async Task<bool> DeleteColor(string id) => await colorRepo.DeleteColor(id);

        public async Task<bool> UpdateColor(Color color) => await colorRepo.UpdateColor(color);
    }
}