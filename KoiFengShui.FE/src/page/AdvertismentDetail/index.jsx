import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import api from "../../config/axios";
import HeaderTemplate from "../../components/header-page";
import { Spin, Input, Button, message, Rate, Select } from 'antd';
import './index.css';
import FooterTemplate from '../../components/footer-page';
const { Option } = Select;



function AdvertisementDetail() {
  const [adHtml, setAdHtml] = useState('');
  const [loading, setLoading] = useState(true);
  const [feedback, setFeedback] = useState('');
  const [rating, setRating] = useState(0);
  const { id } = useParams();
  const [allFeedback, setAllFeedback] = useState([]);
  const [filteredFeedback, setFilteredFeedback] = useState([]);
  const [filterRate, setFilterRate] = useState(0); // 0 means all ratings



  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const [adResponse, feedbackResponse] = await Promise.all([
          retryFetch(() => api.get(`Advertisement/GetAdvertisementByAdId?adId=${id}`)),
          retryFetch(() => api.get(`Feedback/GetFeedBackByAdId?AdId=${id}`))
        ]);

        setAdHtml(adResponse.data.link);
        setAllFeedback(feedbackResponse.data);
        setFilteredFeedback(feedbackResponse.data); // Initially, show all feedback
      } catch (error) {
        console.error('Error fetching data:', error);
        message.error('Không tải được một số dữ liệu. Vui lòng tải lại trang.');
      } finally {
        setLoading(false);
        // Add this line to scroll to the top after loading
        window.scrollTo(0, 0);
      }
    };

    fetchData();
  }, [id]);

  useEffect(() => {
    if (filterRate === 0) {
      setFilteredFeedback(allFeedback);
    } else {
      setFilteredFeedback(allFeedback.filter(feedback => feedback.rate === filterRate));
    }
  }, [filterRate, allFeedback]);

  const handleFeedbackChange = (e) => {
    setFeedback(e.target.value);
  };

  const handleRatingChange = (value) => {
    setRating(value);
    console.log(rating);
  };

  const submitFeedback = async () => {
    if (rating === 0) {
      message.warning('Vui lòng cung cấp số sao đánh giá.');
      return;
    }

    try {
      const user = localStorage.getItem('userId');
      const newFeedback = {
        fbId: ".",
        description: feedback,
        adId: id,
        userId: user,
        rate: rating
      };
      const response = await retryFetch(() => api.post('Feedback/AddFeedback', newFeedback));
      message.success('Phản hồi đã gửi thành công');
      
      // Update both allFeedback and filteredFeedback
      const updatedFeedback = [response.data, ...allFeedback];
      setAllFeedback(updatedFeedback);
      if (filterRate === 0 || response.data.rate === filterRate) {
        setFilteredFeedback([response.data, ...filteredFeedback]);
      }
      
      setFeedback('');
      setRating(0);
    } catch (error) {
      console.error('Error submitting feedback:', error);
      message.error('Không gửi được phản hồi. Vui lòng thử lại.');
    }
  };

  const retryFetch = async (fetchFunction, retries = 3, delay = 1000) => {
    for (let i = 0; i < retries; i++) {
      try {
        return await fetchFunction();
      } catch (error) {
        if (i === retries - 1) throw error;
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
  };

  const handleFilterChange = (value) => {
    setFilterRate(value);
  };

  return (
    <>
      <HeaderTemplate />
      <div className="ad-detail-container">
        {loading ? (
          <Spin size="large" />
        ) : (
          <>
            <div dangerouslySetInnerHTML={{ __html: adHtml }} />
          </>
        )}
      </div>
      <div className="feedback-section">
        <h2>Đánh giá và Phản hồi</h2>
        <div className="rating-container">
          <span>Đánh giá bài đăng:</span>
          <Rate 
            value={rating} 
            onChange={handleRatingChange}
            className="feedback-rate"
          />
        </div>
        <Input.TextArea
          rows={4}
          value={feedback}
          onChange={handleFeedbackChange}
          placeholder="Chia sẻ ý kiến của bạn về bài đăng này..."
          required
        />
        <Button type="primary" onClick={submitFeedback}>
          Gửi đánh giá
        </Button>
        
        <div className="all-feedback-section">
          <h2>Phản hồi từ cộng đồng</h2>
          <Select
            className="custom-select"
            style={{ width: 180, marginBottom: 16 }}
            placeholder="Filter by rating"
            onChange={handleFilterChange}
            value={filterRate}
          >
            <Option value={0}>All Ratings</Option>
            <Option value={1}><Rate disabled defaultValue={1} count={1} /></Option>
            <Option value={2}><Rate disabled defaultValue={2} count={2} /></Option>
            <Option value={3}><Rate disabled defaultValue={3} count={3} /></Option>
            <Option value={4}><Rate disabled defaultValue={4} count={4} /></Option>
            <Option value={5}><Rate disabled defaultValue={5} count={5} /></Option>
          </Select>
          {filteredFeedback.length > 0 ? (
            filteredFeedback.map((feedback, index) => (
              <div key={feedback.fbId || index} className="feedback-item">
                <Rate disabled value={feedback.rate} />
                <p>{feedback.description}</p>
              </div>
            ))
          ) : (
            <p>Chưa có phản hồi nào. Hãy là người đầu tiên chia sẻ suy nghĩ của bạn!</p>
          )}
        </div>
      </div>
      
      <FooterTemplate />
    </>
  );
}

export default AdvertisementDetail;
