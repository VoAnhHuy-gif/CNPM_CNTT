using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IFeedbackService
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