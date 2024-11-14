import React, { useState } from 'react';
import './index.css';
import HeaderTemplate from '../../components/header-page';
import FooterTemplate from '../../components/footer-page';
const Policies = () => {
    const [selectedPolicy, setSelectedPolicy] = useState('privacy');
  
    const policies = {
      privacy: {
        title: "Chính sách bảo mật",
        content: `Cam kết bảo vệ quyền riêng tư của bạn
Chúng tôi cam kết bảo vệ thông tin cá nhân của bạn, đảm bảo rằng dữ liệu được thu thập, xử lý và sử dụng một cách minh bạch và an toàn. Chính sách Bảo mật này giải thích cách chúng tôi thu thập, sử dụng và bảo vệ dữ liệu của người dùng trên trang web Koi Phong Thủy.
________________________________________
1. Thông tin chúng tôi thu thập
Thông tin cá nhân: Bao gồm họ tên, ngày tháng năm sinh và địa chỉ email khi bạn đăng ký tài khoản hoặc liên hệ với chúng tôi.
Thông tin giao dịch: Dữ liệu liên quan đến các giao dịch mua bán, thanh toán hoặc dịch vụ (nếu có).
Thông tin về sở thích và tương tác: Các tìm kiếm, nội dung bạn xem và phản hồi (như bình luận hoặc đánh giá sản phẩm).
________________________________________
2. Mục đích sử dụng thông tin
•	Cung cấp dịch vụ: Hỗ trợ và quản lý các giao dịch, cung cấp dịch vụ khách hàng và hỗ trợ kỹ thuật.
•	Cá nhân hóa trải nghiệm: Đề xuất sản phẩm hoặc bài viết liên quan đến cá Koi và phong thủy dựa trên sở thích của bạn.
•	Cải thiện chất lượng dịch vụ: Thu thập phản hồi và phân tích hành vi người dùng để tối ưu hóa website.
•	Tiếp thị và quảng bá: Gửi thông báo về khuyến mãi, ưu đãi hoặc thông tin liên quan (với sự đồng ý của bạn).
•	Bảo mật: Ngăn chặn hành vi gian lận, vi phạm chính sách hoặc sử dụng trái phép hệ thống.
________________________________________
3. Chia sẻ thông tin
Chúng tôi cam kết không chia sẻ thông tin cá nhân của bạn với bên thứ ba, ngoại trừ trong các trường hợp sau:
•	Khi có sự đồng ý của bạn.
•	Để tuân thủ quy định pháp luật hoặc yêu cầu từ cơ quan có thẩm quyền.
•	Khi cần thiết để thực hiện giao dịch (ví dụ: chia sẻ với đơn vị vận chuyển hoặc cổng thanh toán).
•	Khi hợp tác với đối tác kinh doanh nhằm cải thiện chất lượng dịch vụ và trải nghiệm của người dùng.

4. Lưu trữ và bảo vệ dữ liệu
•	Thời gian lưu trữ: Chúng tôi sẽ lưu trữ thông tin cá nhân trong thời gian cần thiết cho mục đích thu thập, trừ khi pháp luật yêu cầu thời gian lưu trữ lâu hơn.
•	Bảo mật dữ liệu: Các biện pháp kỹ thuật và tổ chức phù hợp (như mã hóa, tường lửa và quyền truy cập hạn chế) được áp dụng để bảo vệ dữ liệu khỏi truy cập trái phép, mất mát hoặc rò rỉ.

5. Thay đổi chính sách
Chính sách Bảo mật này có thể được cập nhật theo thời gian để phù hợp với các thay đổi pháp luật hoặc dịch vụ của chúng tôi. Mọi thay đổi sẽ được công bố trên trang web, và chúng tôi sẽ thông báo rõ ràng nếu có thay đổi quan trọng ảnh hưởng đến quyền của bạn.
________________________________________
Liên hệ với chúng tôi
Nếu bạn có bất kỳ thắc mắc hoặc yêu cầu nào liên quan đến Chính sách Bảo mật này, vui lòng liên hệ với chúng tôi qua:
•	Email: nguyentai2292005@gmail.com
•	Số điện thoại: 012 3456 789`
      },
      terms: {
        title: "Điều khoản sử dụng",
        content: `Điều kiện sử dụng dịch vụ
Khi sử dụng trang web của chúng tôi, bạn đồng ý với các điều khoản và điều kiện được nêu dưới đây. Chúng tôi khuyến khích bạn đọc kỹ các điều khoản trước khi sử dụng dịch vụ hoặc đăng nội dung trên trang web Koi Phong Thủy.
________________________________________
1. Nội dung đăng tải
Quy định đăng bài quảng cáo:
•	Nội dung bài đăng phải liên quan đến cá Koi hoặc các sản phẩm, dịch vụ phong thủy.
•	Không được phép đăng tải các nội dung nhạy cảm, phản cảm hoặc vi phạm pháp luật Việt Nam.
•	Mọi quảng cáo hoặc bài viết có nội dung sai lệch, gây hiểu nhầm, hoặc không trung thực sẽ bị từ chối.
•	Thanh toán trước là yêu cầu bắt buộc trước khi bài đăng được kiểm duyệt và phê duyệt.
Hủy và hoàn tiền:
•	Trong trường hợp quảng cáo bị từ chối vì vi phạm quy định nội dung, bài đăng sẽ bị hủy và chúng tôi sẽ hoàn lại tiền trong vòng 30 - 35 ngày làm việc.
•	Quyết định cuối cùng về việc duyệt hoặc từ chối bài đăng thuộc về quản trị viên của hệ thống.
________________________________________
2. Bình luận và tương tác
Người dùng được khuyến khích tham gia bình luận và trao đổi trên các bài viết liên quan đến cá Koi và phong thủy. Tuy nhiên, để đảm bảo môi trường trực tuyến lành mạnh, chúng tôi nghiêm cấm:
•	Đăng tải bình luận có nội dung phản cảm, xúc phạm, phân biệt đối xử hoặc kích động bạo lực.
•	Sử dụng ngôn ngữ thô tục, quấy rối người dùng khác, hoặc phát tán thông tin sai lệch.
•	Chèn liên kết quảng cáo trái phép hoặc nội dung spam.
Hình thức xử lý:
•	Xóa bình luận: Bình luận vi phạm quy định sẽ bị xóa mà không cần thông báo trước.
•	Khóa hoặc cấm tài khoản: Người dùng tái phạm nhiều lần hoặc có hành vi nghiêm trọng sẽ bị khóa tạm thời hoặc vĩnh viễn tài khoản truy cập.
________________________________________
3. Trách nhiệm của người dùng
•	Người dùng chịu trách nhiệm về nội dung mình đăng tải và các hành vi tương tác trên trang web.
•	Việc mạo danh hoặc lạm dụng danh tính người khác dưới bất kỳ hình thức nào đều bị cấm.
•	Người dùng cam kết không cố tình gây ảnh hưởng xấu đến hệ thống hoặc khai thác các lỗ hổng kỹ thuật của trang web.
________________________________________
4. Quyền và trách nhiệm của chúng tôi
•	Chúng tôi có quyền từ chối hoặc xóa nội dung không phù hợp với quy định mà không cần báo trước.
•	Trong trường hợp xảy ra sự cố kỹ thuật ảnh hưởng đến hoạt động của trang web hoặc dịch vụ, chúng tôi sẽ nỗ lực khắc phục sớm nhất có thể, nhưng không chịu trách nhiệm cho những thiệt hại phát sinh do sự cố ngoài ý muốn.
•	Chúng tôi bảo lưu quyền sửa đổi các điều khoản sử dụng và sẽ thông báo công khai trên trang web nếu có bất kỳ thay đổi nào quan trọng.

`
      },
      refund: {
        title: "Hướng dẫn đăng tin quảng cáo",
        content: `HƯỚNG DẪN ĐĂNG QUẢNG CÁO – KOI PHONG THỦY
Trang web Koi Phong Thủy cung cấp một quy trình đơn giản, rõ ràng để người dùng dễ dàng đăng bài quảng cáo. Dưới đây là các bước chi tiết và hướng dẫn để tạo và quản lý quảng cáo trên hệ thống của chúng tôi.
________________________________________
1. Quy trình đăng tin quảng cáo
Bước 1: Truy cập vào mục Đăng Quảng Cáo
•	Nhấp vào nút “Đăng Quảng Cáo” trên thanh điều hướng hoặc từ trang chủ.
Bước 2: Tạo quảng cáo mới
•	Chọn “Tạo Quảng Cáo” để bắt đầu.
•	Bạn sẽ được yêu cầu điền các thông tin cần thiết sau:
  o	Tiêu đề: Ngắn gọn, thể hiện nội dung chính của quảng cáo.
  o	Hình ảnh thumbnail: Ảnh đại diện cho quảng cáo của bạn (định dạng JPG, PNG, dung lượng không quá 5MB).
•	Khuyến nghị kích thước hình ảnh:
  o	Gói Kim Cương: Hiển thị trên trang chủ với kích thước 1700x800px để đảm bảo nổi bật và hấp dẫn.
  o	Gói Vàng và Gói Bạc: Hiển thị ở kích thước 320x200px để tối ưu cho các vị trí danh mục hoặc danh sách quảng cáo, đảm bảo hình ảnh rõ ràng.
Bước 3: Lưu nháp hoặc đăng bài
•	Lưu Nháp: Lưu quảng cáo để chỉnh sửa sau. Quảng cáo lưu nháp sẽ không công khai.
•	Đăng Bài: Gửi quảng cáo để chọn gói dịch vụ và tiếp tục quy trình thanh toán.
________________________________________
2. Chọn gói quảng cáo phù hợp
Sau khi nhấn “Đăng Bài”, hệ thống sẽ hiển thị các gói quảng cáo hiện có:
•	Gói Silver
Giá: 2.000.000 ₫
Mô tả: Hình ảnh nhỏ, chỉ xuất hiện trên trang đăng tin với tần suất ít. Phù hợp với doanh nghiệp cá nhân hoặc startup muốn tiết kiệm chi phí.
Thời hạn: 30 ngày
•	Gói Gold
Giá: 4.000.000 ₫
Mô tả: Hình ảnh vừa, xuất hiện dưới gói Diamond với tần suất vừa. Phù hợp với doanh nghiệp vừa và nhỏ muốn có sự hiện diện ổn định.
Thời hạn: 30 ngày
•	Gói Diamond
Giá: 6.000.000 ₫
Mô tả: Hình ảnh lớn, xuất hiện ở đầu trang với tần suất nhiều, phù hợp cho doanh nghiệp lớn muốn quảng bá mạnh mẽ.
Thời hạn: 30 ngày
________________________________________
3. Xem lại thông tin chi tiết và thanh toán
•	Sau khi chọn gói quảng cáo, hệ thống sẽ hiển thị các chi tiết về thời hạn và giá của gói.
•	Người đăng kiểm tra lại tất cả nội dung để đảm bảo không có sai sót.
•	Nếu mọi thông tin đều chính xác, bấm Thanh Toán để tiến hành giao dịch.
Hình thức thanh toán:
•	Bạn sẽ được chuyển đến cổng thanh toán để thực hiện giao dịch.
•	Chúng tôi hỗ trợ nhiều phương thức thanh toán như chuyển khoản ngân hàng, ví điện tử và thẻ thanh toán quốc tế.
________________________________________
4. Phê duyệt quảng cáo
•	Sau khi thanh toán thành công, quảng cáo sẽ ở trạng thái chờ phê duyệt bởi đội ngũ quản trị viên.
•	Thời gian phê duyệt: 24 - 48 giờ.
•	Nếu quảng cáo vi phạm chính sách (ví dụ: chứa nội dung nhạy cảm, vi phạm pháp luật hoặc không liên quan đến cá Koi/phong thủy), bài đăng sẽ bị từ chối. Bạn sẽ nhận lại tiền hoàn trong vòng 30 - 35 ngày làm việc.
________________________________________
5. Lưu ý quan trọng
•	Chỉnh sửa và hủy bài đăng: Bạn chỉ có thể chỉnh sửa hoặc hủy khi quảng cáo đang ở trạng thái lưu nháp.
•	Quảng cáo đã duyệt: Sau khi bài đăng được phê duyệt và xuất bản, bạn không thể thay đổi nội dung.

`
      },
      shipping: {
        title: "Hỗ trợ và giải quyết khiếu nại",
        content: `CAM KẾT HỖ TRỢ KHÁCH HÀNG – KOI PHONG THỦY
Chúng tôi cam kết cung cấp dịch vụ tốt nhất và đảm bảo quyền lợi của người dùng trên trang web Koi Phong Thủy. Nếu có bất kỳ vấn đề nào liên quan đến quảng cáo, thanh toán hoặc trải nghiệm dịch vụ, vui lòng liên hệ với chúng tôi theo hướng dẫn dưới đây.
________________________________________
1. Cách Thức Liên Hệ với Bộ Phận Hỗ Trợ Khách Hàng
Quý khách có thể liên hệ với đội ngũ hỗ trợ của chúng tôi qua các kênh sau:
•	Email: nguyentai2292005@gmail.com
•	Số điện thoại: 012 3456 789 (Thời gian hỗ trợ: 8:00 - 17:00 từ Thứ 2 đến Thứ 6)
________________________________________
2. Quy Trình Xử Lý Khiếu Nại
Chúng tôi luôn cố gắng xử lý nhanh chóng và hiệu quả các khiếu nại từ người dùng. Dưới đây là quy trình chi tiết:
•	Tiếp nhận khiếu nại:
Sau khi nhận được yêu cầu từ khách hàng qua email hoặc điện thoại, chúng tôi sẽ gửi thông báo tiếp nhận trong vòng 24 giờ.
•	Xác minh thông tin:
Bộ phận hỗ trợ sẽ liên hệ với khách hàng để xác minh thông tin liên quan đến khiếu nại. Chúng tôi có thể yêu cầu cung cấp thêm tài liệu bổ sung (ví dụ: hóa đơn thanh toán, ảnh chụp màn hình lỗi, nội dung quảng cáo đã đăng).
•	Phân tích và giải quyết:
  o	Vấn đề cơ bản: Thời gian xử lý thông thường từ 3 - 5 ngày làm việc.
  o	Vấn đề phức tạp (liên quan đến thanh toán, lỗi kỹ thuật hoặc tranh chấp nội dung quảng cáo): Thời gian xử lý có thể kéo dài từ 7 - 10 ngày làm việc.
•	Kết quả và phản hồi:
Sau khi khiếu nại được xử lý, chúng tôi sẽ gửi phản hồi chi tiết về kết quả qua email hoặc điện thoại đã đăng ký.
________________________________________
3. Thời Gian Phản Hồi và Hướng Xử Lý Tranh Chấp
•	Thời gian phản hồi:
Tất cả các khiếu nại sẽ được phản hồi lần đầu trong vòng 24 giờ kể từ khi tiếp nhận. Nếu cần thêm thời gian để xử lý, chúng tôi sẽ thông báo cho khách hàng về tình trạng hiện tại và thời gian dự kiến hoàn thành.
•	Xử lý tranh chấp:
Nếu khách hàng không đồng ý với kết quả giải quyết khiếu nại, chúng tôi sẽ sắp xếp cuộc gặp gỡ hoặc liên hệ trực tiếp để tìm phương án thỏa thuận. Trong trường hợp tranh chấp không thể giải quyết thông qua thỏa thuận, chúng tôi sẽ tuân thủ quy định pháp luật Việt Nam hoặc chuyển vụ việc đến cơ quan chức năng có thẩm quyền.
________________________________________
4. Các Trường Hợp Không Giải Quyết Khiếu Nại
•	Khiếu nại không đầy đủ thông tin hoặc không cung cấp tài liệu cần thiết theo yêu cầu.
•	Khiếu nại không liên quan đến dịch vụ mà chúng tôi cung cấp.
•	Các khiếu nại đã được giải quyết trước đó và không có bằng chứng mới.
________________________________________
Chúng tôi luôn trân trọng ý kiến phản hồi của khách hàng và cam kết xử lý khiếu nại một cách công bằng, minh bạch và nhanh chóng. Xin cảm ơn quý khách đã tin tưởng sử dụng dịch vụ của Koi Phong Thủy!`
      }
    };
  
    return (
        <div className="policies-page">
        <HeaderTemplate />
        <div className="policies-content">
          <div className="policies-container">
            <h1 className="policies-title">Chính sách của chúng tôi</h1>
            <div className="policies-layout">
              <div className="policies-menu">
                {Object.keys(policies).map(key => (
                  <button
                    key={key}
                    className={`policy-button ${selectedPolicy === key ? 'active' : ''}`}
                    onClick={() => setSelectedPolicy(key)}
                  >
                    {policies[key].title}
                  </button>
                ))}
              </div>
              <div className="policy-display">
                <h2>{policies[selectedPolicy].title}</h2>
                <p>{policies[selectedPolicy].content}</p>
              </div>
            </div>
          </div>
        </div>
        <FooterTemplate />
        </div>
    );
  };
export default Policies;
