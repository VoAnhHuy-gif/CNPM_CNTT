using FengShuiKoi_BO;
using FengShuiKoi_Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{   
    [Route("api/[controller]")]
    [ApiController]
    public class AdsPackageController : ControllerBase
    {
        private readonly IAdsPackageService _adsPackageService;

        public AdsPackageController(IAdsPackageService adsPackageService)
        {
            _adsPackageService = adsPackageService;
        }

        [HttpGet("GetAllAdsPackage")]
        public async Task<IActionResult> GetAllAdsPackage()
        {
            try
            {
                var list = await _adsPackageService.GetAdsPackages();
                if (list.Count != 0)
                {
                    return Ok(list);
                }
                else
                {
                    return BadRequest("Không có AdsPackage nào");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi server: {ex.Message}");
            }
        } 
    }
}