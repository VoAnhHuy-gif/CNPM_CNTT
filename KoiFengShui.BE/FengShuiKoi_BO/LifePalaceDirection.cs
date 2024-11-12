using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class LifePalaceDirection
    {
        public string LifePalaceId { get; set; } = null!;
        public string DirectionId { get; set; } = null!;
        public string EightMansions { get; set; } = null!;
        public double PointOfDirection { get; set; }
        public string Description { get; set; } = null!;

        public virtual Direction Direction { get; set; } = null!;
        public virtual LifePalace LifePalace { get; set; } = null!;
    }
}
