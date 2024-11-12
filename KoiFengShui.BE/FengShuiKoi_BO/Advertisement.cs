using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Advertisement
    {
        public Advertisement()
        {
            AdsPackages = new HashSet<AdsPackage>();
            Feedbacks = new HashSet<Feedback>();
        }

        public string AdId { get; set; } = null!;
        public string Heading { get; set; } = null!;
        public string Image { get; set; } = null!;
        public string Link { get; set; } = null!;
        public string UserId { get; set; } = null!;
        public string? ElementId { get; set; }
        public string Status { get; set; } = null!;

        public virtual Element? Element { get; set; }
        public virtual Member User { get; set; } = null!;
        public virtual ICollection<AdsPackage> AdsPackages { get; set; }
        public virtual ICollection<Feedback> Feedbacks { get; set; }
    }
}
