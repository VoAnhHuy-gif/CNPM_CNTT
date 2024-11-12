using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class LifePalace
    {
        public LifePalace()
        {
            LifePalaceDirections = new HashSet<LifePalaceDirection>();
        }

        public string LifePalaceId { get; set; } = null!;

        public virtual ICollection<LifePalaceDirection> LifePalaceDirections { get; set; }
    }
}
