using FengShuiKoi_BO;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
    public interface IAccountService
    {
        Task<Account> GetAccountByEmail(string email);
        Task<Account> GetAccountByUserID(string userid);
        Task<List<Account>> GetAllAccounts();
        Task<bool> AddAccount(Account account);
        Task<bool> UpdateAccountByAdmin(Account newAccountData);
        Task<bool> UpdateAccountByUser(Account newAccountData);
        Task<bool> DeleteAccount(string userId);
    }
}