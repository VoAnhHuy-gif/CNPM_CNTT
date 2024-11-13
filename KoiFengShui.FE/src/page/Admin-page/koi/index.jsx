import { useEffect, useState } from "react"; // Thêm useEffect và useState

import api from "../../../config/axios";
import {
  Button,
  Form,
  Image,
  Input,
  Modal,
  Table,
  Upload,
  Space,
  Select,
  Popconfirm,
  Flex,
  Typography,
} from "antd";
import { toast } from "react-toastify";
import {
  PlusOutlined,
  MinusCircleOutlined,
  PlusCircleOutlined,
} from "@ant-design/icons";

import { useForm } from "antd/es/form/Form";
import uploadFile from "../../../utils/file";

const { Option } = Select;
const { Text } = Typography;

const Koi = () => {
  const [data, setData] = useState([]); // Khởi tạo state để lưu trữ dữ liệu
  const [openModal, setOpenModal] = useState(false); //mac dinh modal dong
  const [submitting, setSubmitting] = useState(false);
  const [form] = useForm();
  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewImage, setPreviewImage] = useState("");
  const [fileList, setFileList] = useState([]);
  const [colors, setColors] = useState([]);
  const [loading, setLoading] = useState(false);
  const [colorModalVisible, setColorModalVisible] = useState(false);
  const [colorForm] = Form.useForm();
  const [editingKoi, setEditingKoi] = useState(null);
  const [isEditing, setIsEditing] = useState(false);
  const [elements, setElements] = useState([]);
  useEffect(() => {
    fetchDataAndColors();
    fetchColors();
    fetchElements();
  }, []); // Chạy một lần khi component mount

  const fetchDataAndColors = async () => {
    try {
      const [koiResponse, colorResponse] = await Promise.all([
        api.get("KoiVariety/GetAllKoi"),
        api.get("TypeColor/GetAllTypeColor"),
      ]);

      const koiData = koiResponse.data;
      const colorData = colorResponse.data;

      const combinedData = koiData.map((koi) => {
        const koiColors = colorData.filter(
          (color) => color.koiType === koi.koiType
        );
        return {
          ...koi,
          colors: koiColors,
        };
      });

      setData(combinedData);
    } catch (error) {
      console.error("Error fetching data:", error);
      toast.error("Không thể tải dữ liệu");
    }
  };

  const fetchColors = async () => {
    try {
      const response = await api.get("Color/GetAllColor");
      // Chỉ lấy colorId từ dữ liệu API
      const colorIds = response.data.map((color) => color.colorId);
      setColors(colorIds);
    } catch (error) {
      console.error("Error fetching colors:", error);
      toast.error("Không thể tải danh sách màu");
    }
  };

  const fetchElements = async () => {
    try {
      const response = await api.get("Element/GetAllElement");
      setElements(response.data);
    } catch (error) {
      console.error("Lỗi khi tải danh sách mệnh:", error);
      toast.error("Không thể tải danh sách mệnh");
    }
  };

  const columns = [
    {
      title: "Giống cá Koi",
      dataIndex: "koiType",
    },
    {
      title: "Hình ảnh",

      dataIndex: "image",
      render: (image) => {
        return <Image src={image} alt="" width={100}></Image>;
      },
    },
    {
      title: "Mệnh của cá",
      dataIndex: "element",
      render: (element) => (
        <Text
          style={{
            color:
              element === "Kim"
                ? "#FFD700"
                : element === "Mộc"
                ? "#228B22"
                : element === "Thủy"
                ? "#1E90FF"
                : element === "Hỏa"
                ? "#FF4500"
                : element === "Thổ"
                ? "#8B4513"
                : "#000000",
            fontWeight: "bold",
          }}
        >
          {element}
        </Text>
      ),
    },
    {
      title: "Thông tin giới thiệu",
      dataIndex: "description",
      width: 450,
    },
    {
      title: "Màu sắc",

      dataIndex: "colors",
      render: (colors) => (
        <ul>
          {colors.map((color, index) => (
            <li key={index}>
              {color.colorId}: {color.percentage.toFixed(2)}
            </li>
          ))}
        </ul>
      ),
    },
    {
      title: "Hành động",
      dataIndex: "koiType",
      key: "koiType",
      width: 160, // Giảm chiều rộng của cột
      render: (_, koi) => (
        <Space size={4} style={{ display: "flex", justifyContent: "center" }}>
          {" "}
          {/* Giảm khoảng cách giữa các nút */}
          <Button
            type="primary"
            onClick={() => handleEdit(koi)}
            style={{
              fontSize: "15px",
              padding: "0 8px",
              height: "24px",
              width: "80px",
            }}
          >
            Chỉnh sửa
          </Button>
          <Popconfirm
            title="Xóa cá Koi"
            description="Bạn có chắc muốn xóa loại cá này?"
            onConfirm={() => handleDeleteKoi(koi.koiType)}
            okText="Có"
            cancelText="Không"
            okButtonProps={{
              style: { width: "90px", height: "30px" },
              loading: loading,
            }}
            cancelButtonProps={{ style: { width: "90px", height: "30px" } }}
          >
            <Button
              type="primary"
              danger
              style={{
                fontSize: "15px",
                padding: "0 8px",
                height: "24px",
                width: "80px",
              }}
            >
              Xóa cá Koi
            </Button>
          </Popconfirm>
        </Space>
      ),
    },
  ];

  const handleDeleteKoi = async (koiType) => {
    setLoading(true);
    try {
      const response = await api.delete(
        `KoiVariety/DeleteKoiAndTypeColor/${koiType}`
      );
      toast.success(response.data);
      fetchDataAndColors();
    } catch (error) {
      toast.error(error.response.data);
    } finally {
      setLoading(false);
    }
  };
  const handleOpenModal = () => {
    setIsEditing(false);
    form.resetFields();
    setFileList([]);

    setOpenModal(true);
  };

  const handleCloseModal = () => {
    setOpenModal(false);
  };

  const handleEdit = (koi) => {
    setIsEditing(true);
    setEditingKoi(koi);
    form.setFieldsValue({
      koiType: koi.koiType,
      element: koi.element,
      description: koi.description,
      colors: koi.colors.map((color) => ({
        colorId: color.colorId,
        percentage: color.percentage,
      })),
    });
    setFileList(
      koi.image ? [{ url: koi.image, uid: "-1", name: "image.png" }] : []
    );
    setOpenModal(true);
  };

  const handleSubmit = async (values) => {
    // Kiểm tra tổng tỉ trọng
    setLoading(true);
    const totalPercentage = values.colors.reduce(
      (sum, color) => sum + parseFloat(color.percentage || 0),
      0
    );

    if (Math.abs(totalPercentage - 1) > 0.001) {
      toast.error("Tổng tỉ trọng màu phải bằng 1");
      return;
    }
    try {
      setSubmitting(true);
      let imageUrl = "";
      if (fileList.length > 0 && fileList[0].originFileObj) {
        const file = fileList[0].originFileObj;
        imageUrl = await uploadFile(file);
      } else if (isEditing && editingKoi.image) {
        imageUrl = editingKoi.image;
      }

      const koiData = {
        ...values,
        image: imageUrl,
        colors: values.colors.map((color) => ({
          colorId: color.colorId.toString(),
          percentage: parseFloat(color.percentage),
        })),
      };

      if (isEditing) {
         await api.put("KoiVariety/UpdateKoiAndTypeColor", koiData);
        toast.success("Cập nhật thành công");
      } else {
         await api.post("KoiVariety/AddKoiAndTypeColor", koiData);
        toast.success("Tạo mới thành công");
      }
      setOpenModal(false);
      form.resetFields();
      fetchDataAndColors();
      setEditingKoi(null);
      setIsEditing(false);
    } catch (err) {
      toast.error(err.response?.data || "Có lỗi xảy ra");
    } finally {
      setLoading(false);
      setSubmitting(false);
    }
  };

  const handleAddColor = async (values) => {
    setLoading(true);
    const formattedValues = {
      colorID: values.colorID,
      elementPoint: Object.entries(values.elementPoints).map(
        ([elementID, point]) => ({
          elementID,
          point: parseFloat(point),
        })
      ),
    };

    try {
      await api.post("Color/AddColorAndElement", formattedValues);
      toast.success("Màu mới đã được thêm thành công");
      setColorModalVisible(false);
      colorForm.resetFields();
      fetchColors();
    } catch (error) {
      console.error("Error adding new color:", error);
      toast.error("Không thể thêm màu mới");
    } finally {
      setLoading(false);
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
      <div
        style={{
          marginTop: 8,
        }}
      >
        Upload
      </div>
    </button>
  );

  return (
    <div>
      <h1>Quản lý cá Koi</h1>
      <Space>
        <Button onClick={handleOpenModal}>Tạo mới loại cá Koi</Button>
        <Button onClick={() => setColorModalVisible(true)}>
          Quản lý màu sắc
        </Button>
      </Space>
      <Table dataSource={data} columns={columns} />
      <Modal
        confirmLoading={submitting}
        onOk={() => form.submit()}
        title={isEditing ? "Chỉnh sửa cá Koi" : "Tạo một giống cá Koi mới"}
        open={openModal}
        onCancel={() => {
          handleCloseModal();
          setEditingKoi(null);
          setIsEditing(false);
          form.resetFields();
        }}
      >
        <Form onFinish={handleSubmit} form={form}>
          <Form.Item
            label="Giống cá Koi"
            name="koiType"
            rules={[
              {
                required: true,
                message: "Hãy nhập loại cá Koi",
              },
            ]}
          >
            <Input />
          </Form.Item>

          <Form.Item
            label="Mệnh của cá"
            name="element"
            rules={[
              {
                required: true,
                message: "Hãy chọn mệnh của cá Koi",
              },
            ]}
          >
            <Select placeholder="Chọn mệnh của cá">
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
          <Form.Item
            label="Thông tin giới thiệu"
            name="description"
            rules={[
              {
                required: true,
                message: "Hãy nhập mô tả của cá Koi",
              },
            ]}
          >
            <Input.TextArea />
          </Form.Item>
          <Form.Item label="image" name="image">
            <Upload
              listType="picture-card"
              fileList={fileList}
              onPreview={handlePreview}
              onChange={handleChange}
              beforeUpload={() => false} // Prevent auto upload
            >
              {fileList.length >= 1 ? null : uploadButton}
            </Upload>
          </Form.Item>
          <Form.List name="colors">
            {(fields, { add, remove }) => (
              <>
                {fields.map(({ key, name, ...restField }) => (
                  <Space
                    key={key}
                    style={{ display: "flex", marginBottom: 8 }}
                    align="baseline"
                  >
                    <Form.Item
                      {...restField}
                      name={[name, "colorId"]}
                      rules={[{ required: true, message: "Chọn màu" }]}
                    >
                      <Select style={{ width: 120 }} placeholder="Chọn màu">
                        {colors.map((colorId) => (
                          <Option key={colorId} value={colorId}>
                            {colorId}
                          </Option>
                        ))}
                      </Select>
                    </Form.Item>
                    <Form.Item
                      {...restField}
                      name={[name, "percentage"]}
                      rules={[
                        { required: true, message: "Nhập tỉ trọng" },
                        {
                          validator: async (_, value) => {
                            if (value && (value < 0 || value > 1)) {
                              throw new Error("Tỉ trọng phải từ 0 đến 1");
                            }
                          },
                        },
                      ]}
                    >
                      <Input
                        type="number"
                        step="0.01"
                        placeholder="Tỉ trọng (0-1)"
                      />
                    </Form.Item>
                    <MinusCircleOutlined onClick={() => remove(name)} />
                  </Space>
                ))}
                <Form.Item>
                  <Space>
                    <Button
                      type="dashed"
                      onClick={() => add()}
                      icon={<PlusOutlined />}
                    >
                      Thêm màu
                    </Button>
                  </Space>
                </Form.Item>
              </>
            )}
          </Form.List>
        </Form>
      </Modal>

      <Modal
        title="Quản lý màu sắc"
        open={colorModalVisible}
        onCancel={() => setColorModalVisible(false)}
        footer={null}
      >
        <Form form={colorForm} onFinish={handleAddColor}>
          <Form.Item
            name="colorID"
            label="Tên màu"
            rules={[{ required: true, message: "Vui lòng nhập tên màu" }]}
          >
            <Input />
          </Form.Item>
          {["Hỏa", "Thủy", "Mộc", "Kim", "Thổ"].map((element) => (
            <Form.Item
              key={element}
              name={["elementPoints", element]}
              label={element}
              rules={[{ required: true, message: "Vui lòng chọn điểm" }]}
            >
              <Select placeholder="Chọn điểm">
                <Option value="0.25">0.25</Option>
                <Option value="0.5">0.5</Option>
                <Option value="0.75">0.75</Option>
                <Option value="1">1</Option>
              </Select>
            </Form.Item>
          ))}
          <Form.Item>
            <Button type="primary" htmlType="submit">
              Thêm màu mới
            </Button>
          </Form.Item>
        </Form>
      </Modal>

      {previewImage && (
        <Image
          wrapperStyle={{
            display: "none",
          }}
          preview={{
            visible: previewOpen,
            onVisibleChange: (visible) => setPreviewOpen(visible),
            afterOpenChange: (visible) => !visible && setPreviewImage(""),
          }}
          src={previewImage}
        />
      )}
    </div>
  );
};

export default Koi;
