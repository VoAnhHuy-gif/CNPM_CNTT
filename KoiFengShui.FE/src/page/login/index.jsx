import { Button, Form, Input } from "antd";
import { getAuth, signInWithPopup } from "firebase/auth";
// import { GoogleAuthProvider } from "firebase/auth/web-extension";
import { provider } from "../../config/firebase";
import { Link, useNavigate } from "react-router-dom";
import AuthenTemplate from "../../components/authen-templates";
import { GoogleOutlined } from "@ant-design/icons";
import api from "../../config/axios";
import { toast, ToastContainer } from "react-toastify";
import "./index.css";

import { GoogleLogin } from "@react-oauth/google";

import { jwtDecode } from "jwt-decode";

function Login() {
  const navigate = useNavigate();
  const handleLogInGoogle = async () => {
    const auth = getAuth();
    try {
      const result = await signInWithPopup(auth, provider);
      const user = result.user;

      // Send Google user info to your backend
      const response = await api.post("/Account/google-login", {
        email: user.email,
        name: user.displayName,
        googleId: user.uid,
      });

      const { role, token, userId } = response.data;
      localStorage.setItem("token", token);
      localStorage.setItem("userId", userId);

      if (role === "ADMIN") {
        navigate("/dashboard/AdminDashboard");
      } else {
        navigate("/");
      }
    } catch (error) {
      console.error(error);
      toast.error("An error occurred during Google login");
    }
  };

  const handleLogin = async (values) => {
    try {
      const response = await api.post("/Account/login", values);
      const { role, token, userId, name, status } = response.data;
      localStorage.setItem("token", token);
      localStorage.setItem("userId", userId);
      localStorage.setItem("role", role);
      localStorage.setItem("name", name);
      if (role === "Admin") {
        navigate("/dashboard");
      } else {
        navigate("/");
      }
    } catch (error) {
      if (error.response && error.response.data) {
        toast.error(error.response.data);
      } else {
        toast.error("An error occurred during login");
      }
    }
  };

  //lOGIN GG DEMO
  const responseGoogle = async (response) => {
    try {
      const result = await api.post("Account/google-login", {
        googleId: response.profileObj.googleId,
        email: response.profileObj.email,
        name: response.profileObj.name,
      });

      // Xử lý response từ backend
      if (result.data.token) {
        localStorage.setItem("token", result.data.token);
        localStorage.setItem("userId", result.data.userId);
        navigate(result.data.role === "ADMIN" ? "/dashboard" : "/");
      }
    } catch (error) {
      toast.error(error.response?.data || "Đăng nhập thất bại");
    }
  };
  //Demo login GG

  const handleGoogleLoginSuccess = async (credentialResponse) => {
    try {
      const decoded = jwtDecode(credentialResponse.credential);
      const response = await api.post("/Account/google-login", {
        googleId: decoded.sub,
        email: decoded.email,

        name: decoded.name,
      });

      const { role, token, userId, name } = response.data;
      localStorage.setItem("token", token);
      localStorage.setItem("userId", userId);
      localStorage.setItem("name", name);
      localStorage.setItem("role", role); 
      if (role === "ADMIN") {
        navigate("/dashboard");
      } else {
        navigate("/");
      }
    } catch (error) {
      console.error(error);
      toast.error("An error occurred during Google login");
    }
  };

  return (
    <AuthenTemplate>
      <div className="login-header">
        <h1>KOI PHONG THỦY !</h1>
        <p>Đăng nhập để tiếp tục</p>
      </div>
      <Form
        labelCol={{ span: 24 }}
        onFinish={handleLogin}
        className="login-form"
      >
        <Form.Item
          label="Tài khoản"
          name="UserId"
          rules={[
            {
              require: true,
              message: "Xin hãy nhập tài khoản",
            },
          ]}
        >
          <Input />
        </Form.Item>
        <Form.Item
          label="Mật khẩu"
          name="Password"
          rules={[
            {
              require: true,
              message: "Xin hãy nhập mật khẩu",
            },
          ]}
        >
          <Input.Password />
        </Form.Item>
        <div className="register-forgotpassword">
          <Link to="/register">Bạn chưa có tài khoản? Đăng ký ngay!</Link>
          <Link to="/forgot-password">Quên mật khẩu?</Link>
        </div>
        <Button type="primary" htmlType="submit" className="btnLogin">
          Đăng nhập
        </Button>
        <div className="divider">
          <span>OR</span>
        </div>
        {/* <Button
          onClick={handleLogInGoogle}
          icon={<GoogleOutlined />}
          className="btnLoginwithGoogle"
        >
          Login with Google
        </Button> */}
        <GoogleLogin
          className="btnLoginwithGoogle"
          shape="circle"
          onSuccess={handleGoogleLoginSuccess}
          onError={() => {
            console.log("Đăng nhập thất bại");

            toast.error("Đăng nhập thất bại");
          }}
        />
      </Form>
    </AuthenTemplate>
  );
}

export default Login;
