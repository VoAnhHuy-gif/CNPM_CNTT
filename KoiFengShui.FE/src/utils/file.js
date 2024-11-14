import { getDownloadURL, ref, uploadBytes } from "firebase/storage";
import { storage } from "../config/firebase";

const uploadFile = async (file) =>{
    //lưu cái file này lên firebase

    //=> lấy cái đường dẫn đến file vừa tạo
    const storageRef = ref(storage, file.name);
    const response = await uploadBytes(storageRef, file); //upload lên firebase
    const downloadURL = await getDownloadURL(response.ref); //lấy cái đường dẫn từ cái firebase
    return downloadURL;

}

export default uploadFile; // mún các trang khác xài thì export ra