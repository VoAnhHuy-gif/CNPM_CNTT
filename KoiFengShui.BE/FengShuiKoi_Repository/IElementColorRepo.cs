using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IElementColorRepo
    {
        Task<ElementColor> GetElementColorById(string element, string color);
        Task<List<ElementColor>> GetElementColors();
        Task<bool> AddElementColor(ElementColor elementColor);
        Task<bool> DeleteElementColor(string element, string color);
        Task<bool> UpdateElementColor(ElementColor elementColor);
        Task<float> GetPointElementColor(string element, string color);
        Task<ElementColor> GetElementColorByColorId(string color);
        Task<bool> DeleteElementColorByColorId(string color);
    }
}