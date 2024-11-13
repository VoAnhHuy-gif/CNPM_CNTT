import {
  RouterProvider,
  createBrowserRouter,
  Navigate,
  useLocation,
} from "react-router-dom";
import { toast } from "react-toastify";
import Home from "./page/home";
import Login from "./page/login";
import Register from "./page/register";
import Calculation from "./page/calculation";
import Consulting from "./page/consulting";
import CalculateCompability from "./page/calculate-compability";
import User from "./page/Admin-page/User";
import ADS from "./page/Admin-page/Ads";
import Blog from "./page/Admin-page/blog";
import Koi from "./page/Admin-page/koi";
import Pond from "./page/Admin-page/pond";
import Ads_list from "./page/Ads_list";
import CreateAds from "./page/CreateAds";
import User_Ads from "./page/User_Ads";
import Dashboard from "./components/dashboard";
import AdvertisementDetail from "./page/AdvertismentDetail";
import PaymentSuccess from "./page/PaymentSuccess";
import VNPayPayment from "./page/Payment";
import ChoosePackage from "./page/ChoosePackage";
import CreateBlog from "./page/Admin-page/CreateBlog";
import BlogDetail from "./page/Admin-page/BlogDetail";
import BlogList from "./page/Blogs-list";
import AdminDashboard from "./page/Admin-page/dashboard";
import UserProfile from "./page/User-Profile";
import ForgotPassword from "./page/Forgot-Password";
import ResetPassword from "./page/Reset-Password";
import PackageManagement from "./page/Admin-page/package";
import Policies from "./page/Policies";
function App() {
  const ProtectedRoute = ({ children, allowAdmin = false }) => {
    const location = useLocation();
    const userId = localStorage.getItem("userId");
    const userRole = localStorage.getItem("role");

    if (!userId) {
      toast.error("Vui lòng đăng nhập để truy cập trang này.");
      localStorage.removeItem("userId");
      localStorage.removeItem("token");
      localStorage.removeItem("name");
      localStorage.removeItem("role");
      return <Navigate to="/login" state={{ from: location }} replace />;
    }
    if (userRole === "Admin" && !allowAdmin) {
      toast.error("Admin không được phép đăng quảng cáo.");
      localStorage.removeItem("userId");
      localStorage.removeItem("token");
      localStorage.removeItem("name");
      localStorage.removeItem("role");
      return <Navigate to="/login" state={{ from: location }} replace />;
    }

    return children;
  };

  const ProtectedRouteAdmin = ({ children }) => {
    const userId = localStorage.getItem("userId");
    const userRole = localStorage.getItem("role");
    if (userId && userRole === "Admin") {
      return children;
    }
    toast.error("Vui lòng đăng nhập để truy cập trang này.");
    localStorage.removeItem("userId");
    localStorage.removeItem("token");
    localStorage.removeItem("name");
    localStorage.removeItem("role");
    return <Navigate to="/login" replace />;
  };
  const router = createBrowserRouter([
    {
      path: "/",
      element: <Home />,
    },
    {
      path: "login",
      element: <Login />,
    },
    {
      path: "register",
      element: <Register />,
    },
    {
      path: "forgot-password",
      element: <ForgotPassword />,
    },
    {
      path: "reset-password/:email",
      element: <ResetPassword />,
    },
    {
      path: "dashboard",
      element: (
        <ProtectedRouteAdmin>
          <Dashboard />
        </ProtectedRouteAdmin>
      ),
      children: [
        {
          path: "AdminDashboard",
          element: <AdminDashboard />,
        },
        {
          path: "user",
          element: <User />,
        },

        {
          path: "ads",
          element: <ADS />,
        },
        {
          path: "blog",
          element: <Blog />,
        },
        {
          path: "create-blog",
          element: <CreateBlog />,
        },
        {
          path: "koi",
          element: <Koi />,
        },
        {
          path: "pond",
          element: <Pond />,
        },
        {
          path: "packageManagement",
          element: <PackageManagement />,
        },
      ],
    },

    {
      path: "calculation",
      element: <Calculation />,
    },
    {
      path: "consulting",
      element: <Consulting />,
    },
    {
      path: "calculate-compability",
      element: <CalculateCompability />,
    },

    {
      path: "blogs-list",
      element: <BlogList />,
    },
    {
      path: "ads-list",
      element: <Ads_list />,
    },
    {
      path: "user-profile",
      element: (
        <ProtectedRoute allowAdmin={true}>
          <UserProfile />
        </ProtectedRoute>
      ),
    },
    {
      path: "create-ads",
      element: (
        <ProtectedRoute allowAdmin={false}>
          <CreateAds />
        </ProtectedRoute>
      ),
    },
    {
      path: "user-ads",
      element: (
        <ProtectedRoute allowAdmin={false}>
          <User_Ads />
        </ProtectedRoute>
      ),
    },

    {
      path: "advertisement-detail/:id",
      element: <AdvertisementDetail />,
    },
    {
      path: "payment",
      element: <VNPayPayment />,
    },
    {
      path: "payment-success",
      element: <PaymentSuccess />,
    },
    {
      path: "blog-detail/:id",
      element: <BlogDetail />,
    },
    {
      path: "/choose-package",
      element: <ChoosePackage />,
    },
    {
      path: "/policies",
      element: <Policies />,
    },
  ]);

  return <RouterProvider router={router} />;
}
export default App;
