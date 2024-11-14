import { Button, DatePicker, Form, Input } from "antd";
import AuthenTemplate from "../../components/authen-templates";
import { Link, useNavigate } from "react-router-dom";
import api from "../../config/axios";
import { toast } from "react-toastify";
import "./index.css";
function Register() {
  const navigate = useNavigate();
  const [form] = Form.useForm();

  const handleRegister = async (values) => {
    //lấy cái values và submit nó xún backend
    try {
      values.role = "Member";
      values.status = "Active";
      const response = await api.post("Account/register", values);
      toast.success("Đăng ký tài khoản thành công!");
      navigate("/login");
    } catch (error) {
      toast.error(error.response.data); //nơi mà backend sẽ trả về lỗi khi mà register fail
    }
  };
  // Custom validator for confirming password
  const validatePasswordConfirmation = ({ getFieldValue }) => ({
    validator(_, value) {
      if (!value || getFieldValue("Password") === value) {
        return Promise.resolve();
      }
      return Promise.reject(new Error("Hai mật khẩu không khớp!"));
    },
  });
  return (
    <AuthenTemplate>
      <div className="login-header">
        <h1>Đăng ký tài khoản</h1>
        <p>Hãy nhập thông tin để tạo tài khoản</p>
      </div>
      <Form
        form={form}
        labelCol={{
          span: 24,
        }}
        name="userForm"
        className="register-form"
        initialValues={{ remember: true }}
        onFinish={handleRegister}
      >
        <Form.Item
          
          name="UserID"
          
          rules={[
            { required: true, message: "Xin hãy nhập tên tài khoản" },
            { min: 4, message: "Tên tài khoản phải có ít nhất 4 ký tự!" },
          ]}
        >
          <Input placeholder="Tên tài khoản" />
        </Form.Item>

        <Form.Item
          
          name="Password"
          rules={[
            { required: true, message: "Xin hãy nhập mật khẩu!" },
            { min: 6, message: "Mật khẩu phải có ít nhất 6 ký tự!" },
          ]}
          hasFeedback
        >
          <Input.Password placeholder="Mật khẩu" />
        </Form.Item>

        <Form.Item
          
          name="confirmPassword"
          dependencies={["Password"]} // Ensure the password field updates the validation for this field
          hasFeedback
          rules={[
            { required: true, message: "Vui lòng nhập lại password của bạn!" },
            validatePasswordConfirmation(form),
          ]}
        >
          <Input.Password placeholder="Nhập lại mật khẩu" />
        </Form.Item>

        <Form.Item
          
          name="Name"
          rules={[{ required: true, message: "Xin hãy nhập họ và tên!" }]}
        >
          <Input placeholder="Họ và tên" />
        </Form.Item>

        <Form.Item
          
          name="Email"
          rules={[
            { required: true, message: "Vui lòng nhập email của bạn!" },
            { type: "email", message: "Vui lòng nhập email hợp lệ!" },
          ]}
        >
          <Input placeholder="Email" />
        </Form.Item>

        <Form.Item
          
          name="Birthday"
        
          rules={[{ required: true, message: "Chọn ngày sinh của bạn!" }]}
        >
          <DatePicker placeholder="Chọn ngày sinh" format="YYYY-MM-DD" className="datePicker" />
        </Form.Item>
        {/* <Form.Item
          label="Birthday"
          name="Birthday"
          rules={[
            { required: true, message: "Please input your birthday!" },
            {
              pattern: /^\d{4}-\d{2}-\d{2}$/,
              message: "Birthday must be in the format YYYY-MM-DD!",
            },
          ]}
        >
          <Input />
        </Form.Item> */}

        <Form.Item>
          <Button type="primary" htmlType="submit">
            Đăng ký
          </Button>
        </Form.Item>
        <Link to="/login" className="login-link">Đã có tài khoản ? Đăng nhập ngay</Link>
      </Form>
    </AuthenTemplate>
  );
}

export default Register;
