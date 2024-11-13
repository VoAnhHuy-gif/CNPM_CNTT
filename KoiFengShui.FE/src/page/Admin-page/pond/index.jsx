
import React, { useState, useEffect } from "react";
import { Button, Modal, Upload, message, Image, Popconfirm } from "antd";
import { PlusOutlined } from "@ant-design/icons";
import "./index.css";
import api from "../../../config/axios"
import uploadFile from "../../../utils/file";

const Pond = () => {
  const [data, setData] = useState([]);
  const [editingPond, setEditingPond] = useState(null);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [fileList, setFileList] = useState([]);
  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewImage, setPreviewImage] = useState("");

  useEffect(() => {
    fetchData();
  }, []); // Chạy một lần khi component mount
  const fetchData = async () => {
    try {
      const response = await api.get("Shape/GetAllShape"); // Thay thế 'API_URL' bằng URL thực tế
      console.log("Fetched data:", response.data); // Kiểm tra dữ liệu nhận được
      setData(response.data); // Lưu trữ dữ liệu vào state
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const handleEdit = (pond) => {
    setEditingPond(pond);
    setFileList(pond.image ? [{ url: pond.image, uid: '-1', name: 'image.png' }] : []);
    setIsModalVisible(true);
  };

  const handleModalCancel = () => {
    setIsModalVisible(false);
    setEditingPond(null);
    setFileList([]);
  };

  const handleUpdate = async () => {
    try {
      let imageUrl = editingPond.image;
      if (fileList.length > 0 && fileList[0].originFileObj) {
        const file = fileList[0].originFileObj;
        imageUrl = await uploadFile(file);
      }

      const response = await api.put("Shape/UpdateShape", {
        shapeId: editingPond.shapeId,
        image: imageUrl
      });

      if (response.status === 200) {
        message.success("Cập nhật hồ thành công");
        setIsModalVisible(false);
        fetchData();
      }
    } catch (error) {
      console.error("Lỗi khi cập nhật hồ:", error);
      message.error("Không thể cập nhật hồ");
    }
  };

  const getBase64 = (file) =>
    new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result);
      reader.onerror = (error) => reject(error);
    });

  const handlePreview = async (file) => {
    if (!file.url && !file.preview) {
      file.preview = await getBase64(file.originFileObj);
    }
    setPreviewImage(file.url || file.preview);
    setPreviewOpen(true);
  };

  const handleChange = ({ fileList: newFileList }) => setFileList(newFileList);

  const uploadButton = (
    <button
      style={{
        border: 0,
        background: "none",
      }}
      type="button"
    >
      <PlusOutlined />
      <div style={{ marginTop: 8 }}>Tải lên</div>
    </button>
  );

  return (
    <div>
      <h1>Quản lý hồ cá Koi</h1>
      <div className="dashboard-content">
        {data.length > 0 ? (
          data.map((item) => (
            <div key={item.shapeId} className="pond-item">
              <h3>{item.shapeId}</h3>
              <Image src={item.image} alt={item.shapeId} />
              <Button type="primary" onClick={() => handleEdit(item)}>Cập nhật</Button>
            </div>
          ))
        ) : (
          <p>Không có dữ liệu</p>
        )}
      </div>

      <Modal
        title="Cập nhật hồ"
        visible={isModalVisible}
        onOk={handleUpdate}
        onCancel={handleModalCancel}
      >
        <Upload
          listType="picture-card"
          fileList={fileList}
          onPreview={handlePreview}
          onChange={handleChange}
          beforeUpload={() => false}
        >
          {fileList.length >= 1 ? null : uploadButton}
        </Upload>
      </Modal>
      {previewImage && (
        <Image
          style={{
            display: "none",
          }}
          src={previewImage}
          preview={{
            visible: previewOpen,
            onVisibleChange: (visible) => setPreviewOpen(visible),
          }}
        />
      )}
    </div>
  );
};

export default Pond;
