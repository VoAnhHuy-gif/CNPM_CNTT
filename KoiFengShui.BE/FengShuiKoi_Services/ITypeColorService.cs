using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface ITypeColorService
    {
        Task<TypeColor> GetPercentage(string color, string type);
        Task<TypeColor> GetTypeByColorID(string colorId);
        Task<List<TypeColor>> GetAllType();
        Task<List<TypeColor>> GetTypeByColor(string color);
        Task<List<TypeColor>> GetColorsAndPercentages(string koiType);
        Task<bool> DeleteTypeColorByColorId(string colorId);
        Task<bool> DeleteTypeColorByKoiType(string KoiType);
        Task<bool> AddKoiTypeColor(TypeColor koiFish);
        Task<List<TypeColor>> GetTypeByKoiType(string KoiType);
    }
}