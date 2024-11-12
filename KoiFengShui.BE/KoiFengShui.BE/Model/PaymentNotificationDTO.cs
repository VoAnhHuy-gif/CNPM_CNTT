namespace KoiFengShui.BE.Model
{
    public class PaymentNotificationDTO
    {
        public string Email { get; set; }
        public decimal Amount { get; set; }
        public string OrderInfo { get; set; }
        public string TransactionCode { get; set; }
        public string BankCode { get; set; }
        public DateTime PaymentDate { get; set; }
    }
}