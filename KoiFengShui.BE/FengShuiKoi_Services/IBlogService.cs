using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IBlogService
    {
        Task<bool> AddBlog(Blog Blog);

        Task<bool> DeleteBlog(string BlogID);

        Task<Blog> GetBlogByID(string BlogID);

        Task<List<Blog>> GetBlogs();

        Task<string> GetLastBlogId();

        Task<bool> UpdateBlog(Blog BlogID);
    }
}