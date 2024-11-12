using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class QuantityOfFishDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static QuantityOfFishDAO instance = null;

        public static QuantityOfFishDAO Instance
        {
            get
            {
                //singleton design pattern
                if (instance == null)
                {
                    instance = new QuantityOfFishDAO();
                }
                return instance;
            }
        }

        public QuantityOfFishDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<QuantityOfFish> getQuantityByElement(string element)
        {
            return await dbContext.QuantityOfFishes.SingleOrDefaultAsync(m => m.ElementId.Equals(element));
        }
    }
}