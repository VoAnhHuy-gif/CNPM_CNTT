using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Feedback
    {
        public string FbId { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string AdId { get; set; } = null!;
        public string UserId { get; set; } = null!;
        public byte Rate { get; set; }

        public virtual Advertisement Ad { get; set; } = null!;
        public virtual Member User { get; set; } = null!;
    }
}
