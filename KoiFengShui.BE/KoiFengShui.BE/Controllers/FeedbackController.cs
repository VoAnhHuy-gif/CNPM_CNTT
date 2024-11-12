using FengShuiKoi_BO;
using FengShuiKoi_Services;
using KoiFengShui.BE.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FeedbackController : ControllerBase
    {
        private readonly IAdvertisementService _advertisementService;
        private readonly IFeedbackService _feedBackService;
        private readonly IAccountService _accountService;
        public FeedbackController(IFeedbackService feedbackService, IAccountService accountService, IAdvertisementService advertisementService)
        {
            _feedBackService = feedbackService;
            _accountService = accountService;
            _advertisementService = advertisementService;
        }

        [HttpGet("GetAllFeedBack")]
        public async Task<IActionResult> GetAllFeedBack()
        {
           
            try
            {
                var feedback = await _feedBackService.GetAllFeedbacks(); 
                    return Ok(feedback);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }
        [HttpGet("GetFeedbackByFbID")]
        public async Task<IActionResult> GetFeedbackByFbID(string FbID)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(FbID))
                {
                    return BadRequest("Vui lòng điền FeedBackID");
                }
                var fb = await _feedBackService.GetFeedbackByFeedbackID(FbID);

                if (fb == null)
                {
                    return BadRequest("Không tìm thấy Feedback.");
                }

                return Ok(fb);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }
        
        
        [HttpGet("GetFeedBackByAdId")]
        public async Task<IActionResult> GetFeedBackByAdId(string AdId)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(AdId))
                {
                    return BadRequest("Vui lòng điền Ad ID");
                }
               
                if (await _advertisementService.GetAdvertisementByAdID(AdId) == null)
                {
                    return BadRequest("Không tìm thấy quảng cáo này.");
                }
                var feedback = await _feedBackService.GetFeedbackByAdId(AdId);


                return Ok(feedback);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }
        [HttpGet("GetFeedBackByUserId")]
        public async Task<IActionResult> GetFeedBackByUserId(string UserId)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(UserId))
                {
                    return BadRequest("Vui lòng điền Ad ID");
                }
                if (await _accountService.GetAccountByUserID(UserId) == null)
                {
                    return BadRequest("Không tìm thấy ID của người dùng.");
                }
               
                var feedback = await _feedBackService.GetFeedbackByUserID(UserId);


                return Ok(feedback);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }



        [HttpPost("AddFeedback")]
        public async Task<IActionResult> AddFeedback(FeedbackDTO feedback)
        {
            if (string.IsNullOrWhiteSpace(feedback.Description))
            {
                return BadRequest("Vui lòng điền nội dung feedback");
            }
            if (string.IsNullOrWhiteSpace(feedback.UserId))
            {
                return BadRequest("Vui lòng điền UserId ");
            }
            if (string.IsNullOrWhiteSpace(feedback.AdId))
            {
                return BadRequest("Vui lòng điền AdId ");
            }
            if (await _accountService.GetAccountByUserID(feedback.UserId) == null)
            {
                return BadRequest("Không tìm thấy ID của người dùng.");
            }
            if (await _advertisementService.GetAdvertisementByAdID(feedback.AdId) == null)
            {
                return BadRequest("Không tìm thấy quảng cáo này.");
            }
            if(feedback.Rate < 1 ||  feedback.Rate > 5)
            {
                return BadRequest("Đánh giá sai mức độ phù hợp.");
            }
            try
            {
                string newFbId = await GenerateNewFbId();
                feedback.FbId = newFbId;
                var _fb = new Feedback
                {
                    FbId = feedback.FbId,
                    AdId = feedback.AdId,
                    Description = feedback.Description,
                    UserId = feedback.UserId,
                    Rate = feedback.Rate,
                };
                bool result = await _feedBackService.AddFeedback(_fb);

                if (result)
                {
                    return Ok(feedback);
                }
                else
                {
                    return BadRequest("Thêm feedback thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }

        [HttpDelete("DeleteFeedBack/{FbID}")]
        public async Task<IActionResult> DelDeleteFeedBacketeBlog(string FbID)
        {
            try
            {
                var fb = await _feedBackService.GetFeedbackByFeedbackID(FbID);
                if (fb == null)
                {
                    return BadRequest("Không tìm thấy feedback ");
                }

                var result = await _feedBackService.DeleteFeedback(FbID);

                if (result)
                {
                    return Ok("Xóa feedback thành công");
                }
                else
                {
                    return BadRequest("Xóa feedback thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }

        private async Task<string> GenerateNewFbId()
        {
            string lastFbId = await _feedBackService.GetLastFBId();

            if (string.IsNullOrEmpty(lastFbId))
            {
                return "FB001";
            }
            else
            {
                int lastNumber = int.Parse(lastFbId.Substring(2));
                return $"FB{(lastNumber + 1):D3}";
            }
        }
    }
}
