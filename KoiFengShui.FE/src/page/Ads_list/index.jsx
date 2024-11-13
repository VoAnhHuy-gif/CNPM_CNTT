import React, { useEffect, useState } from 'react'; // Thêm useEffect và useState
import { Link } from 'react-router-dom';
import './index.css';
import api from "../../config/axios";
import HeaderTemplate from '../../components/header-page';


import { useNavigate } from 'react-router-dom';


const Ads_list = () => {
  const [ads, setAds] = useState([]);
  const [featuredAd, setFeaturedAd] = useState(null);


  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const response = await api.get('Advertisement/GetAllAdvertisemenWithPackageSortted');
      if (response.data.length > 0) {
        setFeaturedAd(response.data[0]);
        setAds(response.data.slice(1));
      }
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  const formatTimeAgo = (dateString) => {
    const now = new Date();
    const past = new Date(dateString);
    const diffInSeconds = Math.floor((now - past) / 1000);

    if (diffInSeconds < 60) {
      return 'vừa xong';
    } else if (diffInSeconds < 3600) {
      const minutes = Math.floor(diffInSeconds / 60);
      return `${minutes} phút trước`;
    } else if (diffInSeconds < 86400) {
      const hours = Math.floor(diffInSeconds / 3600);
      return `${hours} giờ trước`;
    } else if (diffInSeconds < 2592000) {
      const days = Math.floor(diffInSeconds / 86400);
      return `${days} ngày trước`;
    } else {
      const options = { 
        year: 'numeric', 
        month: '2-digit', 
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false,
        timeZone: 'Asia/Ho_Chi_Minh'
      };
      return past.toLocaleString('vi-VN', options);
    }
  };




  return (

    <>
      <HeaderTemplate />
      <div className="advertisements-container">
        <h1 className="ads-title"> Quảng cáo</h1>
        
        {featuredAd && (
          <div className="featured-ad">
            <img src={featuredAd.image} alt={featuredAd.heading} className="featured-ad-image" />
            <div className="featured-ad-content">
              <h2 className="featured-ad-title">{featuredAd.heading}</h2>
              <p className="featured-ad-description">{featuredAd.description}</p>
              <Link to={`/advertisement-detail/${featuredAd.adId}`} className="view-details-btn">Xem chi tiết</Link>

              <p className="ad-item-date">
                  {formatTimeAgo(featuredAd.createAt)}
                </p>

            </div>
          </div>
        )}

        <div className="ads-grid">
          {ads.map((ad) => (
            <article key={ad.adId} className="ad-item">
              <img src={ad.image} alt={ad.heading} className="ad-item-image" />
              <div className="ad-item-content">
                <h3 className="ad-item-title">{ad.heading}</h3>
                <Link to={`/advertisement-detail/${ad.adId}`} className="view-details-link">Xem chi tiết</Link>
                <p className="ad-item-date">
                  {formatTimeAgo(ad.createAt)}
                </p>
              </div>
            </article>
          ))}
        </div>
      </div>
    </>
  );
};

export default Ads_list;
