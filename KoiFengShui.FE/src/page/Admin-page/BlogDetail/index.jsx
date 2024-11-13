import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import api from "../../../config/axios";
import HeaderTemplate from "../../../components/header-page";
import { Spin } from 'antd';
import './index.css';

function BlogDetail() {
  const [blogData, setBlogData] = useState(null);
  const [loading, setLoading] = useState(true);
  const { id } = useParams();

  useEffect(() => {
    const fetchBlogData = async () => {
      try {
        const response = await api.get(`Blog/GetBlogByID?blog=${id}`);
        setBlogData(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching blog:', error);
        setLoading(false);
      }
    };

    fetchBlogData();
  }, [id]);

  return (
    <>
      <HeaderTemplate />
      <div className="blog-detail-container">
        {loading ? (
          <Spin size="large" />
        ) : (
          <>
            <div dangerouslySetInnerHTML={{ __html: blogData.link }} />
          </>
        )}
      </div>
    </>
  );
}

export default BlogDetail;
