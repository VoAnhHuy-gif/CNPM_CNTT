using System;
using System.ComponentModel.DataAnnotations;

namespace FengShuiKoi_BO
{
    public class AdvertisementWithPackageDTO
    {
        public string AdId { get; set; }
        public string Heading { get; set; }
        public string Image { get; set; }
        public string Link { get; set; }
        public string UserId { get; set; }
        public string ElementId { get; set; }
        public string Status { get; set; }

        public string Rank { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime ExpiredDate { get; set; }
        public int Quantity { get; set; }
        public double Total { get; set; }
        public DateTime CreateAt { get; set; }
    }
}
