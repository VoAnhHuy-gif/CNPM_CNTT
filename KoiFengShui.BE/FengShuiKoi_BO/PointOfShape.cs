using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class PointOfShape
    {
        public double Point { get; set; }
        public string ElementId { get; set; } = null!;
        public string ShapeId { get; set; } = null!;

        public virtual Element Element { get; set; } = null!;
        public virtual Shape Shape { get; set; } = null!;
    }
}
