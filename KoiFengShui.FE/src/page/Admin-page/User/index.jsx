import React, { useEffect, useState } from "react";
import { Table, Space, Button, Input, Select } from "antd"; // Added Select import
import api from "../../../config/axios";
import "./index.css";
import { toast } from "react-toastify";

const { Option } = Select; // Destructure Option from Select

const User = () => {
  const [userData, setUserData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editingUser, setEditingUser] = useState(null); // New state for editing
  const [searchUserID, setSearchUserID] = useState(""); // Thêm state cho tìm kiếm UserID
  const [searchRole, setSearchRole] = useState(""); // Thêm state cho tìm kiếm Role

  useEffect(() => {
    fetchUserData();
  }, []);

  const fetchUserData = async () => {
    try {
      setLoading(true);
      const response = await api.get("Account/GetAllAccountMemberInfo");
      setUserData(response.data);
    } catch (error) {
      console.error("Error fetching user data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleEdit = (user) => {
    setEditingUser(user); // Set the user to be edited
  };

  const handleSave = async (userID) => {
    try {
      await api.put("Account/UpdateAccountAdmin", {
        userID: userID,
        password: editingUser.password,
        status: editingUser.status,
      });
      toast.success("Cập nhật thành công");
      setEditingUser(null); // Clear editing state after saving
      fetchUserData(); // Refresh user data
    } catch (error) {
      console.error("Error updating user data:", error);
    }
  };

  const columns = [
    {
      title: "Tài khoản người dùng",
      dataIndex: "userID",
      key: "userID",
    },
    {
      title: "Mật khẩu",
      dataIndex: "password",
      key: "password",
      render: () => "***",
    },
    {
      title: "Tên",
      dataIndex: "name",
      key: "name",
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
    },
    {
      title: "Vai trò",
      dataIndex: "role",
      key: "role",
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      render: (text, record) =>
        editingUser?.userID === record.userID ? (
          <Select
            value={editingUser.status}
            onChange={(value) =>
              setEditingUser({ ...editingUser, status: value })
            }
          >
            <Option value="Active">Hoạt động</Option>
            <Option value="Banned">Bị cấm</Option>
          </Select>
        ) : (
          text
        ),
    },
    {
      title: "Ngày sinh",
      dataIndex: "birthday",
      key: "birthday",
      render: (birthday) => new Date(birthday).toLocaleDateString(),
    },
    {
      title: "Hành động",
      key: "action",
      render: (text, record) => (
        <Space direction="horizontal">
          {editingUser?.userID === record.userID ? (
            <Button type="primary" onClick={() => handleSave(record.userID)}>
              Lưu
            </Button>
          ) : (
            <Button type="primary" onClick={() => handleEdit(record)}>
              Cập nhật
            </Button>
          )}
        </Space>
      ),
    },
  ];

  const filteredUserData = userData.filter(
    (user) =>
      user.userID.toString().includes(searchUserID) && // Lọc theo UserID
      (searchRole ? user.role === searchRole : true) // Lọc theo Role nếu có
  );

  return (
    <div className="dashboard-container">
      <h2>Quản lí người dùng</h2>
      <div className="dashboard-content">
        <div className="search-container">
          {" "}
          {/* Thêm container cho ô tìm kiếm */}
          <div className="search-select-container">
            <h3>Tìm kiếm theo Role: </h3>
            <Select
              className="search-select" // Thêm lớp cho ô chọn Role
              placeholder="Filter:"
              value={searchRole}
              onChange={(value) => setSearchRole(value)}
            >
              <Option value="">All</Option>
              <Option value="Admin">Admin</Option>
              <Option value="Member">Member</Option>
            </Select>
          </div>
          <div className="search-input-container">
            <h3>Tìm kiếm tài khoản người dùng: </h3>
            <Input
              className="search-input" // Thêm lớp cho ô tìm kiếm UserID
              placeholder="Search UserID"
              value={searchUserID}
              onChange={(e) => setSearchUserID(e.target.value)}
              style={{ height: "30px" }}
            />
          </div>
        </div>
        <div className="user-management-table">
          <Table
            columns={columns}
            dataSource={filteredUserData}
            rowKey="userID"
            loading={loading}
            scroll={{ x: true }}
          />
        </div>
      </div>
    </div>
  );
};

export default User;
