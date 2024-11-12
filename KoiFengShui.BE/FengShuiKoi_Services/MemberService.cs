using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public class MemberService : IMemberService
    {
        private IMemberRepo iMemberRepo;
        public MemberService()
        {
            iMemberRepo = new MemberRepo();
        }

        public Task<bool> AddMember(Member member)
        {
            return iMemberRepo.AddMember(member);
        }

        public Task<bool> DeleteAccount(string id)
        {
            return iMemberRepo.DeleteAccount(id);
        }

        public Task<Member> GetMemberByUserID(string userid)
        {
            return iMemberRepo.GetMemberByUserID(userid);
        }

        public Task<List<Member>> GetMembers()
        {
            return iMemberRepo.GetMembers();
        }

        public Task<bool> UpdateMember(Member updatedMember)
        {
            return iMemberRepo.UpdateMember(updatedMember);
        }

        public Task<Dictionary<string, int>> GetUsersByAgeGroup()
        {
            return iMemberRepo.GetUsersByAgeGroup();
        }
    }
}