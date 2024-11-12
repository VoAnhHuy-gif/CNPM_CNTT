using FengShuiKoi_BO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FengShuiKoi_DAO
{
    public class AccountDAO
    {
        private CN2301C_FengShuiKoiConsulting_DBContext dbContext;
        private static AccountDAO instance = null;
        public static AccountDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AccountDAO();
                }
                return instance;
            }
        }

        public AccountDAO()
        {
            dbContext = new CN2301C_FengShuiKoiConsulting_DBContext();
        }

        public async Task<Account> GetAccountByEmail(string email)
        {
            return await dbContext.Accounts.SingleOrDefaultAsync(m => m.Email.Equals(email));
        }

        public async Task<Account> GetAccountByUserID(string userid)
        {
            return await dbContext.Accounts.SingleOrDefaultAsync(m => m.UserId.Equals(userid));
        }

        public async Task<List<Account>> GetAccounts()
        {
            return await dbContext.Accounts.ToListAsync();
        }

        public async Task<bool> AddAccount(Account account)
        {
            var acc = await GetAccountByUserID(account.UserId);
            if (acc != null) return false;

            try
            {
                await dbContext.Accounts.AddAsync(account);
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
            var acc = await GetAccountByUserID(id);
            if (acc == null) return false;

            try
            {
                dbContext.Accounts.Remove(acc);
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> UpdateAccountByAdmin(Account newAccountData)
        {
            try
            {
                var existingAccount = await GetAccountByUserID(newAccountData.UserId);
                if (existingAccount == null) return false;

                existingAccount.Status = newAccountData.Status;
               

                dbContext.Entry(existingAccount).State = EntityState.Modified;
                await dbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public async Task<bool> UpdateAccountByUser(Account newAccountData)
        {
            try
            {
                var existingAccount = await GetAccountByUserID(newAccountData.UserId);
                if (existingAccount == null) return false;

                existingAccount.Email = newAccountData.Email;
                existingAccount.Password = newAccountData.Password;

                dbContext.Entry(existingAccount).State = EntityState.Modified;
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