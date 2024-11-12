using FengShuiKoi_BO;
using FengShuiKoi_DAO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Repository
{
    public class AccountRepo : IAccountRepo
    {
        public async Task<bool> AddAccount(Account account)
            => await AccountDAO.Instance.AddAccount(account);

        public async Task<bool> DeleteAccount(string userId)
            => await AccountDAO.Instance.DeleteAccount(userId);

        public async Task<Account> GetAccountByEmail(string email)
            => await AccountDAO.Instance.GetAccountByEmail(email);

        public async Task<Account> GetAccountByUserID(string userid)
            => await AccountDAO.Instance.GetAccountByUserID(userid);

        public async Task<List<Account>> GetAllAccounts()
            => await AccountDAO.Instance.GetAccounts();

        public async Task<bool> UpdateAccountByUser(Account newAccountData)
            => await AccountDAO.Instance.UpdateAccountByUser(newAccountData);

        public async Task<bool> UpdateAccountByAdmin(Account newAccountData)
            => await AccountDAO.Instance.UpdateAccountByAdmin(newAccountData);
    }
}