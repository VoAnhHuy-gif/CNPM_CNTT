using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class BlogService : IBlogService
    {
        private IBlogRepo blogRepo;
        public BlogService()
        {
            blogRepo = new BlogRepo();
        }
        public async Task<bool> AddBlog(Blog Blog)
        {
            return await blogRepo.AddBlog(Blog);
        }

        public async Task<bool> DeleteBlog(string BlogID)
        {
            return await blogRepo.DeleteBlog(BlogID);
        }

        public async Task<Blog> GetBlogByID(string BlogID)
        {
            return await blogRepo.GetBlogByID(BlogID);
        }

        public async Task<List<Blog>> GetBlogs()
        {

            return await blogRepo.GetBlogs();
        }

        public async Task<string> GetLastBlogId()
            => await blogRepo.GetLastBlogId();

        
        
public async Task<bool> UpdateBlog(Blog BlogID)
        {
            return await blogRepo.UpdateBlog(BlogID);
        }
    }
}