using FengShuiKoi_BO;
using FengShuiKoi_Services;
using KoiFengShui.BE.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Principal;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PackageController : ControllerBase
    {
        private readonly IPackageService _packageService;
        private readonly IAdsPackageService _adsPackageService;
        private readonly IAdvertisementService _advertisementService;

        public PackageController(IPackageService packageService, IAdvertisementService advertisementService, IAdsPackageService adsPackageService)
        {
            _packageService = packageService;
            _adsPackageService = adsPackageService;
            _advertisementService = advertisementService;
        }

        [HttpGet("GetAllPackage")]
        public async Task<IActionResult> GetAllPackage()
        {
            try
            {
                var listPackage = await _packageService.GetPackages();
                return Ok(listPackage);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpPost("AddPackage")]
        public async Task<IActionResult> AddPackage(PackageDTO packageDto)
        {
            try
            {
                if (await _packageService.GetPackageByRank(packageDto.Rank) != null)
                {
                    return BadRequest("Gói này đã tồn tại");
                }

                var package = new Package
                {
                    Rank = packageDto.Rank,
                    Duration = packageDto.Duration,
                    Description = packageDto.Description,
                    Price = packageDto.Price
                };

                bool result = await _packageService.AddPackage(package);

                if (result)
                {
                    return Ok("Tạo gói thành công");
                }
                else
                {
                    return BadRequest("Tạo gói thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        [HttpPut("UpdatePackage")]
        public async Task<IActionResult> UpdatePackage(PackageDTO packageDto)
        {
            try
            {
                var existingPackage = await _packageService.GetPackageByRank(packageDto.Rank);
                if (existingPackage == null)
                {
                    return NotFound("Không tìm thấy gói phù hợp");
                }

                existingPackage.Duration = packageDto.Duration;
                existingPackage.Description = packageDto.Description;
                existingPackage.Price = packageDto.Price;

                bool result = await _packageService.UpdatePackage(existingPackage);
                if (result)
                {
                    return Ok("Cập nhật gói thành công");
                }
                else
                {
                    return BadRequest("Cập nhật gói thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }

        private IActionResult CheckPackageExpiration(List<AdsPackage> listAdsPackage)
        {
            DateTime currentTime = DateTime.Now;

            foreach (var ads in listAdsPackage)
            {
                if (ads.ExpiredDate > currentTime)
                {
                    return BadRequest("Không thể xóa gói vì nó chứa các tin đăng chưa hết hạn");
                }
            }

            return null;
        }

        [HttpDelete("DeletePackage/{rank}")]
        public async Task<IActionResult> DeletePackage(string rank)
        {
            try
            {
                List<Advertisement> listAdsvertisement = new List<Advertisement>();
                List<AdsPackage> ListAdsPackage = await _adsPackageService.GetListAdsPackageByRank(rank);

                foreach (var advertisement in ListAdsPackage)
                {
                    Advertisement advertise = await _advertisementService.GetAdvertisementByAdID(advertisement.AdId);
                    if (advertise != null)
                    {
                        listAdsvertisement.Add(advertise);
                    }
                }

                IActionResult expirationCheck = CheckPackageExpiration(ListAdsPackage);
                if (expirationCheck != null)
                {
                    return expirationCheck;
                }
                else
                {
                    foreach (var ads in ListAdsPackage)
                    {
                        await _adsPackageService.DeleteAdsPackage(ads.AdId, rank,ads.CreateAt);
                    }
                    foreach (var advertise in listAdsvertisement)
                    {
                        await _advertisementService.DeleteAdvertisement(advertise.AdId);
                    }
                    bool result = await _packageService.DeletePackage(rank);
                    if (result)
                    {
                        return Ok("Xóa gói thành công");
                    }
                    else
                    {
                        return BadRequest("Xóa gói thất bại");
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi máy chủ: {ex.Message}");
            }
        }
    }
}