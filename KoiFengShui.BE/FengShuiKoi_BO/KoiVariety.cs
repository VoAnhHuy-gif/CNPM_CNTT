using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class KoiVariety
    {
        public KoiVariety()
        {
            TypeColors = new HashSet<TypeColor>();
        }

        public string KoiType { get; set; } = null!;
        public string Image { get; set; } = null!;
        public string Element { get; set; } = null!;
        public string Description { get; set; } = null!;

        public virtual ICollection<TypeColor> TypeColors { get; set; }
    }
}
