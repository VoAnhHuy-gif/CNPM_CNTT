import React, { useState, useEffect } from "react";
import "./index.css";
import HeaderTemplate from "../../components/header-page";
// import { FaEye, FaEyeSlash } from "react-icons/fa";
import api from "../../config/axios";
import { Button, Modal, Form, Input, DatePicker, message, Table } from "antd";
import moment from "moment";
import { toast } from "react-toastify";
import FooterPage from "../../components/footer-page";
import { useNavigate } from "react-router-dom";
import { Bar } from "react-chartjs-2";
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from "chart.js";

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);

function UserProfile() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [showPassword, setShowPassword] = useState(false);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [form] = Form.useForm();
  const [advertisements, setAdvertisements] = useState([]);
  const [adsPackages, setAdsPackages] = useState([]);

  useEffect(() => {
    fetchUserData();
    fetchAdvertisements();
    fetchAdsPackages();
  }, []);
  const fetchUserData = async () => {
    const userId = localStorage.getItem("userId");
    try {
      const response = await api.get(`/Account/GetAccountMemberInfoByUserID`, {
        params: { userID: userId },
      });
      setUser(response.data);
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };
  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const showModal = () => {
    setIsModalVisible(true);
    form.setFieldsValue({
      ...user,
      birthday: moment(user.birthday),
    });
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };

  const handleUpdate = async (values) => {
    try {
      const response = await api.put("/Account/UpdateAccountUser", {
        ...values,
        userID: user.userID,
        role: user.role,
        status: user.status,
      });
      setUser(response.data);
      toast.success(`Cập nhật thông tin tài khoản ${user.userID} thành công`);
      setIsModalVisible(false);
      fetchUserData();
    } catch (error) {
      console.error("Error updating user data:", error);
      toast.error(error.response.data);
    }
  };

  const fetchAdvertisements = async () => {
    const userId = localStorage.getItem("userId");
    try {
      const response = await api.get(
        `/Advertisement/GetAdvertisementByUserId`,
        {
          params: { UserId: userId },
        }
      );
      const approvedAds = response.data.filter(
        (ad) => ad.status === "Approved"
      );
      setAdvertisements(approvedAds);
    } catch (error) {
      console.error("Error fetching advertisements:", error);
    }
  };

  const columns = [
    {
      title: "Tiêu đề",
      dataIndex: "heading",
      key: "title",
    },
    {
      title: "Mô tả",
      key: "content",
      render: (_, record) => (
        <Button
          type="link"
          onClick={() => navigate(`/advertisement-detail/${record.adId}`)}
        >
          Xem chi tiết
        </Button>
      ),
    },
    {
      title: "Ngày đăng",
      dataIndex: "createdDate",
      key: "createdDate",
      render: (text) => moment(text).format("DD-MM-YYYY"),
    },
    {
      title: "Bậc",
      dataIndex: "rank",
      key: "rank",
    }
  ];

  const fetchAdsPackages = async () => {
    try {
      const response = await api.get("/AdsPackage/GetAllAdsPackage");
      setAdsPackages(response.data);
    } catch (error) {
      console.error("Lỗi khi lấy dữ liệu gói quảng cáo:", error);
    }
  };

  const getChartData = () => {
    const rankCounts = {};
    advertisements.forEach(ad => {
      const adPackage = adsPackages.find(pkg => pkg.adId === ad.adId);
      if (adPackage) {
        rankCounts[adPackage.rank] = (rankCounts[adPackage.rank] || 0) + 1;
      }
    });

    return {
      labels: Object.keys(rankCounts),
      datasets: [
        {
          label: 'Số lượng quảng cáo',
          data: Object.values(rankCounts),
          backgroundColor: 'rgba(75, 192, 192, 0.6)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1,
        },
      ],
    };
  };

  const chartOptions = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      title: {
        display: true,
        text: 'Thống kê quảng cáo theo rank',
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          stepSize: 1,
          precision: 0
        }
      }
    }
  };

  return (
    <>
      <HeaderTemplate />
      <div className="user-profile-container">
        <h1 className="user-profile-heading">
          Chào mừng {user?.userID} đến trang thông tin người dùng
        </h1>
        <div className="user-profile-content">
          <div className="user-information">
            <h2>Thông tin người dùng</h2>
            {user && (
              <>
                <ul className="user-info-list">
                  <li>
                    <span>UserID:</span> {user.userID}
                  </li>
                  <li>
                    <span>Mật khẩu:</span>
                    {showPassword ? user.password : "••••••••"}
                    <button onClick={togglePasswordVisibility}>
                      {showPassword ? "👁️" : "👁️‍🗨️"}
                    </button>
                  </li>
                  <li>
                    <span>Email:</span> {user.email}
                  </li>
                  <li>
                    <span>Tên:</span> {user.name}
                  </li>
                  <li>
                    <span>Ngày sinh:</span>{" "}
                    {moment(user.birthday).format("DD-MM-YYYY")}
                  </li>
                </ul>
                <div className="update-account-container">
                  <Button
                    type="primary"
                    onClick={showModal}
                    className="update-account-button"
                  >
                    Cập nhật tài khoản
                  </Button>
                </div>
              </>
            )}
          </div>
          <div className="user-ads-dashboard">
            <h3>Thống kê bài quảng cáo đã đăng</h3>
            {advertisements.length > 0 && adsPackages.length > 0 ? (
              <Bar data={getChartData()} options={chartOptions} />
            ) : (
              <p>Đang tải dữ liệu biểu đồ...</p>
            )}
          </div>
          <div className="user-ads-list">
            <h3>Bài quảng cáo đã đăng</h3>
            <Table columns={columns} dataSource={advertisements} rowKey="id" />
          </div>
        </div>
      </div>
      <FooterPage />
      <Modal
        title="Cập nhật thông tin tài khoản"
        visible={isModalVisible}
        onCancel={handleCancel}
        footer={null}
      >
        <Form form={form} onFinish={handleUpdate} layout="vertical">
          <Form.Item
            name="name"
            label="Họ và tên"
            rules={[{ required: true, message: "Vui lòng nhập họ và tên" }]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            name="email"
            label="Email"
            rules={[
              {
                required: true,
                type: "email",
                message: "Vui lòng nhập email hợp lệ",
              },
            ]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            name="password"
            label="Mật khẩu"
            rules={[{ required: true, message: "Vui lòng nhập mật khẩu" }]}
          >
            <Input.Password />
          </Form.Item>
          <Form.Item
            name="birthday"
            label="Ngày sinh"
            rules={[{ required: true, message: "Vui lòng chọn ngày sinh" }]}
          >
            <DatePicker format="YYYY-MM-DD" />
          </Form.Item>
          <Form.Item>
            <Button type="primary" htmlType="submit">
              Cập nhật
            </Button>
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
}

export default UserProfile;
