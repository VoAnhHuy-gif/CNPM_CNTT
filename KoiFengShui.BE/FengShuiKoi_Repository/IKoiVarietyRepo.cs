using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IKoiVarietyRepo
    {
        Task<KoiVariety> GetKoiVarietyByType(string type);
        Task<List<KoiVariety>> GetKoiVarieties();
        Task<List<KoiVariety>> GetKoiVarietiesByElemnet(string element);
        Task<bool> AddKoiVariety(KoiVariety variety);
        Task<bool> DeleteKoiVariety(string type);
        Task<bool> UpdateKoiVariety(KoiVariety updatedKoi);
    }
}