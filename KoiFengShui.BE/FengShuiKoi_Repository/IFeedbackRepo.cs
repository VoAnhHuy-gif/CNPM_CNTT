using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public interface IFeedbackRepo
    {
        Task<Feedback> GetFeedbackByFeedbackID(string feedbackId);
        Task<List<Feedback>> GetFeedbackByUserID(string userId);
        Task<List<Feedback>> GetAllFeedbacks();
        Task<bool> AddFeedback(Feedback feedback);
        Task<bool> UpdateFeedback(string feedbackId);
        Task<bool> DeleteFeedback(string feedbackId);
        Task<List<Feedback>> GetFeedbackByAdId(string AdId);
        Task<string> GetLastFBId();
        
    }
}