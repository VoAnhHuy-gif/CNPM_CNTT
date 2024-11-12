using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class KoiVarietyService : IKoiVarietyService
    {
        private IKoiVarietyRepo ikoiVarietyRepo;

        public KoiVarietyService()
        {
            ikoiVarietyRepo = new KoiVarietyRepo();
        }

        public async Task<bool> AddKoiVariety(KoiVariety variety) => await ikoiVarietyRepo.AddKoiVariety(variety);

        public async Task<bool> DeleteKoiVariety(string type) => await ikoiVarietyRepo.DeleteKoiVariety(type);

        public async Task<List<KoiVariety>> GetKoiVarieties() => await ikoiVarietyRepo.GetKoiVarieties();

        public async Task<List<KoiVariety>> GetKoiVarietiesByElemnet(string element) => await ikoiVarietyRepo.GetKoiVarietiesByElemnet(element);

        public async Task<KoiVariety> GetKoiVarietyByType(string type) => await ikoiVarietyRepo.GetKoiVarietyByType(type);

        public async Task<bool> UpdateKoiVariety(KoiVariety updatedKoi) => await ikoiVarietyRepo.UpdateKoiVariety(updatedKoi);
    }
}