using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class ElementColorRepo : IElementColorRepo
    {
        public async Task<ElementColor> GetElementColorById(string element, string color) => await ElementColorDAO.Instance.GetElementColorById(element, color);

        public async Task<List<ElementColor>> GetElementColors() => await ElementColorDAO.Instance.GetElementColors();

        public async Task<bool> AddElementColor(ElementColor elementColor) => await ElementColorDAO.Instance.AddElementColor(elementColor);

        public async Task<bool> DeleteElementColor(string element, string color) => await ElementColorDAO.Instance.DeleteElementColor(element, color);

        public async Task<bool> UpdateElementColor(ElementColor elementColor) => await ElementColorDAO.Instance.UpdateElementColor(elementColor);

        public async Task<float> GetPointElementColor(string element, string color) => await ElementColorDAO.Instance.GetPointElementColor(element, color);

        public async Task<ElementColor> GetElementColorByColorId(string color) => await ElementColorDAO.Instance.GetElementColorByColorId(color);

        public async Task<bool> DeleteElementColorByColorId(string color) => await ElementColorDAO.Instance.DeleteElementColorByColorId(color);
    }
}