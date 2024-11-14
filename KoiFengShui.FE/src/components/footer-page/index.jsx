import "./index.css";
import { Link } from "react-router-dom";
function FooterPage() {
  return (
    <div>
      <footer className="main-footer">
        <div className="footer-content">
          <div className="company-info">
            <p>&copy; 2024 KOI PHONG THỦY</p>
            
            <div className="contact-info">
              <p>Điện thoại: 012 3456 789</p>
              <p>Email: nguyentai2292005@gmail.com</p>
            </div>
            <div className="copyright">
              <p>Bản quyền &copy; 2024 Đã đăng ký bản quyền</p>
            </div>
          </div>

          <div className="customer-services">
            <Link style={{ color: 'white', textDecoration: 'none' }} to="/policies">
              <h3>Chính sách và điều khoản</h3>
            </Link>
            <ul>
              <li>Chính sách bảo mật</li>
              <li>Hướng dẫn mua hàng</li>
              <li>Điều khoản sử dụng</li>
              <li>Chính sách thanh toán</li>
            </ul>
          </div>
        </div>
      </footer>
    </div>
  );
}

export default FooterPage;
