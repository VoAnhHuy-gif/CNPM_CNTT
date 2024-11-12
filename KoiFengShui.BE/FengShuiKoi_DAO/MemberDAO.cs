using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FungShuiKoi_DAO
{

    public class MemberDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;

        private static MemberDAO instance = null;

        public static MemberDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new MemberDAO();
                }
                return instance;
            }
        }

        public async Task<Dictionary<string, int>> GetUsersByAgeGroup()
        {
            try
            {
                var now = DateTime.Now;
                var members = await dbContext.Members.AsNoTracking().ToListAsync();

                var result = new Dictionary<string, int>
                {
                    {"Dưới 18", 0},
                    {"18-29", 0},
                    {"30-49", 0},
                    {"50+", 0}
                };

                foreach (var member in members)
                {
                    if (member.Birthday == null) continue;

                    int age = now.Year - member.Birthday.Year;
                    if (now.Month < member.Birthday.Month || (now.Month == member.Birthday.Month && now.Day < member.Birthday.Day))
                    {
                        age--;
                    }

                    if (age < 18) result["Dưới 18"]++;
                    else if (age < 30) result["18-29"]++;
                    else if (age < 50) result["30-49"]++;
                    else result["50+"]++;
                }
                return result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi trong GetUsersByAgeGroup: {ex.Message}");
                return new Dictionary<string, int>();
            }
        }

        public MemberDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Member> GetMemberByUserID(string userid)
        {
            return await dbContext.Members.SingleOrDefaultAsync(m => m.UserId.Equals(userid));
        }

        public async Task<List<Member>> GetMembers()
        {
            return await dbContext.Members.ToListAsync();
        }

        public async Task<bool> AddMember(Member member)
        {
            var mem = await this.GetMemberByUserID(member.UserId);
            if (mem != null) return false;

            try
            {
                await dbContext.Members.AddAsync(member);
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> DeleteAccount(string id)
        {
            var mem = await this.GetMemberByUserID(id);
            if (mem == null) return false;

            try
            {
                dbContext.Members.Remove(mem);
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> UpdateMember(Member updatedMember)
        {
            try
            {
                var existingMember = await this.GetMemberByUserID(updatedMember.UserId);
                if (existingMember == null)
                {
                    return false;
                }

                existingMember.Name = updatedMember.Name;
                existingMember.Birthday = updatedMember.Birthday;

                dbContext.Entry(existingMember).State = EntityState.Modified;
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}

	
