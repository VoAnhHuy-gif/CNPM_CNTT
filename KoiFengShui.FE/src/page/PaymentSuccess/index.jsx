import React, { useState, useEffect, useRef } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { message, Card, Row, Col } from 'antd';
import api from '../../config/axios';
import { Button, notification } from 'antd';
import { HomeOutlined } from '@ant-design/icons';
import './index.css';
import HeaderTemplate from '../../components/header-page';
import FooterTemplate from '../../components/footer-page';

const PaymentSuccess = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [paymentInfo, setPaymentInfo] = useState(null);
  const [isProcessing, setIsProcessing] = useState(false);
  const processedRef = useRef(false);
  const [isPaymentProcessed, setIsPaymentProcessed] = useState(false);

  const processPayment = async () => {
    // Nếu đang xử lý, không thực hiện thêm hành động nào
    if (isProcessing) return;
    setIsProcessing(true);

    const queryParams = new URLSearchParams(location.search);
    const vnp_ResponseCode = queryParams.get('vnp_ResponseCode');
    

    const packageInfo = JSON.parse(localStorage.getItem('pendingAdPackage') || '{}');
    const adData = JSON.parse(localStorage.getItem('adData') || '{}');

    if (vnp_ResponseCode === '00') {
      try {
        const formatDate = (dateString) => {
          // Format: "20241001000000"
          const [year, month, day, hour, minute, second] = dateString.match(/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/).slice(1);
          const date = new Date(+year, +month - 1, +day, +hour, +minute, +second);
          
          // Format the date to YYYY-MM-DD HH:mm:ss
          const pad = (num) => num.toString().padStart(2, '0');
          return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
        };
        
        const paymentInfoData = {
          amount: queryParams.get('vnp_Amount'),
          orderInfo: queryParams.get('vnp_OrderInfo'),
          transactionNo: queryParams.get('vnp_TransactionNo'),
          bankCode: queryParams.get('vnp_BankCode'),
          payDate: queryParams.get('vnp_PayDate')
        };

        console.log(paymentInfoData);
        setPaymentInfo(paymentInfoData);

        const adQueryParams = new URLSearchParams({
          Rank: packageInfo.rank,
          startDate: packageInfo.startDate,
          quantity: packageInfo.quantity,
          total: packageInfo.total,
          CreateAt: formatDate(queryParams.get('vnp_PayDate')),
          TransactionCode: paymentInfoData.transactionNo,
          BankCode: paymentInfoData.bankCode
        }).toString();
      
        const response = await api.post(`Advertisement/CreateAdvertisement?${adQueryParams}`, {
          adId: adData.adId,
          heading: adData.heading,
          image: adData.image,
          link: adData.link,
          userId: adData.userId,
          elementId: adData.elementId
        });
        

        notification.success({
          message: 'Thanh toán thành công',
          description: 'Quảng cáo của bạn đã được tạo.'
          
        });

        localStorage.setItem('paymentProcessed', 'true');
        setIsPaymentProcessed(true);
        return;
      } catch (error) {
        console.error('Error creating advertisement:', error);
        message.error('Vui lòng tạo lại quảng cáo mới');
        navigate('/user-ads');
      }
    } else {
      notification.error({
        message: 'Thanh toán thất bại',
        description: 'Quảng cáo không được tạo.',
        duration: 2,
      });
      navigate('/user-ads');
    }

    localStorage.removeItem('pendingAdPackage');
    localStorage.removeItem('adData');
    setIsProcessing(false);  // Reset trạng thái sau khi xử lý xong
  };

  useEffect(() => {
    if (!processedRef.current) {
      processPayment();
      processedRef.current = true;
    }
  }, []);

  useEffect(() => {
    if (paymentInfo) {
      console.log(paymentInfo);
    }
  }, [paymentInfo]);
  useEffect(() => {
    const processed = localStorage.getItem('paymentProcessed') === 'true';
    setIsPaymentProcessed(processed);

    if (processed) {
      const handleBeforeUnload = () => {
        localStorage.removeItem('paymentProcessed');
      };

      window.addEventListener('beforeunload', handleBeforeUnload);

      return () => {
        window.removeEventListener('beforeunload', handleBeforeUnload);
      };
    }
  }, []);

  useEffect(() => {
    const handlePageHide = () => {
      if (isPaymentProcessed) {
        localStorage.setItem('redirectToHome', 'true');
      }
    };

    window.addEventListener('pagehide', handlePageHide);

    return () => {
      window.removeEventListener('pagehide', handlePageHide);
    };
  }, [isPaymentProcessed]);

  useEffect(() => {
    const shouldRedirect = localStorage.getItem('redirectToHome') === 'true';
    if (shouldRedirect) {
      localStorage.removeItem('redirectToHome');
      navigate('/');
    }
  }, [navigate]);
  const handleNavigateUserAds = () => {
    localStorage.removeItem('paymentProcessed');
    localStorage.removeItem('redirectToHome');
    navigate('/user-ads');
  };

  if (!paymentInfo) {
    return <div>Đang xử lý thanh toán...</div>;
  }

  return (
    <>
    <HeaderTemplate/>
    <div className="payment-result-container">
      <Card title="Thông tin thanh toán" className="payment-result-info">
        <div className="payment-details">
          <div className="payment-item">
            <span className="label">Số tiền:    </span>
            <span className="value">{new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(paymentInfo.amount / 100)}</span>
          </div>
          <div className="payment-item">
            <span className="label">Thông tin đơn hàng:</span>
            <span className="value">{(paymentInfo.orderInfo.split(': ')[1] || paymentInfo.orderInfo)}</span>
          </div>
          <div className="payment-item">
            <span className="label">Mã giao dịch:    </span>
            <span className="value">{paymentInfo.transactionNo}</span>
          </div>
          <div className="payment-item">
            <span className="label">Mã ngân hàng:     </span>
            <span className="value">{paymentInfo.bankCode}</span>
          </div>
          <div className="payment-item">
            <span className="label">Ngày thanh toán:   </span>
            <span className="value">
              {paymentInfo.payDate 
                ? new Date(paymentInfo.payDate.replace(/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/, '$1-$2-$3T$4:$5:$6')).toLocaleString('vi-VN', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                  })
                : 'Không có thông tin'}
            </span>
          </div>
        </div>
        <Button 
          type="primary" 
          icon={<HomeOutlined />} 
          onClick={handleNavigateUserAds}
          className="home-button"
        >
          Về trang quảng cáo
        </Button>
      </Card>
    </div>
    <FooterTemplate/>
    </>
  );
};

export default PaymentSuccess;
