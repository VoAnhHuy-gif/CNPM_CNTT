import "./index.css";

import { Button, DatePicker, Form, Radio } from "antd";
import AuthenTemplate from "../../components/authen-templates";
import { useNavigate } from "react-router-dom";
import api from "../../config/axios";
import { toast } from "react-toastify";
import { useState } from "react"; // Import useState
import HeaderTemplate from "../../components/header-page";
import FooterTemplate from "../../components/footer-page";


const Calculation = () => {
  const navigate = useNavigate();
  const [form] = Form.useForm();
  const [koiData, setKoiData] = useState([]);
  const [koiQuantity, setKoiQuantity] = useState([]);
  const [pondShape, setPondShape] = useState([]);
  const [pondDirection, setPondDirection] = useState([]);
  const [fate, setFate] = useState(null);
  const [lifePalace, setLifePalace] = useState(null);
  const [isFateCalculated, setIsFateCalculated] = useState(false);

  const getElementColor = (element) => {
    switch (element) {
      case "Hỏa":
        return "red";
      case "Thủy":
        return "blue";
      case "Mộc":
        return "green";
      case "Kim":
        return "gold";
      case "Thổ":
        return "brown";
      default:
        return "black";
    }
  };
  const handleCalculate = async () => {
    try {
      const values = await form.validateFields();
      
      // Gọi Api để lấy danh sách cá

      const response = await api.get("KoiVariety/GetListKoiByDOBOrderS1", {

        params: { dob: values.YOB.format("YYYY-MM-DD") },
      });
      

      // Gọi Api để lấy số lượng cá phù hợp
      const reponse2 = await api.get("KoiVariety/GetQuantityByDOB", {
        params: { dob: values.YOB.format("YYYY-MM-DD") },
      });
      

      // Gọi Api để lấy hình dạng hồ phù hợp
      const reponse3 = await api.get("Pond/GetGoodShapeByDOB", {
        params: { dob: values.YOB.format("YYYY-MM-DD") },
      });
      

      // Gọi Api để lấy hướng hồ phù hợp
      const reponse4 = await api.get("Pond/GetGoodDirectionByDOB", {
        params: { dob: values.YOB.format("YYYY-MM-DD"), gender: values.Gender },
      });

      const userElement = await api.get("Fate/element", {
        params: { dob: values.YOB.format("YYYY-MM-DD") },
      });
      
      // Navigate to consulting page with all data
      navigate("/consulting", {
        state: {
          koiData: response.data,
          koiQuantity: reponse2.data,
          pondShape: reponse3.data,
          pondDirection: reponse4.data,
          fate: fate,
          lifePalace: lifePalace,
          
        },
      });
    } catch (error) {
      toast.error(error.response?.data || "Vui lòng nhập đầy đủ thông tin !");
    }
  };

  const handleFateCalculation = async () => {
    try {
      const values = await form.validateFields();
      const fateResponse = await api.get("Fate/element", {
        params: { dob: values.YOB.format("YYYY-MM-DD") },
      });
      const lifePalaceResponse = await api.get("Fate/CalculateLife_Palace", {
        params: { YOB: values.YOB.format("YYYY-MM-DD"), gender: values.Gender },
      });
      setFate(fateResponse.data || "Unknown");
      setLifePalace(lifePalaceResponse.data || "Unknown");  
      setIsFateCalculated(true);


    } catch (error) {
      console.error("Error details:", error);
      toast.error(error.response?.data || "Vui lòng nhập đầy đủ thông tin !");
    }
  };

  return (
    <>
    <HeaderTemplate></HeaderTemplate>
    <AuthenTemplate>
      <div className="Header-Title">
        <h1>Tư vấn cá và hồ theo tuổi của bạn</h1>
        <p>
          Hãy để chúng tôi giúp bạn cho loại cá và hỗ trợ theo năm sinh của bạn.
        </p>
      </div>
      <Form
        form={form}
        labelCol={{ span: 24 }}
        name="userForm"
        initialValues={{ remember: true }}
      >
        <Form.Item
          label="Ngày tháng năm sinh"
          name="YOB"
          rules={[{ required: true, message: "Hãy chọn ngày sinh của bạn!" }]}
        >
          <DatePicker format="YYYY-MM-DD" className="datePicker"/>
        </Form.Item>

        <Form.Item
          label="Giới tính"
          name="Gender"
          rules={[{ required: true, message: "Hãy chọn giới tính của bạn!" }]}
        >
          <Radio.Group>
            <Radio value="Male">Nam</Radio>
            <Radio value="Female">Nữ</Radio>
          </Radio.Group>
        </Form.Item>

        <Form.Item>
          <Button className="calculate-button" type="primary" htmlType="button" onClick={handleFateCalculation}>
            Tính mệnh của bạn
          </Button>
        </Form.Item>
      </Form>

      <div className="Guest-fate">
        {fate && <h3 >Mệnh của bạn là: <span style={{color: getElementColor(fate) }}>{fate}</span></h3>}
        {lifePalace && <h3>Cung mệnh của bạn là: <span style={{color: "purple"}}>{lifePalace}</span></h3>}
      </div>

      {isFateCalculated && (
        <Button type="primary" onClick={handleCalculate}>
          Tiếp tục tư vấn 
        </Button>
      )}
    </AuthenTemplate>
    <FooterTemplate/>
    </>
  );
};

export default Calculation;
