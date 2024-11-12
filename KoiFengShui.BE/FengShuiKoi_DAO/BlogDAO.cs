using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class BlogDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static BlogDAO instance = null;
        public static BlogDAO Instance
        {
            get
            {
                //singleton design pattern
                if (instance == null)
                {
                    instance = new BlogDAO();
                }
                return instance;
            }
        }
        public BlogDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }
        public async Task<Blog> GetBlogByBlogID(string BlogID)
        {
            return await dbContext.Blogs.SingleOrDefaultAsync(m => m.BlogId.Equals(BlogID));
        }

        public async Task<List<Blog>> GetBlogs()
        {
            return await dbContext.Blogs.ToListAsync();
        }

        public async Task<bool> AddBlog(Blog blog)
        {
            bool isSuccess = false;
            Blog _blog = await this.GetBlogByBlogID(blog.BlogId);
            try
            {
                if (_blog == null)
                {
                    await dbContext.Blogs.AddAsync(blog);
                    await dbContext.SaveChangesAsync();
                    isSuccess = true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }

        public async Task<bool> DeleteBlog(string BlogID)
        {
            bool isSuccess = false;
            Blog blog = await this.GetBlogByBlogID(BlogID);
            try
            {
                if (blog != null)
                {
                    dbContext.Blogs.Remove(blog);
                    await dbContext.SaveChangesAsync();
                    isSuccess = true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return isSuccess;
        }

        public async Task<bool> UpdateBlog(Blog updatedBlog)
        {
            if (updatedBlog == null)
            {
                return false;
            }

            try
            {
                var existingBlog = await dbContext.Blogs.FindAsync(updatedBlog.BlogId);
                if (existingBlog == null)
                {
                    return false;
                }

                dbContext.Entry(existingBlog).CurrentValues.SetValues(updatedBlog);

                int affectedRows = await dbContext.SaveChangesAsync();

                return affectedRows > 0;
            }
            catch (DbUpdateException ex)
            {
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public async Task<string> GetLastBlogId()
        {
            var lastBlog = await dbContext.Blogs
                .OrderByDescending(b => b.BlogId)
                .FirstOrDefaultAsync();

            return lastBlog?.BlogId;
        }
    }
}