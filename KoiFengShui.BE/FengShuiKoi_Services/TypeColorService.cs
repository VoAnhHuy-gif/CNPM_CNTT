using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using FengShuiKoi_Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class TypeColorService : ITypeColorService
    {
        private ITypeColorRepo iTypeColorRepo;

        public TypeColorService()
        {
            iTypeColorRepo = new TypeColorRepo();
        }

        public async Task<List<TypeColor>> GetAllType() => await iTypeColorRepo.GetAllType();
        public async Task<TypeColor> GetTypeByColorID(string colorId) => await iTypeColorRepo.GetTypeByColorID(colorId);
        public async Task<TypeColor> GetPercentage(string color, string type) => await iTypeColorRepo.GetPercentage(color, type);
        public async Task<bool> DeleteTypeColorByColorId(string colorId) => await iTypeColorRepo.DeleteTypeColorByColorId(colorId);
        public async Task<bool> DeleteTypeColorByKoiType(string KoiType) => await iTypeColorRepo.DeleteTypeColorByKoiType(KoiType);
        public async Task<List<TypeColor>> GetTypeByColor(string color) => await iTypeColorRepo.GetTypeByColor(color);
        public async Task<bool> AddKoiTypeColor(TypeColor koiFish) => await iTypeColorRepo.AddKoiTypeColor(koiFish);
        public async Task<List<TypeColor>> GetColorsAndPercentages(string koiType) => await iTypeColorRepo.GetColorsAndPercentages(koiType);
        public async Task<List<TypeColor>> GetTypeByKoiType(string KoiType) => await iTypeColorRepo.GetTypeByKoiType(KoiType);
    }
}