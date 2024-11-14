import axios from "axios";

// Set config defaults when creating the instance
const api = axios.create({
    baseURL: 'https://localhost:7247/api/'
  });

  //làm 1 hành động lấy cái token từ phía localStorage và đẩy theo config axios trc khi call API 
  const handleBefore = (config) => {
    //handle hành động trước khi call API
  
    //lấy cái token ra và đính kèm theo request
    const token = localStorage.getItem("token")?.replaceAll('"', "");
    config.headers["Authorization"] = `Bearer ${token}`;
    return config;
  };

  const handleError = (error) => {
    console.log(error)
  }
  
  api.interceptors.request.use(handleBefore, handleError);  
  export default api; // để có thể sử dụng api tất cả mọi nơi mình muốn

  //http://14.225.220.131:8080/api/