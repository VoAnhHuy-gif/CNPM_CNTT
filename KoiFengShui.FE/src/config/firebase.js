// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getStorage } from "firebase/storage";
import { getAuth, GoogleAuthProvider } from "firebase/auth";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDNSlM4vPEgKL4qSOsa3KR-TK8HZFYwW4E",
  authDomain: "swp391-koifengshuiconsult.firebaseapp.com",
  projectId: "swp391-koifengshuiconsult",
  storageBucket: "swp391-koifengshuiconsult.appspot.com",
  messagingSenderId: "8829239133",
  appId: "1:8829239133:web:4aec465da29a3de64372b4",
  measurementId: "G-VRRNRCXJ25"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const storage = getStorage(app);
const auth = getAuth(app);
const provider = new GoogleAuthProvider();
export{auth, provider, storage};