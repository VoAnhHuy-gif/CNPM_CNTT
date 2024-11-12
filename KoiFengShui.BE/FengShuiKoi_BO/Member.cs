using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Member
    {
        public Member()
        {
            Advertisements = new HashSet<Advertisement>();
            Feedbacks = new HashSet<Feedback>();
        }

        public string Name { get; set; } = null!;
        public DateTime Birthday { get; set; }
        public string UserId { get; set; } = null!;

        public virtual Account User { get; set; } = null!;
        public virtual ICollection<Advertisement> Advertisements { get; set; }
        public virtual ICollection<Feedback> Feedbacks { get; set; }
    }
}
