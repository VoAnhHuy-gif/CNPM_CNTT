import { useState, useEffect } from "react"; // Update this line
import "./index.css";
import HeaderTemplate from "../../components/header-page";
import FooterPage from "../../components/footer-page";
import { useLocation } from "react-router-dom";
import { Modal } from "antd";
import AdvertisementDisplay from '../../components/advertisementdisplay';
import api from "../../config/axios";


// ... rest of your imports

function Consulting() {
  const location = useLocation(); // Get location object
  const { koiData, koiQuantity, pondShape, pondDirection, fate, lifePalace } = location.state || {
    koiData: [],
    koiQuantity: [],
    pondShape: [],
    pondDirection: [],
    fate: null,
    lifePalace: null,
  }; // Extract  data
  const [advertisements, setAdvertisements] = useState([]);
  const [userElement, setUserElement] = useState(null);
  const [visible, setVisible] = useState(false); // State for modal visibility
  const [selectedKoi, setSelectedKoi] = useState(null); // State for selected koi
  const [selectedPond, setSelectedPond] = useState(null); // State for selected pond

  const showModal = (koi) => {
    setSelectedKoi(koi); // Set selected koi
    setVisible(true); // Show modal
  };

  const showPondModal = (pond) => {
    setSelectedPond(pond); // Set selected pond
    setVisible(true); // Show modal
  };

  const handleCancel = () => {
    setVisible(false); // Hide modal
  };
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

  const getElementIcon = (element) => {
    switch (element) {
      case "Hỏa":
        return "Hoa";
      case "Thủy":
        return "Thuy";
      case "Mộc":
        return "Moc";
      case "Kim":
        return "kim";
      case "Thổ":
        return "Tho";
      default:
        return "";
    }
  };


  useEffect(() => {
    const fetchData = async () => {
      try {
        const adsResponse = await api.get('Advertisement/GetAllAdvertisement');

        const approvedAds = adsResponse.data.filter((ad) => ad.status === "Approved");
        setAdvertisements(approvedAds);

        // Get user element from the location state
        if (location.state && location.state.fate) {
          console.log(location.state.fate);
          setUserElement(location.state.fate);
          setLifePalace(lifePalaceResponse.data);
        } else {
          console.error("User element not found in location state");
          // Handle the case when user element is not available
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, [location]);
  return (
    <div >
      <header>
        <HeaderTemplate />
      </header>
      <body>
        <div className="consulting-container">
        <div className="consulting-title">
          <h1>Thông tin tư vấn</h1>
        </div>
       
        <div className="Guest-element">
          <h2>Mệnh của bạn là <span style={{color: getElementColor(userElement) }}>{userElement} </span></h2>
          <h2>Cung mệnh của bạn là <span style={{color: "purple"}  }>{lifePalace} </span></h2>
        </div>
        <hr className="consulting-divider" /> {/* Added divider */}

        <div className="Header-fish">
          <h2>Các loại cá phù hợp</h2>
          <div className="koi-cards">

            {koiData.length > 0 ? (
              koiData.map((koi) => (
                // eslint-disable-next-line react/jsx-key
                <div className="koi-card" onClick={() => showModal(koi)}>
                  {" "}
                  <div className="image"> <img src={koi.image} alt={koi.image} /></div>
                  <h3>{koi.koiType}</h3>
                  <div className="element-koi">
                    <h3 style={{ color: getElementColor(koi.element) }}>{koi.element}</h3>
                    <img src={`/Element1/${getElementIcon(koi.element)}.png`} alt={koi.element} />


                  </div>
                </div>
              ))
            ) : (
              <p>No Koi data available</p>
            )}
          </div>

        </div>
        <div className="Header-pond">
          <h2>Đặc điểm hồ phù hợp</h2>

          <div className="pond-shape">
            <h3>
              Hình dạng:{" "}
              {pondShape.map((pond, index) => (
                <span key={pond.shapeId}>
                  {index > 0 && " và "}{" "}
                  {/* Add "và" between elements, except before the first one */}
                  {pond.shapeId}
                </span>
              ))}
            </h3>

            <div className="pond-shape-images">
              {pondShape.map((pond) => (

                <div key={pond.shapeId} className="parallelogram" >
                  <img src={pond.image} alt={pond.shapeId} />


                </div>
              ))}
            </div>
          </div>

          <div className="pond-direction">
            <h3>Hướng:</h3>
            {pondDirection.map((pond) => (
              <div key={pond.directionId} className="direction-info">
                <p>
                  + Gia chủ cung {pond.lifePalaceId} phù hợp với hướng{" "}
                  {Array.isArray(pond.directionId)
                    ? pond.directionId.join(" và ")
                    : pond.directionId}{" "}
                  là hướng tốt{" "}
                  {Array.isArray(pond.eightMansions)
                    ? pond.eightMansions.join(" và ")
                    : pond.eightMansions}{" "}
                  theo Bát Trạch
                </p>
                {pond.pointOfDirection === 1 && (
                  <p>
                    +{" "}
                    {Array.isArray(pond.eightMansions)
                      ? pond.eightMansions[0]
                      : pond.eightMansions}{" "}
                    (hướng Thượng Cát): {pond.description}.
                  </p>
                )}
                {pond.pointOfDirection === 1 &&
                  Array.isArray(pond.eightMansions) &&
                  pond.eightMansions.length > 1 && (
                    <p>
                      + {pond.eightMansions[1]} (hướng Thượng Cát): {pond.description}.
                    </p>
                  )}
              </div>
            ))}
          </div>
        </div>
        </div>
        {userElement && (
          <AdvertisementDisplay advertisements={advertisements} userElement={fate} />
        )}
      </body>

      <footer>
        <FooterPage />
      </footer>


      {/* Modal for displaying koi details */}
      <Modal
        title={selectedKoi ? "" : ""}
        visible={visible}
        onCancel={handleCancel}
        footer={null}
        width={1000}
      >
        {selectedKoi && (

          <div className="modal-content">
            <div className="modal-image">
              <img style={{ width: "100%", height: "auto" }} src={selectedKoi.image} />

            </div>

            <div className="modal-text">
              <h2>{selectedKoi.koiType}</h2>
              <h3>Giới thiệu:</h3>
              <p>{selectedKoi.description}</p>
              <h3>Mệnh cá:</h3>
              <p>{selectedKoi.element}</p>
              <h3>Số lượng :</h3>
              <p>{koiQuantity.description}</p>
            </div>
          </div>
        )}

      </Modal>
      {/* Modal for displaying pond details */}

    </div>
  );
}
export default Consulting;
