using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class BlogRepo : IBlogRepo
    {
        public async Task<bool> AddBlog(Blog Blog)
            => await BlogDAO.Instance.AddBlog(Blog);

        public async Task<bool> DeleteBlog(string BlogID)
            => await BlogDAO.Instance.DeleteBlog(BlogID);

        public async Task<string> GetLastBlogId()
            => await BlogDAO.Instance.GetLastBlogId();

        public async Task<Blog> GetBlogByID(string BlogID)
            => await BlogDAO.Instance.GetBlogByBlogID(BlogID);

        public async Task<List<Blog>> GetBlogs()
            => await BlogDAO.Instance.GetBlogs();

        public async Task<bool> UpdateBlog(Blog BlogID)
            => await BlogDAO.Instance.UpdateBlog(BlogID);
    }
}