using FengShuiKoi_BO;
using FengShuiKoi_Repository;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{

    public class AccountService : IAccountService
    {
        private IAccountRepo iAccountRepo;
        public AccountService()
        {
            iAccountRepo = new AccountRepo();
        }

        public async Task<bool> AddAccount(Account account)
        {
            return await iAccountRepo.AddAccount(account);
        }

        public async Task<bool> DeleteAccount(string userId)
        {
            return await iAccountRepo.DeleteAccount(userId);
        }

        public async Task<Account> GetAccountByEmail(string email)
        {
            return await iAccountRepo.GetAccountByEmail(email);
        }

        public async Task<Account> GetAccountByUserID(string userid)
        {
            return await iAccountRepo.GetAccountByUserID(userid);
        }

        public async Task<List<Account>> GetAllAccounts()
        {
            return await iAccountRepo.GetAllAccounts();
        }

        public async Task<bool> UpdateAccountByUser(Account newAccountData)
        {
            return await iAccountRepo.UpdateAccountByUser(newAccountData);
        }

        public async Task<bool> UpdateAccountByAdmin(Account newAccountData)
        {
            return await iAccountRepo.UpdateAccountByAdmin(newAccountData);
        }
    }
}

