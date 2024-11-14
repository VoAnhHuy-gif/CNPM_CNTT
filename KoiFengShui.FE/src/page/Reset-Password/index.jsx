import React from "react";
import { useNavigate, useParams } from "react-router-dom";
import AuthenTemplate from "../../components/authen-templates";
import { Button, Form, Input } from "antd";
import api from "../../config/axios";
import { toast } from "react-toastify";
import "./index.css";

function ResetPassword() {
  const [form] = Form.useForm();
  const { email } = useParams();
  const decodedEmail = decodeURIComponent(email);
  const navigate = useNavigate();

  const handleResetPassword = async (values) => {
    try {
      await api.post("Account/reset-password", {email: decodedEmail, newPassword: values.newPassword});
      toast.success("Mật khẩu đã được đặt lại thành công.");
      navigate("/login");
    } catch (error) {
      toast.error(error.response.data);
    }
  };

  const validatePasswordConfirmation = ({ getFieldValue }) => ({
    validator(_, value) {
      if (!value || getFieldValue("newPassword") === value) {
        return Promise.resolve();
      }
      return Promise.reject(new Error("Hai mật khẩu không khớp!"));
    },
  });
  return (
    <AuthenTemplate>
      <div className="reset-password-header">
        <h1>KOI PHONG THỦY !</h1>
        <p>Đặt lại mật khẩu cho {decodedEmail}</p>
        <Form
          form={form}
          labelCol={{
            span: 24,
          }}
          onFinish={handleResetPassword}
          className="reset-password-form"
        >
          <Form.Item
            name="newPassword"
            rules={[{ required: true, message: "Vui lòng nhập mật khẩu mới!" }]}
          >
            <Input.Password placeholder="Mật khẩu mới" />
          </Form.Item>
          <Form.Item
            name="confirmPassword"
            dependencies={["newPassword"]} 
            hasFeedback
            rules={[
              {
                required: true,
                message: "Vui lòng nhập lại password của bạn!",
              },
              validatePasswordConfirmation(form),
            ]}
          >
            <Input.Password placeholder="Nhập lại mật khẩu" />
          </Form.Item>
          <Form.Item>
            <Button type="primary" htmlType="submit" className="reset-password-button">
              Đặt lại mật khẩu
            </Button>
          </Form.Item>
        </Form>
      </div>
    </AuthenTemplate>
  );
}

export default ResetPassword;
