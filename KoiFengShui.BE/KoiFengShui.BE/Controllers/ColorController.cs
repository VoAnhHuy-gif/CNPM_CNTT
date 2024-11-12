using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using FengShuiKoi_Services;
using KoiFengShui.BE.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using static KoiFengShui.BE.Controllers.CompatibilityController;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ColorController : ControllerBase
    {
        private readonly IColorService _colorService;
        private readonly IElementColorService _elementColorService;
        private readonly ITypeColorService _typeColorService;
        private readonly IElementService _elementService;
        public ColorController(IColorService colorService, IElementColorService elementColorService, ITypeColorService typeColorService, IElementService elementService)
        {
            _colorService = colorService;
            _elementColorService = elementColorService;
            _typeColorService = typeColorService;
            _elementService = elementService;
        }

        [HttpGet("GetAllColor")]
        public async Task<IActionResult> GetAllColor()
        {
            List<Color> listColor = new List<Color>();

            try
            {
                listColor = await _colorService.GetColors();

                return Ok(listColor);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }

        public class Element_Color
        {
            public string ColorID { get; set; }
            public List<ElementPoint> ElementPoint { get; set; }
        }

        public class ElementPoint
        {
            public string ElementID { get; set; }
            public double Point { get; set; }
        }

        [HttpPost("AddColorAndElement")]
        public async Task<IActionResult> AddColorAndElement(Element_Color colorDto)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(colorDto.ColorID))
                {
                    return BadRequest("Vui lòng nhập mã màu!");
                }

                if (colorDto.ElementPoint == null || colorDto.ElementPoint.Count == 0)
                {
                    return BadRequest("Vui lòng nhập điểm cho các bản mệnh!");
                }

                if (await _colorService.GetColorById(colorDto.ColorID) != null)
                {
                    return BadRequest("Màu này đã tồn tại.");
                }

                var newColor = new Color
                {
                    ColorId = colorDto.ColorID
                };
                bool result = await _colorService.AddColor(newColor);
                if (!result)
                {
                    return BadRequest("Thêm màu mới thất bại");
                }

                foreach (var elementPoint in colorDto.ElementPoint)
                {
                    if (elementPoint.Point < 0.25 || elementPoint.Point > 1)
                    {
                        return BadRequest($"Điểm cho bản mệnh {elementPoint.ElementID} phải nằm trong khoảng 0.25 đến 1.");
                    }

                    if (await _elementService.GetElementAndMutualism(elementPoint.ElementID) == null)
                    {
                        return BadRequest($"Không tìm thấy bản mệnh: {elementPoint.ElementID}.");
                    }

                    var newElementColor = new ElementColor
                    {
                        ColorId = colorDto.ColorID,
                        ElementId = elementPoint.ElementID,
                        ColorPoint = elementPoint.Point
                    };

                    bool result2 = await _elementColorService.AddElementColor(newElementColor);
                    if (!result2)
                    {
                        return BadRequest($"Thêm ElementColor thất bại cho ElementID: {elementPoint.ElementID}");
                    }
                }

                if (result)
                {
                    return Ok(new { Message = "Tạo màu và điểm bản mệnh thành công", ColorID = colorDto.ColorID, ElementPoints = colorDto.ElementPoint });
                }
                else
                {
                    return BadRequest("Tạo màu và điểm bản mệnh thất bại");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in AddColorAndElement: {ex.Message}");
                return StatusCode(500, "Lỗi server. Vui lòng thử lại sau.");
            }
        }

        [HttpDelete("DeleteColor/{colorId}")]
        public async Task<IActionResult> DeleteColor(string colorId)
        {
            try
            {
                var existingcolorId = await _colorService.GetColorById(colorId);
                if (existingcolorId == null)
                {
                    return NotFound("Không tìm thấy màu tương ứng.");
                }
                bool result3 = false;
                var existingElementColor = await _elementColorService.GetElementColorByColorId(colorId);
                if (existingElementColor != null)
                {
                    result3 = await _elementColorService.DeleteElementColorByColorId(colorId);
                }
                bool result2 = false;
                var existingTypeColors = await _typeColorService.GetTypeByColor(colorId);
                if (existingTypeColors != null && existingTypeColors.Any())
                {
                    result2 = await _typeColorService.DeleteTypeColorByColorId(colorId);
                }
                bool result = await _colorService.DeleteColor(colorId);

                if (result)
                {
                    return Ok("Xóa Màu thành công");
                }
                else
                {
                    return BadRequest("Xóa Màu thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        }
    }
}