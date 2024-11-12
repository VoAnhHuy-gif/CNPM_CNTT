using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class KoiVarietyRepo : IKoiVarietyRepo
    {
        public async Task<bool> AddKoiVariety(KoiVariety variety) => await KoiVarietyDAO.Instance.AddKoiVariety(variety);

        public async Task<bool> DeleteKoiVariety(string type) => await KoiVarietyDAO.Instance.DeleteKoiVariety(type);

        public async Task<List<KoiVariety>> GetKoiVarieties() => await KoiVarietyDAO.Instance.GetKoiVarieties();

        public async Task<List<KoiVariety>> GetKoiVarietiesByElemnet(string element) => await KoiVarietyDAO.Instance.GetKoiVarietiesByElemnet(element);

        public async Task<KoiVariety> GetKoiVarietyByType(string type) => await KoiVarietyDAO.Instance.GetKoiVarietyByType(type);

        public async Task<bool> UpdateKoiVariety(KoiVariety updatedKoi) => await KoiVarietyDAO.Instance.UpdateKoiVariety(updatedKoi);
    }
}