import React from 'react';
import { Card } from 'antd';
import { useNavigate } from 'react-router-dom';
import './index.css';
import api from "../../config/axios";



const AdvertisementDisplay = ({ advertisements, userElement }) => {
  const navigate = useNavigate();
  const filteredAds = advertisements.filter(ad => ad.elementId === userElement);

  const handleAdClick = (adId) => {
    navigate(`/advertisement-detail/${adId}`);
  };

  return (
    <div className="advertisement-container">
      <h2>Quảng cáo</h2>
      <div className="advertisement-list">
        {filteredAds.map((ad) => (
          <Card 
            key={ad.adId} 
            className="advertisement-card" 
            onClick={() => handleAdClick(ad.adId)}

          >
            <div className="image-container">
              <img src={ad.image} alt={ad.heading} />
              <div className="text-block">
                <h3>{ad.heading}</h3>
              </div>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
};

export default AdvertisementDisplay;