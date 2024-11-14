import { useEffect, useState } from "react";
import {
  DesktopOutlined,
  FileOutlined,
  PieChartOutlined,
  TeamOutlined,
  UserOutlined,

  LogoutOutlined,

} from "@ant-design/icons";
import { Breadcrumb, Button, Layout, Menu, theme } from "antd";
import { Link, Outlet } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import KoiImage from './logo.jpg';
import "./index.css";

const { Header, Content, Footer, Sider } = Layout;
function getItem(label, key, icon, children) {
  if (children) {
    return {
      key,
      icon,
      children,
      label,
    };
  }
  return {
    key,
    icon,
    children,
    label: <Link to={`/dashboard/${key}`}>{label}</Link>,
  };
}
const items = [
  getItem("Thống kê trang web", "AdminDashboard", <PieChartOutlined />),
  getItem("Quản lý quảng cáo", "ads", <PieChartOutlined />),
  getItem("Quản lý người dùng", "user", <PieChartOutlined />),
  getItem("Quản lý Blog", "blog", <PieChartOutlined />),
  getItem("Quản lý cá Koi", "koi", <PieChartOutlined />),
  getItem("Quản lý hồ", "pond", <PieChartOutlined />),
  getItem("Quản lý gói", "packageManagement", <PieChartOutlined />),
];
const Dashboard = () => {
  const navigate = useNavigate();
  const [userId, setUserId] = useState(null);
  useEffect(() => {
    const user = localStorage.getItem("userId");
    if (user) {
      setUserId(user);
    }
  }, []);
  const handleLogout = () => {
    localStorage.removeItem("userId");
    localStorage.removeItem("token");
    localStorage.removeItem("role");
    localStorage.removeItem("name");
    setUserId(null);
    navigate("/");
  };
  const handleUserHome = () => {
    navigate("/");
  };
  const [collapsed, setCollapsed] = useState(false);
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();
  return (
    <Layout
      style={{
        minHeight: "100vh",

      }}
    >
      <Sider
        collapsible
        collapsed={collapsed}
        onCollapse={(value) => setCollapsed(value)}
        style={{
          overflow: 'auto',
          height: '100vh',
          position: 'fixed',
          left: 0,
          top: 0,
          bottom: 0,
          width: collapsed ? '60px' : '200px', // Tăng độ rộng khi mở rộng
        }}
      >

        <div className="logo">
        {collapsed ? (
          <img src={KoiImage} alt="Logo" />
        ) : (
            <img src={KoiImage} alt="Logo" />
        )}
      </div>
        <div className="demo-logo-vertical" />
        

        <Menu
          theme="dark"
          defaultSelectedKeys={["1"]}
          mode="inline"
          items={items}
          style={{
            marginTop: "20px", // Giảm margin-top
            padding: '8px 0',  // Giảm padding
          }}
        />
        
        <Button
          style={{
            marginTop: "20px", // Giảm margin-top của các button
            marginLeft: "16px",
            width: 'calc(100% - 32px)',
          }}
          type="primary"
          icon={<LogoutOutlined />}
          onClick={handleLogout}
        >
          {collapsed ? "" : "Đăng xuất"}
        </Button>
        <Button
          style={{
            marginTop: "10px",
            marginLeft: "16px",
            width: 'calc(100% - 32px)',
          }}
          type="primary"
          icon={<LogoutOutlined />}
          onClick={handleUserHome}
        >
          {collapsed ? "" : "Trang chủ"}
        </Button>
      </Sider>

      <Layout style={{ marginLeft: collapsed ? 80 : 250 }}>
        <Header
          style={{
            padding: 0,
            background: colorBgContainer,
          }}
        />
        <Content
          style={{
            margin: "0 16px",
          }}
        >
          <Breadcrumb
            style={{
              margin: "16px 0",
            }}
          >

            <Breadcrumb.Item>Admin</Breadcrumb.Item>
            <Breadcrumb.Item>{userId}</Breadcrumb.Item>
          </Breadcrumb>
          <div
            style={{
              padding: 0,
              minHeight: 360,
              background: colorBgContainer,
              borderRadius: borderRadiusLG,
            }}
          >
            <Outlet />
          </div>
        </Content>
        <Footer
          style={{
            textAlign: "center",
          }}
        >
        </Footer>
      </Layout>
    </Layout>
  );
};
export default Dashboard;
