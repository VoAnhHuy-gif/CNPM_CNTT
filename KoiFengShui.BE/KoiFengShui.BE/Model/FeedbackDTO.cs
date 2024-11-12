
namespace KoiFengShui.BE.Model
{
    public  class FeedbackDTO
    {
        public string FbId { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string AdId { get; set; } = null!;
        public string UserId { get; set; } = null!;

        public byte Rate { get; set; }

    }
}
