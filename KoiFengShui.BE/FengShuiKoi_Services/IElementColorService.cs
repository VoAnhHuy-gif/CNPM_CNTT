using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IElementColorService
    {
        Task<ElementColor> GetElementColorById(string element, string color);
        Task<List<ElementColor>> GetElementColors();
        Task<bool> AddElementColor(ElementColor elementColor);
        Task<bool> DeleteElementColor(string element, string color);
        Task<bool> UpdateElementColor(ElementColor elementColor);
        Task<ElementColor> GetElementColorByColorId(string color);
        Task<bool> DeleteElementColorByColorId(string color);
        Task<float> GetPointElementColor(string element, string color);
    }
}