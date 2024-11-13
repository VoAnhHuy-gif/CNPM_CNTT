import React, { useEffect, useState, useRef } from "react";
import { Bar, Pie, Line } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  PointElement,
  LineElement,
} from "chart.js";
import api from "../../../config/axios";
import "./index.css";
import { subDays, format } from "date-fns";

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  ArcElement,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

const AdminDashboard = () => {
  const [data, setData] = useState({
    ads: [],
    revenue: {},
    ageGroups: {},
    fish: [],
    monthlyRevenue: {},
    dailyRevenue: {},
  });
  const chartRefs = useRef([]);
  const currentYear = new Date().getFullYear();
  const fetchData = async (endpoint, setter) => {
    try {
      const response = await api.get(endpoint);
      setter(response.data);
    } catch (error) {
      console.error(`Error fetching ${endpoint} data:`, error);
    }
  };

  useEffect(() => {
    const endpoints = [
      { url: "Advertisement/GetAllAdvertisement", key: "ads" },
      { url: "Dashboard/RevenueByPackage", key: "revenue" },
      { url: "Dashboard/UsersByAgeGroup", key: "ageGroups" },
      { url: "KoiVariety/GetAllKoi", key: "fish" },
    ];

    endpoints.forEach(({ url, key }) =>
      fetchData(url, (newData) => {
        console.log(`Received ${key} data:`, newData);
        setData((prev) => ({ ...prev, [key]: newData }));

        if (key === "ads") {
          const currentDate = new Date();
          const year = currentDate.getFullYear();
          const month = currentDate.getMonth() + 1; // Tháng bắt đầu từ 0
          const day = currentDate.getDate();
          fetchDailyRevenueData(year, month, day);
        }
      })
    );
    fetchMonthlyRevenueData(currentYear);
    console.log("Initial data state:", data);

    return () => chartRefs.current.forEach((chart) => chart?.destroy?.());
  }, []);

  const fetchMonthlyRevenueData = async (year) => {
    try {
      const response = await api.get(
        `/Dashboard/GetTotalRevenueByMonth?year=${year}`
      );
      console.log("Monthly revenue data:", response.data);
      setData((prev) => ({ ...prev, monthlyRevenue: response.data }));
    } catch (error) {
      console.error("Error fetching monthly revenue data:", error);
    }
  };

  const fetchDailyRevenueData = async (year, month, day) => {
    try {
      const response = await api.get(`/Dashboard/GetDailyRevenueToDate?year=${year}&month=${month}&day=${day}`);
      console.log("Daily revenue data:", response.data);
      setData(prev => ({ ...prev, dailyRevenue: response.data }));
    } catch (error) {
      console.error("Error fetching daily revenue data:", error);
    }
  };

  const createDailyRevenueChartData = () => {
    const last7Days = Object.keys(data.dailyRevenue)
      .sort((a, b) => new Date(a) - new Date(b))
      .slice(-7); // Lấy 7 ngày gần nhất

    return {
      labels: last7Days.map(date => format(new Date(date), 'dd/MM')),
      datasets: [{
        label: 'Doanh thu hàng ngày',
        data: last7Days.map(date => data.dailyRevenue[date]),
        fill: false,
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }]
    };
  };

  const countItems = (items, key) => {
    return items.reduce((acc, item) => {
      const value = item[key];
      acc[value] = (acc[value] || 0) + 1;
      return acc;
    }, {});
  };

  const createChartData = (labels, data, label, colors) => ({
    labels,
    datasets: [
      {
        label,
        data,
        backgroundColor: colors.bg,
        borderColor: colors.border,
        borderWidth: 1,
      },
    ],
  });

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: { position: "top" },
      tooltip: {
        callbacks: {
          title: function (tooltipItems) {
            const monthIndex = tooltipItems[0].dataIndex; // Lấy chỉ số tháng
            const date = new Date(currentYear, monthIndex, 1);
            return date.toLocaleString("default", {
              month: "long",
              year: "numeric",
            }); // Trả về tên tháng
          },
        },
      },
    },
  };

  const fishChartData = createChartData(
    Object.keys(countItems(data.fish, "element")),
    Object.values(countItems(data.fish, "element")),
    "Số lượng cá theo mệnh",
    { bg: "rgba(92, 245, 39, 0.8)", border: "rgba(92, 245, 39, 0.8)" }
  );

  const userChartData = createChartData(
    Object.keys(
      countItems(
        data.ads.filter((ad) => ad.status === "Approved"),
        "userId"
      )
    ),
    Object.values(
      countItems(
        data.ads.filter((ad) => ad.status === "Approved"),
        "userId"
      )
    ),
    "Số lượng quảng cáo",
    { bg: "rgba(255, 99, 132, 0.6)", border: "rgba(255, 99, 132, 1)" }
  );

  const revenueChartData = {
    labels: Object.keys(data.revenue),
    datasets: [
      {
        label: "Tỉ lệ doanh thu theo gói",
        data: Object.values(data.revenue),
        backgroundColor: [
          "rgba(75, 192, 192, 0.6)",
          "rgba(255, 99, 132, 0.6)",
          "rgba(54, 162, 235, 0.6)",
          "rgba(255, 206, 86, 0.6)",
          "rgba(153, 102, 255, 0.6)",
        ],
        borderColor: [
          "rgba(75, 192, 192, 1)",
          "rgba(255, 99, 132, 1)",
          "rgba(54, 162, 235, 1)",
          "rgba(255, 206, 86, 1)",
          "rgba(153, 102, 255, 1)",
        ],
        borderWidth: 1,
      },
    ],
  };

  const monthlyRevenueChartData = {
    labels: Object.keys(data.monthlyRevenue || {}).map((month) => {
      const date = new Date(currentYear, month - 1, 1);
      return date.toLocaleString("default", { month: "long", year: "numeric" });
    }),
    datasets: [
      {
        label: "Tổng doanh thu theo tháng",
        data: Object.values(data.monthlyRevenue || {}),
        fill: true,
        backgroundColor: "rgba(75, 192, 192, 0.2)",
        borderColor: "rgb(75, 192, 192)",
        borderWidth: 3,
        tension: 0.1,
        pointRadius: 5,
        pointHoverRadius: 7,
      },
    ],
  };
  console.log("Monthly revenue chart data:", monthlyRevenueChartData);

  const renderChart = (
    condition,
    ChartComponent,
    chartData,
    options,
    index
  ) => {
    console.log(`Rendering chart ${index}:`, { condition, chartData });
    if (!condition) {
      console.log(`Chart ${index} not rendered due to condition:`, condition);
      return <p>Loading data...</p>;
    }
    return (
      <ChartComponent
        data={chartData}
        options={options}
        ref={(el) => (chartRefs.current[index] = el)}
      />
    );
  };

  const formatCurrency = (amount) => {
    return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " VNĐ";
  };

  const totalRevenueForYear = Object.values(data.monthlyRevenue).reduce(
    (sum, value) => sum + value,
    0
  );

  return (
    <div className="dashboard-container">
      <h2>Dashboard</h2>
      <div className="dashboard-content">
        <div className="overview-cards">
          <div className="overview-card">
            <h3>Số lượng quảng cáo</h3>
            <p>{data.ads.filter((ad) => ad.status === "Approved").length}</p>
          </div>
          <div className="overview-card" style={{ backgroundColor: "#ff9800" }}>
            <h3>Tổng doanh thu</h3>
            <p>{formatCurrency(totalRevenueForYear || 0)}</p>
          </div>
        </div>
        <div className="chart-container">
          {renderChart(
            Object.keys(data.revenue).length > 0,
            Pie,
            revenueChartData,
            chartOptions,
            0
          )}
        </div>
        <div className="chart-container">
          {renderChart(
            Object.keys(data.ageGroups).length > 0,
            Bar,
            createChartData(
              Object.keys(data.ageGroups),
              Object.values(data.ageGroups),
              "Số lượng người dùng theo nhóm tuổi",
              {
                bg: "rgba(153, 102, 255, 0.6)",
                border: "rgba(153, 102, 255, 1)",
              }
            ),
            {
              ...chartOptions,
              plugins: {
                ...chartOptions.plugins,
                title: {
                  display: true,
                  text: "Số lượng người dùng theo nhóm tuổi",
                },
              },
            },
            1
          )}
        </div>
        <div className="chart-container">
          {renderChart(
            data.ads.length > 0,
            Bar,
            userChartData,
            {
              ...chartOptions,
              plugins: {
                ...chartOptions.plugins,
                title: {
                  display: true,
                  text: "Số lượng quảng cáo theo người dùng",
                },
              },
            },
            2
          )}
        </div>
        <div className="chart-container">
          {renderChart(
            data.fish.length > 0,
            Bar,
            fishChartData,
            {
              ...chartOptions,
              plugins: {
                ...chartOptions.plugins,
                title: { display: true, text: "Số lượng cá theo mệnh" },
              },
            },
            3
          )}
        </div>
        <div className="chart-container" style={{ height: "400px" }}>
          {data.monthlyRevenue &&
          Object.keys(data.monthlyRevenue).length > 0 ? (
            renderChart(
              true,
              Line,
              monthlyRevenueChartData,
              {
                ...chartOptions,
                maintainAspectRatio: false,
                plugins: {
                  ...chartOptions.plugins,
                  title: {
                    display: true,
                    text: `Tổng doanh thu theo tháng năm ${currentYear}`,
                  },
                },
                scales: {
                  y: {
                    beginAtZero: true,
                    title: { display: true, text: "Tổng doanh thu (VNĐ)" },
                  },
                  x: {
                    title: { display: true, text: `Năm ${currentYear}` },
                    ticks: {
                      callback: function (value, index, values) {
                        const date = new Date(currentYear, index, 1);
                        return date.toLocaleString("default", {
                          month: "short",
                        });
                      },
                    },
                  },
                },
                elements: {
                  line: {
                    borderWidth: 3,
                  },
                  point: {
                    radius: 5,
                    hoverRadius: 7,
                    backgroundColor: "rgb(75, 192, 192)",
                    borderColor: "rgb(75, 192, 192)",
                  },
                },
              },
              4
            )
          ) : (
            <p>No monthly revenue data available</p>
          )}
        </div>
        <div className="chart-container" style={{ height: '400px' }}>
          {data.dailyRevenue && Object.keys(data.dailyRevenue).length > 0 ? (
            <Line
              data={createDailyRevenueChartData()}
              options={{
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                  title: {
                    display: true,
                    text: 'Doanh thu 7 ngày gần nhất'
                  }
                },
                scales: {
                  y: {
                    beginAtZero: true,
                    title: { display: true, text: 'Doanh thu (VNĐ)' }
                  },
                  x: {
                    title: { display: true, text: 'Ngày' }
                  }
                }
              }}
            />
          ) : (
            <p>Đang tải dữ liệu doanh thu 7 ngày gần nhất...</p>
          )}
        </div>
      </div>
    </div>
  );
};

export default AdminDashboard;
