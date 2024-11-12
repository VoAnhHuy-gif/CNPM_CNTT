using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class ElementColor
    {
        public string ElementId { get; set; } = null!;
        public string ColorId { get; set; } = null!;
        public double ColorPoint { get; set; }

        public virtual Color Color { get; set; } = null!;
        public virtual Element Element { get; set; } = null!;
    }
}
