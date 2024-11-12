using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class ElementColorService : IElementColorService
    {
        private IElementColorRepo elementColorRepo;

        public ElementColorService()
        {
            elementColorRepo = new ElementColorRepo();
        }

        public async Task<ElementColor> GetElementColorById(string element, string color) => await elementColorRepo.GetElementColorById(element, color);

        public async Task<List<ElementColor>> GetElementColors() => await elementColorRepo.GetElementColors();

        public async Task<bool> AddElementColor(ElementColor elementColor) => await elementColorRepo.AddElementColor(elementColor);

        public async Task<bool> DeleteElementColor(string element, string color) => await elementColorRepo.DeleteElementColor(element, color);

        public async Task<bool> UpdateElementColor(ElementColor elementColor) => await elementColorRepo.UpdateElementColor(elementColor);

        public async Task<float> GetPointElementColor(string element, string color) => await elementColorRepo.GetPointElementColor(element, color);

        public async Task<ElementColor> GetElementColorByColorId(string color) => await elementColorRepo.GetElementColorByColorId(color);

        public async Task<bool> DeleteElementColorByColorId(string color) => await elementColorRepo.DeleteElementColorByColorId(color);
    }
}