using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;

namespace FengShuiKoi_Services
{
    public class LifePlaceService : ILifePlaceService
    {
        private ILifePlaceRepo lifePlaceRepo;

        public LifePlaceService()
        {
            lifePlaceRepo = new LifePlaceRepo();
        }

        public async Task<LifePalace> GetLifePlaceById(string id) => await lifePlaceRepo.GetLifePlaceById(id);

        public async Task<List<LifePalace>> GetLifePlaces() => await lifePlaceRepo.GetLifePlaces();

        public async Task<bool> AddLifePlace(LifePalace lifePlace) => await lifePlaceRepo.AddLifePlace(lifePlace);

        public async Task<bool> DeleteLifePlace(string id) => await lifePlaceRepo.DeleteLifePlace(id);

        public async Task<bool> UpdateLifePlace(LifePalace lifePlace) => await lifePlaceRepo.UpdateLifePlace(lifePlace);

      

        public  string CalculateFate(int birthYear, string Gender)
		{
			int sum = 0;
			while (birthYear > 0)
			{
				sum += birthYear % 10;  
				birthYear /= 10;       
			}
			int result = sum % 9;
			if (result == 0) result = 9;

			string[] maleFates = { "", "Khảm", "Ly", "Cấn", "Đoài", "Càn", "Khôn", "Tốn", "Chấn", "Khôn" };
			string[] femaleFates = { "", "Cấn", "Càn", "Đoài", "Cấn", "Ly", "Khảm", "Khôn", "Chấn", "Tốn" };

			if (Gender.Equals("Male"))
			{
				return maleFates[result];
			}
			else
			{
				return femaleFates[result];
			}
		}
	}
}