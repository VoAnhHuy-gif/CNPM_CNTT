using FengShuiKoi_BO;
using FengShuiKoi_Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Reflection;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PondController : ControllerBase
    {
        private readonly IPointOfShapeService _pointOfShapeService;
        private readonly IShapeService _shapeService;
        private readonly IElementService _elementService;
        private readonly LunarCalendarConverter _lunarCalendarConverter;
        private readonly ILifePlaceDirectionService _lifePlaceDirectionService;
        private readonly ILifePlaceService _lifePlaceService;

        public PondController(IPointOfShapeService pointOfShapeService, IShapeService shapeService, IElementService elementService, LunarCalendarConverter lunarCalendarConverter, ILifePlaceDirectionService lifePlaceDirectionService, ILifePlaceService lifePlaceService)
        {
            _pointOfShapeService = pointOfShapeService;
            _shapeService = shapeService;
            _elementService = elementService;
            _lunarCalendarConverter = lunarCalendarConverter;
            _lifePlaceDirectionService = lifePlaceDirectionService;
            _lifePlaceService = lifePlaceService;
        }

        [HttpGet("GetGoodShapeByDOB")]
        public async Task<IActionResult> GetShapeOfPondByElement(string dob)
        {
            List<Shape> listPond = new List<Shape>();
            int year = int.Parse(dob.Substring(0, 4));
            try
            {
                string element =  _elementService.GetElementByBirthYear(year);
                var listShape = await _pointOfShapeService.GetGoodShapeByElemnet(element);
                foreach (PointOfShape shape in listShape)
                {
                    Shape pond = await _shapeService.GetShapeById(shape.ShapeId);
                    if (pond != null)
                    {
                        listPond.Add(pond);
                    }
                }
                return Ok(listPond);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpGet("GetGoodDirectionByDOB")]
        public async Task<IActionResult> GetDirectionOfPondByElement(string dob, string Gender)
        {
            string Life_Palace = "";
            try
            {
                int[] lunarDate = await Task.Run(() => LunarCalendarConverter.ConvertSolarToLunar(dob, 7));
                if (lunarDate == null)
                {
                    return BadRequest("Không thể tính toán ngày âm lịch cho ngày đã nhập.");
                }
                else
                {
                    int lunarYear = lunarDate[2];
                    Life_Palace =  _lifePlaceService.CalculateFate(lunarYear, Gender);
                }
                var listdirection = await _lifePlaceDirectionService.GetGoodDirectionByLifePalace(Life_Palace);
                return Ok(listdirection);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
        [HttpPut("UpdatePondImg")]
        public async Task<IActionResult> UpdatePondImg(string shapeID, string img)
        {
            try
            {
                var updatePond = await _shapeService.GetShapeById(shapeID);
                if (updatePond == null)
                {
                    return BadRequest("Không tìm thấy hình dạng hồ");
                }
                else
                {
                    bool isSuccess = await _shapeService.UpdateShapeImg(shapeID, img);
                    if (isSuccess)
                    {
                        return Ok("Cập nhật hồ thành công");
                    }
                    else
                    {
                        return BadRequest("Cập nhật hồ thất bại");
                    }
                }
            }catch (Exception ex) 
                {
                    return StatusCode(500,$"Lỗi máy chủ: {ex.Message}");
                }
        }
    }
}