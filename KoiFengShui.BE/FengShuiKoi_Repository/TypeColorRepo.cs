using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class TypeColorRepo : ITypeColorRepo
    {
        public async Task<List<TypeColor>> GetAllType() => await TypeColorDAO.Instance.GetAllType();

        public async Task<List<TypeColor>> GetColorsAndPercentages(string koiType) => await TypeColorDAO.Instance.GetColorsAndPercentages(koiType);
        public async Task<TypeColor> GetPercentage(string color, string type) => await TypeColorDAO.Instance.GetPercentage(color, type);
        public async Task<TypeColor> GetTypeByColorID(string colorId) => await TypeColorDAO.Instance.GetTypeByColorID(colorId);
        public async Task<List<TypeColor>> GetTypeByColor(string color) => await TypeColorDAO.Instance.GetTypeByColor(color);
        public async Task<bool> DeleteTypeColorByColorId(string colorId) => await TypeColorDAO.Instance.DeleteTypeColorsByColorId(colorId);
        public async Task<bool> AddKoiTypeColor(TypeColor koiFish) => await TypeColorDAO.Instance.AddKoiTypeColor(koiFish);
        public async Task<bool> DeleteTypeColorByKoiType(string KoiType) => await TypeColorDAO.Instance.DeleteTypeColorsByKoiType(KoiType);
        public async Task<List<TypeColor>> GetTypeByKoiType(string KoiType) => await TypeColorDAO.Instance.GetTypeByKoiType(KoiType);
    }
}