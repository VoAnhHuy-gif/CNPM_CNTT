import React, { useState } from "react";
import AuthenTemplate from "../../components/authen-templates";
import { Button, Form, Input } from "antd";
import api from "../../config/axios";
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import "./index.css";

function ForgotPassword() {
  const [form] = Form.useForm();
  const [isOtpSent, setIsOtpSent] = useState(false);
  const [email, setEmail] = useState("");
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const handleForgotPassword = async (values) => {
    setLoading(true);
    try {
      const response = await api.post("Account/forgot-password", values);
      console.log(response);
      setIsOtpSent(true);
      setEmail(values.email);
      toast.success("Mã OTP đã được gửi đến email của bạn!");
    } catch (error) {
      toast.error(error.response.data);
    } finally {
      setLoading(false);
    }
  };
  const handleVerifyOtp = async (values) => {
    setLoading(true);
    try {
      const response = await api.post("Account/verify-code", {
        email: email,
        code: values.code,
      });
      console.log(response);
      navigate(`/reset-password/${encodeURIComponent(email)}`);
    } catch (error) {
      toast.error(error.response.data);
    } finally {
      setLoading(false);
    }
  };
  return (
    <AuthenTemplate>
      <div className="forgot-password-header">
        <h1>KOI PHONG THỦY !</h1>
        <p>{isOtpSent ? "Nhập mã OTP" : "Quên mật khẩu"}</p>
        {isOtpSent ? (
          <Form
            className="forgot-password-form"
            form={form}
            labelCol={{
              span: 24,
            }}
            onFinish={handleVerifyOtp}
          >
            <Form.Item
              name="code"
              rules={[{ required: true, message: "Vui lòng nhập mã OTP!" }]}
            >
              <Input placeholder="Nhập Mã OTP" />
            </Form.Item>
            <Form.Item>
              <Button
                type="primary"
                htmlType="submit"
                className="forgot-password-button"
                loading={loading}
                disabled={loading}
              >
                Xác nhận OTP
              </Button>
            </Form.Item>
          </Form>
        ) : (
          <Form
            form={form}
            labelCol={{
              span: 24,
            }}
            onFinish={handleForgotPassword}
            className="forgot-password-form"
          >
            <Form.Item
              name="email"
              rules={[
                { required: true, message: "Vui lòng nhập email của bạn!" },
                { type: "email", message: "Vui lòng nhập email hợp lệ!" },
              ]}
            >
              <Input placeholder="Email" />
            </Form.Item>
            <Form.Item>
              <Button
                type="primary"
                htmlType="submit"
                className="forgot-password-button"
                loading={loading}
                disabled={loading}
              >
                Gửi mật khẩu
              </Button>
            </Form.Item>
          </Form>
        )}
      </div>
    </AuthenTemplate>
  );
}

export default ForgotPassword;
