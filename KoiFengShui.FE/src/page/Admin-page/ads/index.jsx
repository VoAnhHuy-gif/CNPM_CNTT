import React, { useEffect, useState } from "react";
import api from "../../../config/axios";

import moment from "moment"; // Add this import for date formatting
import {
  Table,
  Button,
  message,
  Image,
  Typography,
  Space,
  Menu,
  Modal,
  Select,
  Form,
  Rate,
  Popconfirm,
} from "antd";
import { DeleteOutlined } from "@ant-design/icons";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import "./index.css"; // Đảm bảo bạn đã import file CSS


const { Text } = Typography;

const Ads = () => {
  const navigate = useNavigate();
  const [data, setData] = useState([]); // Khởi tạo state để lưu trữ dữ liệu
  const [filteredData, setFilteredData] = useState([]);
  const [selectedStatus, setSelectedStatus] = useState("all");
  const [elements, setElements] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [currentAdId, setCurrentAdId] = useState(null);
  const [currentStatus, setCurrentStatus] = useState(null);
  const [form] = Form.useForm();
  const [isApproving, setIsApproving] = useState(false);
  const [currentElementId, setCurrentElementId] = useState(null);
  const [feedbackModalVisible, setFeedbackModalVisible] = useState(false);
  const [currentAdFeedback, setCurrentAdFeedback] = useState([]);
  const [selectedStars, setSelectedStars] = useState("all");
  const [loading, setLoading] = useState(false);

  const menuItems = [
    { key: "all", label: "Tất cả" },
    { key: "Pending", label: "Đang chờ" },
    { key: "Approved", label: "Đã duyệt" },
    { key: "Canceled", label: "Đã hủy" },
    { key: "Refunded", label: "Đã hoàn tiền" },
  ];

  const fetchData = async () => {
    try {
      const response = await api.get(
        "Advertisement/GetAdvertisementsWithPackageSortedAdmin"
      );
      setData(response.data);
      filterAds("all");
    } catch (error) {
      console.error("Lỗi khi tải danh sách quảng cáo:", error);
      toast.error(error.response.data || "Không thể tải danh sách quảng cáo");
    }
  };

  useEffect(() => {
    fetchData();
    fetchElements();
  }, []);

  useEffect(() => {
    filterAds(selectedStatus);
  }, [selectedStatus, data]);

  const filterAds = (status) => {
    if (status === "all") {
      setFilteredData(data);
    } else {
      const filtered = data.filter((ad) => ad.status === status);
      setFilteredData(filtered);
    }
  };

  const handleMenuClick = (e) => {
    setSelectedStatus(e.key);
  };

  const rankPriority = {
    Diamond: 1,
    Gold: 2,
    Silver: 3,
  };

  const statusPriority = {
    Pending: 1,
    Approved: 2,
    Canceled: 3,
    Refunded: 4,
  };

  const fetchFeedbackForAd = async (adId) => {
    try {
      const response = await api.get("Feedback/GetAllFeedBack");
      const adFeedback = response.data.filter(
        (feedback) => feedback.adId === adId
      );
      setCurrentAdFeedback(adFeedback);
      setFeedbackModalVisible(true);
    } catch (error) {
      console.error("Lỗi khi tải đánh giá:", error);
      toast.error("Không thể tải đánh giá");
    }
  };

  const handleDeleteFeedback = async (fbId) => {
    try {
      await api.delete(`Feedback/DeleteFeedBack/${fbId}`);
      toast.success("Đánh giá đã xóa thành công");
      // Refresh the feedback list
      setFeedbackModalVisible(false);
    // Reset các state liên quan nếu cần
    setCurrentAdFeedback([]);
    setSelectedStars("all");
    } catch (error) {
      console.error("Error deleting feedback:", error);
      toast.error(error.response?.data || "Có lỗi khi xóa đánh giá");
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
  const columns = [
    {
      title: "Tiêu đề",
      dataIndex: "heading",
      key: "heading",
      ellipsis: true,
    },
    {
      title: "Hình ảnh",
      dataIndex: "image",
      key: "image",
      render: (image) => <Image src={image} alt="Ad" className="ads-image" />,
    },
    {
      title: "Nội dung",
      key: "content",
      render: (_, record) => (
        <Button
          type="link"
          className="ads-view-details"
          onClick={() => navigate(`/advertisement-detail/${record.adId}`)}
        >
          Xem chi tiết
        </Button>
      ),
    },
    {
      title: "Mệnh",
      dataIndex: "elementId",
      key: "elementId",
      render: (elementId) => (
        <Text
          style={{
            color:
              elementId === "Kim"
                ? "#FFD700"
                : elementId === "Mộc"
                ? "#228B22"
                : elementId === "Thủy"
                ? "#1E90FF"
                : elementId === "Hỏa"
                ? "#FF4500"
                : elementId === "Thổ"
                ? "#8B4513"
                : "#000000",
            fontWeight: "bold",
          }}
        >
          {elementId}
        </Text>
      ),
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      render: (status) => {
        return <span style={{ color: getStatusColor(status)  }}>{getStatusText(status)}</span>;
      },

      sorter: (a, b) => statusPriority[a.status] - statusPriority[b.status],

      sortDirections: ["descend", "ascend"],
    },
    {
      title: "Rank",
      dataIndex: "rank",
      key: "rank",
      render: (rank) => (
        <Text className={`ads-rank-${rank.toLowerCase()}`}>
          {rank || "N/A"}
        </Text>
      ),
      sorter: (a, b) =>
        (rankPriority[a.rank] || Infinity) - (rankPriority[b.rank] || Infinity),
      sortDirections: ["descend", "ascend"],
    },
    {
      title: "Ngày tạo",
      dataIndex: "createAt",
      key: "createAt",
      render: (createAt) =>
        createAt ? moment(createAt).format("DD/MM/YY HH:mm") : "N/A",
    },
    {
      title: "Ngày bắt đầu",
      dataIndex: "startDate",
      key: "startDate",
      render: (startDate) =>
        startDate ? moment(startDate).format("DD/MM/YY HH:mm") : "N/A",
    },
    {
      title: "Ngày hết hạn",
      dataIndex: "expiredDate",
      key: "expiredDate",
      render: (expiredDate) =>
        expiredDate ? moment(expiredDate).format("DD/MM/YY HH:mm") : "N/A",

    },
    {
      title: "Duyệt bài",
      key: "action",

      render: (_, record) => {
        const isApproved = record.status === "Approved";
        const isRefunded = record.status === "Refunded";
        const isCanceled = record.status === "Canceled";
        const isDisabled = isApproved || isRefunded || isCanceled;
        return (
          <Space
            size="small"
            direction="vertical"
            className="ads-action-buttons"
          >
            <Button
              type="primary"
              onClick={() => handleUpdateStatus(record.adId, "Approved")}
              disabled={isDisabled}
            >
              Phê duyệt
            </Button>
            {isCanceled ? (
              <Button
                type="primary"
                danger
                onClick={() => handleUpdateStatus(record.adId, "Refunded")}
                disabled={isApproved || isRefunded}
              >
                Hoàn trả
              </Button>
            ) : (
              <Button
                type="primary"
                danger
                onClick={() => handleUpdateStatus(record.adId, "Canceled")}
                disabled={isApproved || isRefunded}
              >
                Hủy bỏ
              </Button>
            )}
          </Space>
        );
      },
    },
    {
      title: "Đánh giá",
      key: "feedback",
      render: (_, record) => (
        <Button
          onClick={() => fetchFeedbackForAd(record.adId)}
          className="ads-view-details"
        >
          Xem đánh giá
        </Button>
      ),
    },
  ];

  const fetchElements = async () => {
    try {
      const response = await api.get("Element/GetAllElement");
      setElements(response.data);
    } catch (error) {
      console.error("Error fetching elements:", error);
      toast.error(error.response.data || "Không thể tải danh sách element");
    }
  };

  const handleUpdateStatus = (adId, status) => {
    const ad = data.find((item) => item.adId === adId);
    setCurrentAdId(adId);
    setCurrentStatus(status);
    setIsApproving(status === "Approved");
    setCurrentElementId(ad.elementId); // Set the current element ID
    setIsModalVisible(true);

    if (status === "Approved") {
      form.setFieldsValue({ elementId: ad.elementId }); // Pre-set the form field
    }
  };

  const handleModalOk = async () => {
    setLoading(true);
    try {
      if (isApproving) {
        const values = await form.validateFields();
        await api.put(
          `Advertisement/ApproveAdvertisement?adId=${currentAdId}&elementID=${values.elementId}&status=${currentStatus}`
        );
      } else {
        // Sử dụng API mới cho hủy bỏ/hoàn tiền
        await api.put(
          `Advertisement/UpdateAdvertisementStatus?adId=${currentAdId}&status=${currentStatus}`
        );

        if (currentStatus === "Refunded") {
          await api.post(`Advertisement/RefundNotification?adId=${currentAdId}`);
        }
      }

      toast.success(
        `Cập nhật trạng thái thành công của bài quảng cáo ${currentAdId} thành ${currentStatus}`
      );
      fetchData();
      resetModalData();
    } catch (error) {
      console.error("Error updating status:", error);
      toast.error(
        error.response.data ||
          `Cập nhật trạng thái thất bại của bài quảng cáo ${currentAdId}`
      );
    } finally {
      setLoading(false);
    }
  };

  const handleModalCancel = () => {
    resetModalData();
  };

  const resetModalData = () => {
    setIsModalVisible(false);
    setCurrentAdId(null);
    setCurrentStatus(null);
    setIsApproving(false);
    form.resetFields();
  };

  const filterFeedbackByStars = (feedback) => {
    if (selectedStars === "all") return feedback;
    return feedback.filter((item) => item.rate === selectedStars);
  };

  return (
    <div className="ads-management">
      <h1>Quản lý quảng cáo</h1>
      <Menu
        mode="horizontal"
        selectedKeys={[selectedStatus]}
        onClick={handleMenuClick}
        style={{ marginBottom: 16 }}
      >
        {menuItems.map((item) => (
          <Menu.Item key={item.key}>{item.label}</Menu.Item>
        ))}
      </Menu>
      <Table
        dataSource={filteredData}
        columns={columns}
        className="ads-table"
        pagination={{ pageSize: 10 }}
        scroll={{ x: true }}
      />
      <Modal
        title={
          isApproving
            ? "Phê duyệt quảng cáo"
            : `${
                currentStatus === "Canceled" ? "Hủy bỏ" : "Hoàn tiền"
              } quảng cáo`
        }
        visible={isModalVisible}
        onOk={handleModalOk}
        onCancel={handleModalCancel}
        confirmLoading={loading}
      >
        {isApproving ? (
          <Form form={form} initialValues={{ elementId: currentElementId }}>
            <Form.Item
              name="elementId"
              rules={[{ required: true, message: "Vui lòng chọn một element" }]}
            >
              <Select
                style={{ width: "100%" }}
                onChange={(value) => setCurrentElementId(value)}
              >
                {elements.map((element) => (
                  <Select.Option
                    key={element.elementId}
                    value={element.elementId}
                  >
                    {element.elementId}
                  </Select.Option>
                ))}
              </Select>
            </Form.Item>
          </Form>
        ) : (
          <p>
            Bạn có chắc chắn muốn{" "}
            {currentStatus === "Canceled" ? "hủy bỏ" : "hoàn tiền"} quảng cáo
            này?
          </p>
        )}
      </Modal>
      <Modal
        title="Đánh giá quảng cáo"
        visible={feedbackModalVisible}
        onCancel={() => {
          setFeedbackModalVisible(false);
          setSelectedStars("all");
        }}
        footer={null}
      >
        <div className="feedback-filter">
          <Select
            style={{ width: 200 }}
            placeholder="Lọc theo số sao"
            onChange={(value) => setSelectedStars(value)}
            value={selectedStars}
          >
            <Select.Option value="all">Tất cả</Select.Option>
            <Select.Option value={5}>
              <Rate disabled defaultValue={5} count={5} />
            </Select.Option>
            <Select.Option value={4}>
              <Rate disabled defaultValue={4} count={4} />
            </Select.Option>
            <Select.Option value={3}>
              <Rate disabled defaultValue={3} count={3} />
            </Select.Option>
            <Select.Option value={2}>
              <Rate disabled defaultValue={2} count={2} />
            </Select.Option>
            <Select.Option value={1}>
              <Rate disabled defaultValue={1} count={1} />
            </Select.Option>
          </Select>
        </div>

        {filterFeedbackByStars(currentAdFeedback).length > 0 ? (
          filterFeedbackByStars(currentAdFeedback).map((feedback) => (
            <div key={feedback.fbId} className="feedback-item">
              <p>
                <strong>Người dùng:</strong> {feedback.userId}
              </p>
              <p>
                <strong>Nội dung:</strong> {feedback.description}
              </p>
              <Rate disabled defaultValue={feedback.rate} />
              <Popconfirm
                title="Bạn có chắc muốn xóa đánh giá này?"
                onConfirm={() => handleDeleteFeedback(feedback.fbId)}
                okText="OK"
                cancelText="Hủy"
                okButtonProps={{ style: { width: "90px" , height: "30px"} }}
                cancelButtonProps={{ style: { width: "90px", height: "30px" } }}
              >
                <Button
                  type="text"
                  icon={<DeleteOutlined />}
                  danger
                  style={{ marginLeft: "10px" }}
                >
                  Xóa
                </Button>
              </Popconfirm>
            </div>
          ))
        ) : (
          <p>
            Không có đánh giá nào cho quảng cáo này hoặc không có đánh giá phù
            hợp với bộ lọc.
          </p>
        )}
      </Modal>
    </div>
  );
};

export default Ads;
