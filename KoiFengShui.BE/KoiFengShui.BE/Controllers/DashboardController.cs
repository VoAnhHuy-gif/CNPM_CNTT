using FengShuiKoi_Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DashboardController : ControllerBase
    {
        private readonly IAdsPackageService _adsPackageService;
        private readonly IMemberService _memberService;
        private readonly IAdvertisementService _advertisementService;
        private readonly IKoiVarietyService _koiVarietyService;

        public DashboardController(IAdsPackageService adsPackageService, IMemberService memberService, IAdvertisementService advertisementService, IKoiVarietyService koiVarietyService)
        {
            _adsPackageService = adsPackageService;
            _memberService = memberService;
            _advertisementService = advertisementService;
            _koiVarietyService = koiVarietyService;
        }

        [HttpGet("RevenueByPackage")]
        public async Task<IActionResult> GetRevenueByPackage()
        {
            try
            {
                var RevenueByPackage =  _adsPackageService.GetRevenueByPackage();
                if (RevenueByPackage == null || !RevenueByPackage.Any())
                {
                    return NotFound("Không tìm thấy dữ liệu doanh thu");
                }
                return Ok(RevenueByPackage);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpGet("UsersByAgeGroup")]
        public async Task<IActionResult> GetUsersByAgeGroup()
        {
            try
            {
                var usersByAgeGroup = await _memberService.GetUsersByAgeGroup();
                if (usersByAgeGroup == null)
                {
                    return NotFound("Không tìm thấy user");
                }
                return Ok(usersByAgeGroup);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
        [HttpGet("GetTotalRevenueByMonth")]
        public IActionResult GetTotalRevenueByMonth(int year)
        {
            try
            {   if (year >= 1754)
                {
                    var GetTotal = _adsPackageService.GetTotalRevenueByMonth(year);
                    return Ok(GetTotal);
                }
                else
                {
                    return BadRequest("Tại Năm này chưa có dữ liệu !");
                }
               
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server nội bộ: {ex.Message}");
            }
        }
        [HttpGet("GetDailyRevenueToDate")]
        public IActionResult GetDailyRevenueToDate(int year, int month, int day)
        {
            try
            {
                
                

                var getTotal =  _adsPackageService.GetDailyRevenueToDate(year, month, day);
                return Ok(getTotal);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server nội bộ: {ex.Message}");
            }
        }
    }
}