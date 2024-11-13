
import React, { useState, useEffect } from "react";
import {  Layout, Menu, Table, Button, Popconfirm, message, Typography, Space } from "antd";
import { useNavigate } from "react-router-dom";
import api from "../../../config/axios";
import { DeleteOutlined, EditOutlined } from "@ant-design/icons";
import "./index.css";
import { toast } from "react-toastify";
const { Text } = Typography;

const Blog = () => {
  const navigate = useNavigate();
  const [blogs, setBlogs] = useState([]);
  const [filteredBlogs, setFilteredBlogs] = useState([]);
  const [selectedStatus, setSelectedStatus] = useState("all");
  const [loading, setLoading] = useState(false);
  const menuItems = [
    { key: "all", label: "Tất cả" },
    { key: "Draft", label: "Bản nháp" },
    { key: "Published", label: "Đã đăng" },
  ];

  useEffect(() => {
    fetchBlogs();
  }, []);

  useEffect(() => {
    filterBlogs(selectedStatus);
  }, [selectedStatus, blogs]);

  const fetchBlogs = async () => {
    try {
      const response = await api.get("Blog/GetAllBlog");
      setBlogs(response.data);
    } catch (error) {
      console.error("Error fetching blogs:", error);
    }
  };

  const filterBlogs = (status) => {
    if (status === "all") {
      setFilteredBlogs(blogs);
    } else {
      const filtered = blogs.filter((blog) => blog.status === status);
      setFilteredBlogs(filtered);
    }
  };

  const handleMenuClick = (e) => {
    setSelectedStatus(e.key);
  };

  const handleCreate = () => {
    navigate("/dashboard/create-blog", { state: { blog: null } });
  };

  const handleEdit = (blog) => {
    navigate("/dashboard/create-blog", { state: { blog } });
  };

  const handleDelete = async (blogId) => {
    setLoading(true);
    try {
      const response = await api.delete(`Blog/DeleteBlog/${blogId}`);
      toast.success(response.data);
      fetchBlogs(); // Cập nhật lại danh sách blog sau khi xóa
    } catch (error) {
      toast.error(error.response.data);
    } finally {
      setLoading(false);
    }
  };

  const statusPriority = {
    Draft: 1,
    Published: 2
  };
  const columns = [
    {
      title: "Blog",
      dataIndex: "blogId",
      key: "blogId",
    },
    {
      title: "Tiêu đề",
      dataIndex: "heading",
      key: "heading",
    },
    {
      title: "Hình ảnh",
      dataIndex: "image",
      key: "image",
      render: (_, record) => (
        <img
          src={record.image}
          alt="Blog Image"
          style={{
            width: "150px",
            height: "150px",
            objectFit: "cover",
            borderRadius: "4px",
          }}
        />
      ),
    },
    {
      title: "Nội dung",
      key: "content",
      render: (_, record) => (
        <Button
          type="link"
          onClick={() => navigate(`/blog-detail/${record.blogId}`)}
        >
          Xem chi tiết
        </Button>
      ),
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      render: (status) => (
        <Text
          style={{
            color: status === "Published" ? "#52c41a" : "#1890ff",
          }}
        >
          {status}
        </Text>
      ),
      sorter: (a, b) => statusPriority[a.status] - statusPriority[b.status],
      defaultSortOrder: 'ascend',
    },
    {
      title: "Hành động",
      key: "action",
      render: (_, record) => (
        <>
          <Button
            icon={<EditOutlined />}
            onClick={() => handleEdit(record)}
            style={{ marginRight: 8 }}
          >
            Chỉnh sửa
          </Button>
          <Popconfirm
            title="Bạn có chắc chắn muốn xóa bài viết này?"
            onConfirm={() => handleDelete(record.blogId)}
            okText="Có"
            cancelText="Không"
            okButtonProps={{
              style: { width: "90px", height: "30px" },
              loading: loading,
            }}
            cancelButtonProps={{ style: { width: "90px", height: "30px" } }}
          >
            <Button icon={<DeleteOutlined />} danger>
              Xóa
            </Button>
          </Popconfirm>
        </>
      ),
    },
  ];

  return (

      <div>
        <h1>Quản lý Blog</h1>
        <button onClick={handleCreate} className="btn-create">
          Tạo Blog
        </button>
        <Menu
        theme="light"
        mode="horizontal"
        selectedKeys={[selectedStatus]}
        onClick={handleMenuClick}
      >
        {menuItems.map((item) => (
          <Menu.Item key={item.key}>{item.label}</Menu.Item>
        ))}
      </Menu>
      <Table columns={columns} dataSource={filteredBlogs} rowKey="blogId" />

      </div>
  );
};

export default Blog;
