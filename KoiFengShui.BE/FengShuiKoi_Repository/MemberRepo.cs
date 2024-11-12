using FengShuiKoi_BO;
using FungShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class MemberRepo : IMemberRepo
    {
        public Task<bool> AddMember(Member member) => MemberDAO.Instance.AddMember(member);

        public Task<bool> DeleteAccount(string id) => MemberDAO.Instance.DeleteAccount(id);

        public Task<Member> GetMemberByUserID(string userid) => MemberDAO.Instance.GetMemberByUserID(userid);

        public Task<List<Member>> GetMembers() => MemberDAO.Instance.GetMembers();

        public Task<bool> UpdateMember(Member updatedMember) => MemberDAO.Instance.UpdateMember(updatedMember);

        public Task<Dictionary<string, int>> GetUsersByAgeGroup() => MemberDAO.Instance.GetUsersByAgeGroup();
    }
}