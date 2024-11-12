using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IElementService
    {
        Task<Element> GetElementAndMutualism(string element);
        string GetElementByBirthYear(int birthYear);
        Task<List<Element>> GetElement();
    }
}