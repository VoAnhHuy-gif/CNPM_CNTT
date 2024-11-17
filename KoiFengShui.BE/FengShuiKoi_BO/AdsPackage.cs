using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class AdsPackage
    {
        public string AdId { get; set; } = null!;
        public string Rank { get; set; } = null!;
        public DateTime StartDate { get; set; }
        public DateTime ExpiredDate { get; set; }
        public int Quantity { get; set; }
        public double Total { get; set; }
        public DateTime CreateAt { get; set; }

        public virtual Advertisement Ad { get; set; } = null!;
        public virtual Package RankNavigation { get; set; } = null!;
    }
}
