using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Color
    {
        public Color()
        {
            ElementColors = new HashSet<ElementColor>();
            TypeColors = new HashSet<TypeColor>();
        }

        public string ColorId { get; set; } = null!;

        public virtual ICollection<ElementColor> ElementColors { get; set; }
        public virtual ICollection<TypeColor> TypeColors { get; set; }
    }
}
