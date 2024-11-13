import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer } from "react-toastify";
import { GoogleOAuthProvider } from '@react-oauth/google';

createRoot(document.getElementById("root")).render(
  <>
    <GoogleOAuthProvider clientId="958782319796-ba6d0uqplfepnmsdu1aol963oq6orkok.apps.googleusercontent.com">
      <App />
      <ToastContainer />
    </GoogleOAuthProvider>
  </>
);
