using FengShuiKoi_BO;

namespace KoiFengShui.BE.Model
{
    public class PackageDTO
    {

     
        public string Rank { get; set; } = null!;
        public int Duration { get; set; }
        public string Description { get; set; } = null!;
        public double Price { get; set; }

    }
}
