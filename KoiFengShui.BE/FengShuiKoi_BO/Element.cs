using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Element
    {
        public Element()
        {
            Advertisements = new HashSet<Advertisement>();
            ElementColors = new HashSet<ElementColor>();
            PointOfShapes = new HashSet<PointOfShape>();
        }

        public string ElementId { get; set; } = null!;
        public string Mutualism { get; set; } = null!;

        public virtual QuantityOfFish? QuantityOfFish { get; set; }
        public virtual ICollection<Advertisement> Advertisements { get; set; }
        public virtual ICollection<ElementColor> ElementColors { get; set; }
        public virtual ICollection<PointOfShape> PointOfShapes { get; set; }
    }
}
