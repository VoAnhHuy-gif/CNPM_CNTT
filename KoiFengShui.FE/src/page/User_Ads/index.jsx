import React, { useState, useEffect } from "react";
import "./index.css";
import { Layout, Menu, Table, Button, Popconfirm } from "antd";
import { Link, useLocation } from "react-router-dom";
import { useNavigate } from "react-router-dom";

import api from "../../config/axios";
import HeaderTemplate from "../../components/header-page";
import moment from "moment";
import { toast } from "react-toastify";

const { Content } = Layout;

const User_Ads = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [advertisements, setAdvertisements] = useState([]);
  const [filteredAds, setFilteredAds] = useState([]);
  const [selectedStatus, setSelectedStatus] = useState("all");
  const [adsPackages, setAdsPackages] = useState([]);
  const [loading, setLoading] = useState(false);

  const menuItems = [
    { key: "all", label: "Tất cả" },
    { key: "Draft", label: "Bản nháp" },
    { key: "Pending", label: "Chờ duyệt" },
    { key: "Approved", label: "Đã duyệt" },
    { key: "Canceled", label: "Đã hủy" },
    { key: "Refunded", label: "Đã hoàn tiền" },
  ];
  const userId = localStorage.getItem("userId");

  

  useEffect(() => {
    fetchAdsPackages();
    fetchAdvertisements();
  }, []);

  useEffect(() => {
    if (adsPackages.length > 0) {
      fetchAdvertisements();
    }
  }, [adsPackages]);

  useEffect(() => {
    filterAdvertisements(selectedStatus);
  }, [selectedStatus, advertisements]);

  const fetchAdsPackages = async () => {
    try {
      const response = await api.get("AdsPackage/GetAllAdsPackage");
      setAdsPackages(response.data);
      console.log(adsPackages);
    } catch (error) {
      console.error("Error fetching ads packages:", error);
    }
  };
  const getStatusColor = (status) => {
    switch (status) {
      case "Draft": return "default";
      case "Pending": return "#1890ff";
      case "Approved": return "#52c41a";
      case "Refunded": return "#faad14";
      case "Canceled": return "#f5222d";
      case "Expired": return "#f5222d"; 
      default: return "black";
    }
  };

  const getStatusText = (status) => {
    switch (status) {
      case "Draft": return "Bản nháp";
      case "Pending": return "Chờ duyệt";
      case "Approved": return "Đã duyệt";
      case "Refunded": return "Đã hoàn tiền";
      case "Canceled": return "Đã hủy";
      case "Expired": return "Đã hết hạn";
      default: return "Trạng thái khác";
    }
  };

  const fetchAdvertisements = async () => {
    try {
      const response = await api.get(
        `Advertisement/GetAdvertisementByUserId?UserId=${userId}`
      );
      const adsWithExpirationDate = response.data.map((ad) => {
        const adPackage = adsPackages.find((pkg) => pkg.adId === ad.adId);
        return {
          ...ad,
          expirationDate: adPackage ? adPackage.expiredDate : null,
          startDate: adPackage ? adPackage.startDate : null,
        };
      });
      setAdvertisements(adsWithExpirationDate);
      console.log(adsWithExpirationDate);

    } catch (error) {
      console.error("Error fetching advertisements:", error);
    }
  };

  const filterAdvertisements = (status) => {
    if (status === "all") {
      setFilteredAds(advertisements);
    } else {
      const filtered = advertisements.filter((ad) => ad.status === status);
      setFilteredAds(filtered);
    }
  };

  const handleMenuClick = (e) => {
    setSelectedStatus(e.key);
  };

  const handleCreate = () => {
    navigate("/create-ads", { state: { advertisement: null } });
  };
  const handleChoosePackage = () => {
    navigate("/choose-package");
  };

  const handleDeleteAd = async (adId) => {
    setLoading(true);
    try {
      const response = await api.delete(
        `Advertisement/DeleteAdvertisement/${adId}`
      );
      console.log(response);
      toast.success(`Xóa bản nháp ${adId} thành công`);
      fetchAdvertisements();
    } catch (error) {
      console.log(error.response.data);
      toast.error(`Xóa bản nháp ${adId} thất bại`);
    } finally {
      setLoading(false);
    }
  };
  


  const columns = [
    {
      title: "Tiêu đề",
      dataIndex: "heading",
      key: "heading",
      ellipsis: true,
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      width: 120,
      render: (status) => {
        return <span style={{ color: getStatusColor(status)  }}>{getStatusText(status)}</span>;
      },
    },
    {
      title: "Ngày bắt đầu",
      dataIndex: "startDate",
      key: "startDate",
      width: 120,
      render: (startDate) =>
        startDate ? moment(startDate).format("DD/MM/YY") : "Chưa có",
    },
    {
      title: "Ngày hết hạn",
      dataIndex: "expirationDate",
      key: "expirationDate",
      width: 120,
      render: (expirationDate) => {
        if (!expirationDate) return "Chưa có";
        const date = new Date(expirationDate);
        return date.toLocaleDateString("vi-VN", {
          year: "numeric",
          month: "2-digit",
          day: "2-digit",
        });
      },
    },
    {
      title: "Hành động",
      key: "action",
      className: "action-cell",
      render: (_, record) => {
        const currentDate = new Date();
        const expirationDate = new Date(record.expirationDate);
        const sevenDaysAfterExpiration = new Date(
          expirationDate.getTime() + 7 * 24 * 60 * 60 * 1000
        );

        if (record.status === "Draft") {
          return (
            <div className="action-button">
              <Button onClick={() => handleUpdateDraft(record)}>
                Cập nhật bản nháp
              </Button>
              <Popconfirm
                title="Xóa bản nháp"
                description="Bạn có muốn xóa bản nháp này ?"
                onConfirm={() => handleDeleteAd(record.adId)}
                okText="Có"
                cancelText="Không"
                okButtonProps={{
                  style: { width: "90px", height: "30px" },
                  loading: loading,
                }}
                cancelButtonProps={{ style: { width: "90px", height: "30px" } }}
              >
                <Button danger>Xóa bản nháp</Button>
              </Popconfirm>
            </div>
          );
        } else if (
          record.status === "Approved" &&
          currentDate > expirationDate &&
          currentDate <= sevenDaysAfterExpiration
        ) {
          return (
            <Button onClick={() => handleExtendAd(record.adId)}>Gia hạn</Button>
          );
        }
        return null;
      },
    },
  ];

  const handleEditAd = (adId) => {
    navigate(`/edit-ad/${adId}`);
  };

  const handleUpdateDraft = (advertisement) => {
    navigate("/create-ads", { state: { advertisement } });
  };

  const handleExtendAd = (adId) => {
    // Implement the logic to extend the advertisement
    console.log(`Extending advertisement with ID: ${adId}`);
    // You might want to navigate to an extension page or open a modal
    // For example:
    // navigate(`/extend-ad/${adId}`);
  };

  return (
    <>
      <HeaderTemplate />
      <Layout style={{ minHeight: "100vh", backgroundColor: "white" }}>
        <Layout>
          <Content style={{ margin: "16px" }}>
            <div
              className="container-ads"
              style={{ padding: 24, background: "#fff", minHeight: 360 }}
            >
              <div className="Heading">
                <h1>Chào mừng đến với trang Quảng cáo của bạn!</h1>
                <button onClick={handleCreate} className="btn-create">
                  Tạo bản nháp
                </button>
              </div>
              <Menu
                className="menu"
                theme="light"
                mode="horizontal"
                selectedKeys={[selectedStatus]}
                onClick={handleMenuClick}
              >
                {menuItems.map((item) => (
                  <Menu.Item key={item.key}>{item.label}</Menu.Item>
                ))}
              </Menu>
              <Table columns={columns} dataSource={filteredAds} rowKey="id" />
            </div>
          </Content>
        </Layout>
      </Layout>
    </>
  );
};

export default User_Ads;
