using FengShuiKoi_BO;
using FengShuiKoi_Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ElementController : ControllerBase
    {
        private readonly IElementService _elementService;
        public ElementController(IElementService elementService)
        {
            _elementService = elementService;
        }

        [HttpGet("GetAllElement")]
        public async Task<IActionResult> GetAllElement()
        {
            try
            {
                List<Element> listElement = await _elementService.GetElement();
                return Ok(listElement);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
    }
}