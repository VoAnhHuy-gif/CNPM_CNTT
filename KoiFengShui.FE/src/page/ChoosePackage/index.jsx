import React, { useState, useEffect } from 'react';
import { Form, Input, Button, DatePicker, InputNumber, Select, message, Row, Col, Card } from 'antd';
import { useNavigate } from 'react-router-dom';
import dayjs from 'dayjs';
import api from '../../config/axios';
import Header_page from '../../components/header-page';
import './index.css';
import { useLocation } from 'react-router-dom';

const { Option } = Select;

const formatCurrency = (value) => {
  return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
};

const ChoosePackage = () => {
  const location = useLocation();
  const adData = location.state?.adData || {};
  const [form] = Form.useForm();
  const navigate = useNavigate();
  const [packages, setPackages] = useState([]);
  const [selectedPackage, setSelectedPackage] = useState(null);
  const [invoiceInfo, setInvoiceInfo] = useState({
    adId: adData.adId || '',
    rank:  '',
    startDate:  null,
    expiredDate: null,
    total:  0
  });

  useEffect(() => {
    fetchPackages();
  }, []);

  const fetchPackages = async () => {
    try {
      const response = await api.get('Package/GetAllPackage');
      setPackages(response.data);
    } catch (error) {
      console.error('Lỗi khi tải gói quảng cáo:', error);
      message.error('Không thể tải gói quảng cáo');
    }
  };

  const onFinish = async (values) => {
    let currentAdId = adData.adId;
  
    // if (currentAdId === '.') {
    //   try {
    //     const response = await api.get('Advertisement/GenerateAdId', {
    //       params: { AdId: currentAdId }
    //     });
    //     currentAdId = response.data; // Assuming the API returns the new ID directly
    //   } catch (error) {
    //     console.error('Error generating new AdId:', error);
    //     message.error('Failed to generate new advertisement ID');
    //     return;
    //   }
    // }
  
    const packageInfo = {
      adId: currentAdId,
      rank: values.Rank,
      startDate: values.startDate.format('YYYY-MM-DD'),
      status: 'Pending',
      quantity: values.quantity,
      total: invoiceInfo.total
    };
  
    const updatedAdData = { ...adData, adId: currentAdId };
  
    try {
      const response = await api.post('VNPay/create-payment', {
        amount: invoiceInfo.total,
      });
  
      if (response.data && response.data.paymentUrl) {
        localStorage.setItem('pendingAdPackage', JSON.stringify(packageInfo));
        localStorage.setItem('adData', JSON.stringify(updatedAdData));
        window.location.href = response.data.paymentUrl;
      } else {
        message.error('Không thể tạo URL thanh toán');
      }
    } catch (error) {
      console.error('Lỗi khi tạo thanh toán:', error);
      message.error('Không thể bắt đầu thanh toán');
    }
  };

  const handlePackageChange = (value) => {
    const selected = packages.find(pkg => pkg.rank === value);
    setSelectedPackage(selected);
    if (selected) {
      const quantity = form.getFieldValue('quantity') || 1;
      const total = selected.price * quantity;
      let expiredDate = 'Not set';
      if (invoiceInfo.startDate) {
        const startDate = dayjs(invoiceInfo.startDate, 'DD-MM-YYYY');
        expiredDate = startDate.add(selected.duration * quantity, 'days').format('DD-MM-YYYY');
      }
      setInvoiceInfo(prev => ({
        ...prev,
        rank: selected.rank,
        total,
        expiredDate,
        quantity
      }));
    }
  };

  const handleQuantityChange = (value) => {
    const selected = packages.find(pkg => pkg.rank === form.getFieldValue('Rank'));
    if (selected) {
      const total = selected.price * value;
      let startDate = invoiceInfo.startDate ? dayjs(invoiceInfo.startDate, 'DD-MM-YYYY') : null;
      let expiredDate = 'Not set';
      if (startDate && selected.duration) {
        expiredDate = startDate.add(selected.duration * value, 'days').format('DD-MM-YYYY');
      }
      setInvoiceInfo(prev => ({ 
        ...prev, 
        total, 
        expiredDate,
        quantity: value
      }));
    }
  };

  const handleDateChange = (date) => {
    if (date && selectedPackage) {
      const formattedStartDate = date.format('DD-MM-YYYY');
      const quantity = form.getFieldValue('quantity') || 1;
      const expiredDate = date.add(selectedPackage.duration * quantity, 'days');
      const formattedExpiredDate = expiredDate.format('DD-MM-YYYY');
      setInvoiceInfo(prev => ({
        ...prev,
        startDate: formattedStartDate,
        expiredDate: formattedExpiredDate
      }));
    } else {
      setInvoiceInfo(prev => ({
        ...prev,
        startDate: date ? date.format('DD-MM-YYYY') : null,
        expiredDate: 'Not set'
      }));
    }
  };

  const disabledDate = (current) => {
    // Can't select days before today
    return current && current < dayjs().startOf('day');
  };

  return (
    <> <Header_page />
    <div className="choose-package-container">
     
      <h1>Chọn Gói Quảng Cáo</h1>
      <div className="package-layout">
        <div className="package-info-and-form">
          <div className="package-info">
            <Card title="Thông Tin Gói">
              {selectedPackage ? (
                <>
                  <p><strong>Hạng:</strong> {selectedPackage.rank}</p>
                  <p><strong>Giá:</strong> {formatCurrency(selectedPackage.price)}</p>
                  <p><strong>Mô tả:</strong> {selectedPackage.description}</p>
                  <p><strong>Thời hạn:</strong> {selectedPackage.duration * (form.getFieldValue('quantity')||1)} ngày </p>
                </>
              ) : (
                <p>Chọn một gói để xem chi tiết</p>
              )}
            </Card>
          </div>
          <div className="update-form">
            <Form form={form} onFinish={onFinish} layout="vertical">
              <Form.Item name="Rank" label="Hạng" rules={[{ required: true }]}>
                <Select onChange={handlePackageChange}>
                  {packages.map(pkg => (
                    <Option key={pkg.rank} value={pkg.rank}>{pkg.rank}</Option>
                  ))}
                </Select>
              </Form.Item>
              <Form.Item 
                name="startDate" 
                label="Ngày Bắt Đầu" 
                rules={[
                  { 
                    required: true,
                    message: 'Vui lòng chọn ngày bắt đầu' 
                  },
                  {
                    validator: (_, value) => {
                      if (value && value < dayjs().startOf('day')) {
                        return Promise.reject('Không thể chọn ngày trong quá khứ');
                      }
                      return Promise.resolve();
                    }
                  }
                ]}
              >
                <DatePicker 
                  onChange={(date) => handleDateChange(date)} 
                  format="DD-MM-YYYY"
                  disabledDate={disabledDate}
                />
              </Form.Item>
              <Form.Item name="quantity" label="Số Lượng" rules={[{ required: true }]}>
                <InputNumber min={1} onChange={handleQuantityChange} />
              </Form.Item>
             
              <Form.Item>
                <Button type="primary" htmlType="submit">
                  Thanh Toán
                </Button>
              </Form.Item>
            </Form>
          </div>
        </div>
        <div className="invoice-info">
          <Card title="Hóa Đơn Quảng Cáo">
           
            <p><strong>Hạng:</strong> {invoiceInfo.rank || 'Chưa chọn'}</p>
            <p><strong>Ngày Bắt Đầu:</strong> {invoiceInfo.startDate || 'Chưa đặt'}</p>
            <p><strong>Ngày Hết Hạn:</strong> {invoiceInfo.expiredDate || 'Chưa đặt'}</p>
            <p><strong>Tổng Cộng:</strong> {formatCurrency(invoiceInfo.total)}</p>
          </Card>
        </div>
      </div>
    </div>
    </>
  );
};

export default ChoosePackage;