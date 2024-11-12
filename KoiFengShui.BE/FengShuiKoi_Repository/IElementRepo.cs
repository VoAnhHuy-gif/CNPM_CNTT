using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IElementRepo
    {
        Task<Element> GetElementAndMutualism(string element);
        Task<List<Element>> GetElement();
    }
}