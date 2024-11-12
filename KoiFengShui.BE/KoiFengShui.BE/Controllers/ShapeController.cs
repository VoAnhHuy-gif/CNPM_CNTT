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
    public class ShapeController : ControllerBase
    {
        private readonly IPointOfShapeService _pointOfShapeService;
        private readonly IShapeService _shapeService;
        private readonly IElementService _elementService;

        public ShapeController(IPointOfShapeService pointOfShapeService, IShapeService shapeService, IElementService elementService)
        {
            _pointOfShapeService = pointOfShapeService;
            _shapeService = shapeService;
            _elementService = elementService;
        }

        [HttpGet("GetAllShape")]
        public async Task<IActionResult> GetAllShape()
        {
            try
            {
                var listShape = await _shapeService.GetShapes();
                return Ok(listShape);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpGet("GetShapeById")]
        public async Task<IActionResult> GetShapeById(string shapeID)
        {
            try
            {
                var shape = await _shapeService.GetShapeById(shapeID);
                if (shapeID == null)
                {
                    return NotFound("Không tìm thấy quảng cáo");
                }
                return Ok(shape);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpPut("UpdateShape")]
        public async Task<IActionResult> UpdateShape(ShapeDTO shape)
        {
            try
            {
                var existingShape = await _shapeService.GetShapeById(shape.ShapeId);
                if (existingShape == null)
                {
                    return NotFound("Không tìm thấy hồ cá");
                }
                if (string.IsNullOrWhiteSpace(shape.Image))
                {
                    return BadRequest("Vui lòng nhập hình ảnh.");
                }

                existingShape.Image = shape.Image;

                bool result = await _shapeService.UpdateShape(existingShape);
                if (result)
                {
                    return Ok("Cập nhật hồ thành công");
                }
                else
                {
                    return BadRequest("Cập nhật hồ thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpPost("AddShape")]
        public async Task<IActionResult> AddShape(ShapeDTO shape)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(shape.ShapeId))
                {
                    return BadRequest("Vui lòng nhập hình dạng.");
                }

                if (string.IsNullOrWhiteSpace(shape.Image))
                {
                    return BadRequest("Vui lòng nhập hình ảnh.");
                }

                if (await _shapeService.GetShapeById(shape.ShapeId) != null)
                {
                    return BadRequest("Hình dạng này đã tồn tại.");
                }

                if (await _shapeService.GetShapeByImg(shape.Image) != null)
                {
                    return BadRequest("Hình ảnh này đã tồn tại.");
                }

                var _shape = new Shape
                {
                    ShapeId = shape.ShapeId,
                    Image = shape.Image,
                };

                bool result = await _shapeService.AddShape(_shape);
                if (result)
                {
                    return Ok(new { Message = "Tạo hồ cá thành công", ShapeId = shape.ShapeId, Image = shape.Image });
                }
                else
                {
                    return BadRequest("Tạo màu thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpDelete("DeleteShape/{ShapeId}")]
        public async Task<IActionResult> DeleteShape(string ShapeId)
        {
            try
            {
                var existingShape = await _shapeService.GetShapeById(ShapeId);
                if (existingShape == null)
                {
                    return NotFound("Không tìm thấy hồ");
                }

                bool pointsDeleted = await _pointOfShapeService.DeletePointOfShapeByShapeID(ShapeId);
                bool shapeDeleted = await _shapeService.DeleteShape(ShapeId);

                if (pointsDeleted || shapeDeleted)
                {
                    return Ok("Xóa hồ thành công");
                }
                else
                {
                    return BadRequest("Không có dữ liệu nào được xóa");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
    }
}