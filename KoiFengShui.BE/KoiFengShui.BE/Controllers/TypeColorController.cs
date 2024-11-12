using FengShuiKoi_BO;
using FengShuiKoi_Services;
using KoiFengShui.BE.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TypeColorController : ControllerBase
    {
        private readonly IKoiVarietyService _koiVarietyService;
        private readonly IColorService _colorService;
        private readonly ITypeColorService _typeColorService;

        public TypeColorController(IKoiVarietyService koiVarietyService, IColorService colorService, ITypeColorService typeColorService)
        {
            _koiVarietyService = koiVarietyService;
            _colorService = colorService;
            _typeColorService = typeColorService;
        }

        [HttpGet("GetAllTypeColor")]
        public async Task<IActionResult> GetAllTypeColor()
        {
            try
            {
                var listType = await _typeColorService.GetAllType();
                return Ok(listType);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
    }
}