using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class ElementDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static ElementDAO instance = null;

        public static ElementDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new ElementDAO();
                }
                return instance;
            }
        }

        public ElementDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Element> GetElementAndMutualism(string element)
        {
            return await dbContext.Elements.SingleOrDefaultAsync(m => m.ElementId.Equals(element));
        }

        public async Task<List<Element>> GetElement()
        {
            return await dbContext.Elements.ToListAsync();
        }
    }
}