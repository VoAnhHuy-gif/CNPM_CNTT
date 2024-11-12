using FengShuiKoi_BO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IMemberService
    {
        Task<Member> GetMemberByUserID(string userid);
        Task<List<Member>> GetMembers();
        Task<bool> AddMember(Member member);
        Task<bool> DeleteAccount(string id);
        Task<bool> UpdateMember(Member updatedMember);
        Task<Dictionary<string, int>> GetUsersByAgeGroup();
    }
}