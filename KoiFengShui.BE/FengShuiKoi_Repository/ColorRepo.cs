using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class ColorRepo : IColorRepo
    {
        public async Task<Color> GetColorById(string id) => await ColorDAO.Instance.GetColorById(id);

        public async Task<List<Color>> GetColors() => await ColorDAO.Instance.GetColors();

        public async Task<bool> AddColor(Color color) => await ColorDAO.Instance.AddColor(color);

        public async Task<bool> DeleteColor(string id) => await ColorDAO.Instance.DeleteColor(id);

        public async Task<bool> UpdateColor(Color color) => await ColorDAO.Instance.UpdateColor(color);
    }
}