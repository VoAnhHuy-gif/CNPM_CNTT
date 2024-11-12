using FengShuiKoi_BO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IBlogRepo
    {
        Task<bool> AddBlog(Blog Blog);

        Task<bool> DeleteBlog(string BlogID);

        Task<string> GetLastBlogId();

        Task<bool> UpdateBlog(Blog Blog);

        Task<Blog> GetBlogByID(string BlogID);

        Task<List<Blog>> GetBlogs();
    }
}