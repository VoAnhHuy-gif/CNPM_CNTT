using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class FeedbackDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static FeedbackDAO instance = null;

        public static FeedbackDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new FeedbackDAO();
                }
                return instance;
            }
        }

        public FeedbackDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Feedback> GetFeedbackByFeedbackID(string feedbackId)
        {
            return await dbContext.Feedbacks.SingleOrDefaultAsync(f => f.FbId.Equals(feedbackId));
        }

        public async Task<List<Feedback>> GetFeedbackByUserID(string userId)
        {
            return await dbContext.Feedbacks.Where(f => f.UserId.Equals(userId)).ToListAsync();
        }
        public async Task<List<Feedback>> GetFeedbackByAdId(string AdId)
        {
            return await dbContext.Feedbacks.Where(f => f.AdId.Equals(AdId)).ToListAsync();
        }
     

        public async Task<List<Feedback>> GetFeedbacks()
        {
            return await dbContext.Feedbacks.ToListAsync();
        }

        public async Task<bool> AddFeedback(Feedback feedback)
        {
            bool isSuccess = false;
            Feedback _fb = await this.GetFeedbackByFeedbackID(feedback.FbId);
            try
            {
                if (_fb == null)
                {
                    await dbContext.Feedbacks.AddAsync(feedback);
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

        public async Task<bool> DeleteFeedback(string feedbackId)
        {
            var feedback = await GetFeedbackByFeedbackID(feedbackId);
            try
            {
                if (feedback != null)
                {
                    dbContext.Feedbacks.Remove(feedback);
                    await dbContext.SaveChangesAsync();
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return false;
        }

        public async Task<bool> UpdateFeedback(string feedbackId)
        {
            var feedback = await GetFeedbackByFeedbackID(feedbackId);
            try
            {
                if (feedback != null)
                {
                    dbContext.Entry<Feedback>(feedback).State = EntityState.Modified;
                    await dbContext.SaveChangesAsync();
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return false;
        }
        public async Task<string> GetLastFBId()
        {
            var lastfeedback = await dbContext.Feedbacks
                .OrderByDescending(b => b.FbId)
                .FirstOrDefaultAsync();

            return lastfeedback?.FbId;
        }
    }
}