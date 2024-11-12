using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Account
    {
        public string UserId { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Role { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Status { get; set; } = null!;

        public virtual Member? Member { get; set; }
    }
}
