using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class QuantityOfFishRepo : IQuantityOfFishRepo
    {
        public async Task<QuantityOfFish> getQuantityByElement(string element) => await QuantityOfFishDAO.Instance.getQuantityByElement(element);
    }
}