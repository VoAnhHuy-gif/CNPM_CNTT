using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Shape
    {
        public Shape()
        {
            PointOfShapes = new HashSet<PointOfShape>();
        }

        public string ShapeId { get; set; } = null!;
        public string Image { get; set; } = null!;

        public virtual ICollection<PointOfShape> PointOfShapes { get; set; }
    }
}
