using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class ElementRepo : IElementRepo
    {
        public async Task<Element> GetElementAndMutualism(string element) => await ElementDAO.Instance.GetElementAndMutualism(element);

        public async Task<List<Element>> GetElement() => await ElementDAO.Instance.GetElement();
    }
}