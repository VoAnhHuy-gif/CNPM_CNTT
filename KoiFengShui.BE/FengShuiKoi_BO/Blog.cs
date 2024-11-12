using System;
using System.Collections.Generic;

namespace FengShuiKoi_BO
{
    public partial class Blog
    {
        public string BlogId { get; set; } = null!;
        public string Heading { get; set; } = null!;
        public string Image { get; set; } = null!;
        public string Link { get; set; } = null!;
        public string Status { get; set; } = null!;
    }
}
