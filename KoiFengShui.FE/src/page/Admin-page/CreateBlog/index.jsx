import React, { useState, useRef, useEffect } from 'react';
import { Editor } from '@tinymce/tinymce-react';
import { Button, message, Upload, Image } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import api from '../../../config/axios';
import { useNavigate, useLocation } from 'react-router-dom';
import './index.css';
import uploadFile from "../../../utils/file";

function CreateBlog() {
  const location = useLocation();
  const navigate = useNavigate();
  const [isLoading, setIsLoading] = useState(false); 

  const [blogData, setBlogData] = useState({
    blogId: '.',
    heading: '',
    image: '',
    link: '',
    status: 'Draft'
  });
  const editorRef = useRef(null);
  const [fileList, setFileList] = useState([]);
  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewImage, setPreviewImage] = useState("");

  useEffect(() => {
    const { blog } = location.state || {};
    if (blog) {
      setBlogData(prevData => ({
        ...prevData,
        ...blog
      }));
      if (blog.image) {
        setFileList([
          {
            uid: "-1",
            name: "blog-image.png",
            status: "done",
            url: blog.image,
          },
        ]);
      }
    }
  }, [location.state]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setBlogData(prevData => ({
      ...prevData,
      [name]: value
    }));
  };

  const handleEditorChange = (content, editor) => {
    setBlogData(prevData => ({
      ...prevData,
      link: content
    }));
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

  const handleChange = async ({ fileList: newFileList }) => {
    setFileList(newFileList);
    if (newFileList.length > 0 && newFileList[0].originFileObj) {
      try {
        const file = newFileList[0].originFileObj;
        const imageUrl = await uploadFile(file);
        setBlogData((prevData) => ({
          ...prevData,
          image: imageUrl,
        }));
      } catch (error) {
        console.error("Error uploading image:", error);
        message.error("Có lỗi xảy ra khi tải ảnh lên. Vui lòng thử lại.");
      }
    } else {
      setBlogData((prevData) => ({
        ...prevData,
        image: "",
      }));
    }
  };

  const uploadButton = (
    <button
      style={{
        border: 0,
        background: "none",
      }}
      type="button"
    >
      <PlusOutlined />
      <div style={{ marginTop: 8 }}>Tải ảnh bìa lên</div>
    </button>
  );
  const handleSave = async (status) => {
    try {
      setIsLoading(true);
      const updatedBlogData = {
        ...blogData,
        status: status,
      };

      let response;
      if (blogData.blogId === '.') {
        response = await api.post('Blog/AddBlog', updatedBlogData);
      } else {
        response = await api.put('Blog/UpdateBlog', updatedBlogData);
      }

      console.log('Response:', response.data);
      message.success(status === 'Draft' ? 'Bài viết đã được lưu thành công!' : 'Bài viết đã được đăng thành công!');
      navigate('/dashboard/blog');
    } catch (error) {
      console.error('Error:', error);
      message.error('Có lỗi xảy ra khi lưu bài viết. Vui lòng thử lại.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="blog-container">
      <h1>{blogData.blogId !== '.' ? 'Chỉnh sửa bài viết' : 'Tạo bài viết mới'}</h1>

      <input
        type="text"
        name="heading"
        value={blogData.heading}
        onChange={handleInputChange}
        placeholder="Tiêu đề bài viết"
        required
      />
      <Upload
            listType="picture-card"
            fileList={fileList}
            onPreview={handlePreview}
            onChange={handleChange}
            beforeUpload={() => false}
          >
            {fileList.length >= 1 ? null : uploadButton}
          </Upload>
      <Editor
        apiKey='48zvgxqbyrxhxjktp3nysk7hscrlqcz0143gyuhannv3rfv5'
        onInit={(evt, editor) => {
          editorRef.current = editor;
          if (blogData.link) {
            editor.setContent(blogData.link);
          }
        }}
        value={blogData.link || "<p>Viết nội dung bài viết của bạn ở đây.</p>"}
        init={{
          height: 500,
          plugins: [
            'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
            'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
            'insertdatetime', 'media', 'table', 'help', 'wordcount',
            'directionality', 'emoticons', 'template', 'paste', 'textcolor', 'colorpicker'
          ],
          toolbar: 'undo redo | blocks | ' +
            'bold italic backcolor | alignleft aligncenter ' +
            'alignright alignjustify | bullist numlist outdent indent | ' +
            'removeformat | link image | help | emoticons | template | ltr rtl',
          content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }',
          directionality: 'ltr',
          language: 'vi_VN',
        }}
        onEditorChange={handleEditorChange}
      />

      <div className="button-container">
        <Button 
          className="action-button save-button" 
          onClick={() => handleSave('Draft')}
          loading={isLoading}
        >
          Lưu bản nháp
        </Button>
        <Button 
          className="action-button publish-button" 
          onClick={() => handleSave('Published')}
          loading={isLoading}
        >
          Đăng bài
        </Button>
      </div>
      
      {blogData.link && (
        <div className="blog-preview">
          <h2>Nội dung bài viết:</h2>
          <div dangerouslySetInnerHTML={{ __html: blogData.link }} />
        </div>
      )}
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
}

export default CreateBlog;
