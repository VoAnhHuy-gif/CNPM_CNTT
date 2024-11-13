import React, { useEffect, useState } from "react";
import api from "../../../config/axios";
import { Button, Table, Form, Modal, InputNumber, Input, message } from "antd";
import { toast } from "react-toastify";

function PackageManagement() {
  const [packages, setPackages] = useState([]);
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const fetchPackages = async () => {
    try {
      const response = await api.get("Package/GetAllPackage");
      console.log(response.data);
      setPackages(response.data);
    } catch (error) {
      console.log(error.response.data);
    }
  };
  useEffect(() => {
    fetchPackages();
  }, []);
  const columns = [
    {
      title: "Tên gói",
      dataIndex: "rank",
    },
    {
      title: "Thời lượng",
      dataIndex: "duration",
      render: (duration) => `${duration} ngày`,
    },
    {
      title: "Giới thiệu gói",
      dataIndex: "description",
      ellipsis: true,
      width: 500,
    },
    {
      title: "Giá gói",
      dataIndex: "price",
      render: (price) =>
        `${price.toLocaleString("vi-VN", {
          style: "currency",
          currency: "VND",
        })}`,
    },
    {
      title: "Hành động",
      dataIndex: "rank",
      width: 200,
      render: (_, record) => (
        <Button
          type="primary"
          onClick={() => {
            setShowModal(true);
            form.setFieldsValue(record);
          }}
        >
          Sửa
        </Button>
      ),
    },
  ];
  const handleUpdatePackage = async (values) => {
    setLoading(true);
    try {
      await api.put("Package/UpdatePackage", values);
      toast.success("Cập nhật gói thành công");
      setShowModal(false);
      fetchPackages();
    } catch (error) {
      console.error(error.response.data);
      toast.error("Cập nhật gói thất bại");
    } finally {
      setLoading(false);
    }
  };
  return (
    <div>
      <h1>Quản lý gói Quảng cáo</h1>
      <Table dataSource={packages} columns={columns} />
      <Modal
        open={showModal}
        onCancel={() => setShowModal(false)}
        title="Cập nhật gói quảng cáo"
        onOk={() => form.submit()}
        confirmLoading={loading}
      >
        <Form
          form={form}
          onFinish={handleUpdatePackage}
          layout="vertical"
        >
          <Form.Item name="rank" label="Tên gói">
            <Input disabled />
          </Form.Item>
          <Form.Item name="description" label="Giới thiệu gói">
            <Input.TextArea disabled />
          </Form.Item>
          <Form.Item
            name="duration"
            label="Thời lượng (ngày)"
            rules={[{ required: true, message: 'Vui lòng nhập thời lượng' }]}
          >
            <InputNumber min={1} />
          </Form.Item>
          <Form.Item
            name="price"
            label="Giá gói (VNĐ)"
            rules={[{ required: true, message: 'Vui lòng nhập giá gói' }]}
          >
            <InputNumber
              min={0}
              formatter={(value) => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, '.')}
              parser={(value) => value.replace(/\./g, '')}
            />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
}

export default PackageManagement;
