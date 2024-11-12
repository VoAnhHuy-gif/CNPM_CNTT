using FengShuiKoi_Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ElementMutualismController : ControllerBase
    {
        private readonly IElementService _elementService;

        public ElementMutualismController(IElementService elementService)
        {
            _elementService = elementService;
        }

        [HttpGet("element")]
        public async Task<IActionResult> GetElementByBirthYear(int birthYear)
        {
            try
            {
                var element =  _elementService.GetElementByBirthYear(birthYear);
                return Ok(element);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpGet("Mutualism")]
        public async Task<IActionResult> GetMutualismByElement(string e)
        {
            try
            {
                var element = await _elementService.GetElementAndMutualism(e);
                return Ok(element);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
    }
}