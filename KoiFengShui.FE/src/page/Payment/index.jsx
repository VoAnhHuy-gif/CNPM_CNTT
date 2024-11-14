import React, { useState } from 'react';
import { Form, Input, Button } from 'antd';
import api from '../../config/axios';
import HeaderTemplate from '../../components/header-page';
import './index.css';

function VNPayPayment() {
  const [loading, setLoading] = useState(false);

  const onFinish = async (values) => {
    setLoading(true);
    try {
      const response = await api.post('VNPay/create-payment', {
        amount: values.amount,
      });
      
      // Redirect to VNPay payment URL
      window.location.href = response.data.paymentUrl;
      vnp_ReturnUrl = "http://localhost:3000/payment";
    } catch (error) {
      console.error('Error creating payment:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      <HeaderTemplate />
      <div className="vnpay-payment-container">
        <h1>VNPay Payment</h1>
        <Form onFinish={onFinish} layout="vertical">
          <Form.Item
            name="amount"
            label="Amount"
            rules={[{ required: true, message: 'Please enter the amount' }]}
          >
            <Input type="number" />
          </Form.Item>
          <Form.Item
            name="description"
            label="Description"
            rules={[{ required: true, message: 'Please enter a description' }]}
          >
            <Input />
          </Form.Item>
          <Form.Item>
            <Button type="primary" htmlType="submit" loading={loading}>
              Pay with VNPay
            </Button>
          </Form.Item>
        </Form>
      </div>
    </>
  );
}

export default VNPayPayment;