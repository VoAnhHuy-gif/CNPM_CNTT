using FengShuiKoi_BO;
using FengShuiKoi_Services;
using KoiFengShui.BE.Attributes;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Reflection.Metadata;
using System.Threading.Tasks;

namespace KoiFengShui.BE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BlogController : ControllerBase
    {
        private readonly IBlogService _blogService;
        public BlogController(IBlogService blogService)
        {
            _blogService = blogService;
        }

        [HttpGet("GetAllBlog")]
        public async Task<IActionResult> GetAllBlog()
        {
            List<Blog> blogs = new List<Blog>();
            try
            {
                blogs = await _blogService.GetBlogs();

                return Ok(blogs);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request.");
            }
        }

        [HttpGet("GetBlogByID")]
        public async Task<IActionResult> GetBlogByID(string blog)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(blog))
                {
                    return BadRequest("Vui lòng điền BlogID");
                }
                var blogs = await _blogService.GetBlogByID(blog);

                if (blogs == null)
                {
                    return BadRequest("Không tìm thấy Blog phù hợp");
                }

                return Ok(blogs);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request.");
            }
        }
       
        
        [HttpPut("UpdateBlog")]
        public async Task<IActionResult> UpdateBlog(Blog blog)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(blog.BlogId))
                {
                    return BadRequest("Vui lòng điền BlogID");
                }
                if (string.IsNullOrWhiteSpace(blog.Heading))
                {
                    return BadRequest("Vui lòng điền Heading cho Blog");
                }
                if (string.IsNullOrWhiteSpace(blog.Status))
                {
                    return BadRequest("Vui lòng điền Status cho Blog");
                }
                if (string.IsNullOrWhiteSpace(blog.Link))
                {
                    return BadRequest("Vui lòng điền Link cho Blog");
                }
                if (string.IsNullOrWhiteSpace(blog.Image))
                {
                    return BadRequest("Vui lòng điền file Image cho Blog");
                }
                var blogs = await _blogService.GetBlogByID(blog.BlogId);
                if (blogs == null)
                {
                    return BadRequest("Không tìm thấy Blog phù hợp");
                }
                bool result = await _blogService.UpdateBlog(blog);

                if (result)
                {
                    return Ok("Cập nhật thành công.");
                }
                else
                {
                    return BadRequest("Cập nhật thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request.");
            }
        }

        [HttpPost("AddBlog")]
        public async Task<IActionResult> AddBlog(Blog blog)
        {
            if (string.IsNullOrWhiteSpace(blog.Heading))
            {
                return BadRequest("Vui lòng điền Heading cho Blog");
            }
            if (string.IsNullOrWhiteSpace(blog.Status))
            {
                return BadRequest("Vui lòng điền Status cho Blog");
            }
            if (string.IsNullOrWhiteSpace(blog.Link))
            {
                return BadRequest("Vui lòng điền Link cho Blog");
            }
            if (string.IsNullOrWhiteSpace(blog.Image))
            {
                return BadRequest("Vui lòng điền file Image cho Blog");
            }
            try
            {
                string newBlogId = await GenerateNewBlogId();
                blog.BlogId = newBlogId;

                bool result = await _blogService.AddBlog(blog);

                if (result)
                {
                    return CreatedAtAction(nameof(GetBlogByID), new { id = blog.BlogId }, blog);
                }
                else
                {
                    return BadRequest("Thêm blog thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }

        [HttpDelete("DeleteBlog/{blogID}")]
        public async Task<IActionResult> DeleteBlog(string blogID)
        {
            try
            {
                var blogs = await _blogService.GetBlogByID(blogID);
                if (blogs == null)
                {
                    return BadRequest("Không tìm thấy Blog phù hợp");
                }

                var result = await _blogService.DeleteBlog(blogID);

                if (result)
                {
                    return Ok("Xóa Blog thành công");
                }
                else
                {
                    return BadRequest("Xóa blog thất bại");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.");
            }
        }

        private async Task<string> GenerateNewBlogId()
        {
            string lastBlogId = await _blogService.GetLastBlogId();

            if (string.IsNullOrEmpty(lastBlogId))
            {
                return "BL001";
            }
            else
            {
                int lastNumber = int.Parse(lastBlogId.Substring(2));
                return $"BL{(lastNumber + 1):D3}";
            }
        }
    }
}