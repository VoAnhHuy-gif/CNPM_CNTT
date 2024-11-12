using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Package
    {
        public Package()
        {
            AdsPackages = new HashSet<AdsPackage>();
        }

        public string Rank { get; set; } = null!;
        public int Duration { get; set; }
        public string Description { get; set; } = null!;
        public double Price { get; set; }

        public virtual ICollection<AdsPackage> AdsPackages { get; set; }
    }
}
