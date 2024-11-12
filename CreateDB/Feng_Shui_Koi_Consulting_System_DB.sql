USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'CN2301C_FengShuiKoiConsulting_DB')
BEGIN
    ALTER DATABASE [CN2301C_FengShuiKoiConsulting_DB] SET OFFLINE WITH ROLLBACK IMMEDIATE;
    ALTER DATABASE [CN2301C_FengShuiKoiConsulting_DB] SET ONLINE;
    DROP DATABASE [CN2301C_FengShuiKoiConsulting_DB]
END

GO

CREATE DATABASE CN2301C_FengShuiKoiConsulting_DB;
GO

USE CN2301C_FengShuiKoiConsulting_DB
GO

/*******************************************************************************
    Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' 
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 
GO

DECLARE @sql2 NVARCHAR(max)=''
SELECT @sql2 += ' DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + '; '
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
EXEC Sp_executesql @sql2 
GO
CREATE TABLE [dbo].[Account](
	[UserID] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[Role] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ads_Package]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ads_Package](
	[AdID] [nvarchar](50) NOT NULL,
	[Rank] [nvarchar](50) NOT NULL,
	[StartDate] [date] NOT NULL,
	[ExpiredDate] [date] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Total] [float] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AdID] ASC,
	[Rank] ASC,
	[CreateAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Advertisement]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisement](
	[AdID] [nvarchar](50) NOT NULL,
	[Heading] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Link] [nvarchar](max) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ElementID] [nvarchar](50) NULL,
	[status] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogID] [nvarchar](50) NOT NULL,
	[Heading] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Link] [nvarchar](max) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Color]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Color](
	[ColorID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direction]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direction](
	[DirectionID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DirectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Element]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Element](
	[ElementID] [nvarchar](50) NOT NULL,
	[Mutualism] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ElementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Element_Color]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Element_Color](
	[ElementID] [nvarchar](50) NOT NULL,
	[ColorID] [nvarchar](50) NOT NULL,
	[ColorPoint] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ElementID] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FbID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[AdID] [nvarchar](50) NOT NULL,
	[Rate] [tinyint] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FbID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Koi_Variety]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Koi_Variety](
	[KoiType] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Element] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KoiType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LifePalace]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LifePalace](
	[LifePalaceID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LifePalaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LifePalace_Direction]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LifePalace_Direction](
	[LifePalaceID] [nvarchar](50) NOT NULL,
	[DirectionID] [nvarchar](50) NOT NULL,
	[EightMansions] [nvarchar](50) NOT NULL,
	[PointOfDirection] [float] NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LifePalaceID] ASC,
	[DirectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[Name] [nvarchar](50) NOT NULL,
	[Birthday] [date] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[Rank] [nvarchar](50) NOT NULL,
	[Duration] [int] NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PointOfShape]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PointOfShape](
	[Point] [float] NOT NULL,
	[ElementID] [nvarchar](50) NOT NULL,
	[ShapeID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ElementID] ASC,
	[ShapeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuantityOfFish]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuantityOfFish](
	[ElementID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ElementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shape]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shape](
	[ShapeID] [nvarchar](50) NOT NULL,
	[image] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ShapeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type_Color]    Script Date: 31/10/2024 10:29:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type_Color](
	[KoiType] [nvarchar](50) NOT NULL,
	[ColorID] [nvarchar](50) NOT NULL,
	[Percentage] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KoiType] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserID], [Password], [Role], [Email], [Status]) VALUES (N'after', N'123', N'Member', N'ngochau1310@gmail.com', N'Active')
INSERT [dbo].[Account] ([UserID], [Password], [Role], [Email], [Status]) VALUES (N'tai', N'123', N'Admin', N'nguyentai2292005@gmail.com', N'Active')
GO
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD004', N'Silver', CAST(N'2024-09-11' AS Date), CAST(N'2024-12-10' AS Date), 2, 4000000, CAST(N'2024-11-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD065', N'Silver', CAST(N'2024-10-30' AS Date), CAST(N'2024-11-29' AS Date), 3, 6000000, CAST(N'2024-11-10T17:43:02.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD081', N'Diamond', CAST(N'2024-10-30' AS Date), CAST(N'2025-03-29' AS Date), 5, 30000000, CAST(N'2024-11-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD083', N'Silver', CAST(N'2024-09-30' AS Date), CAST(N'2024-12-29' AS Date), 3, 6000000, CAST(N'2024-11-08T17:50:32.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD126', N'Gold', CAST(N'2024-10-11' AS Date), CAST(N'2024-12-10' AS Date), 2, 8000000, CAST(N'2024-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD189', N'Diamond', CAST(N'2024-10-15' AS Date), CAST(N'2024-12-14' AS Date), 2, 12000000, CAST(N'2024-11-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD363', N'Diamond', CAST(N'2024-10-09' AS Date), CAST(N'2024-12-08' AS Date), 2, 12000000, CAST(N'2024-10-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD419', N'Gold', CAST(N'2024-08-01' AS Date), CAST(N'2024-11-30' AS Date), 2, 8000000, CAST(N'2024-11-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD483', N'Gold', CAST(N'2024-08-30' AS Date), CAST(N'2024-12-10' AS Date), 4, 16000000, CAST(N'2024-08-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD551', N'Silver', CAST(N'2024-08-11' AS Date), CAST(N'2024-12-10' AS Date), 2, 4000000, CAST(N'2024-08-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD723', N'Diamond', CAST(N'2024-10-20' AS Date), CAST(N'2025-03-19' AS Date), 5, 30000000, CAST(N'2024-10-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD759', N'Gold', CAST(N'2024-09-20' AS Date), CAST(N'2024-12-10' AS Date), 3, 12000000, CAST(N'2024-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD762', N'Silver', CAST(N'2024-10-11' AS Date), CAST(N'2024-12-10' AS Date), 2, 4000000, CAST(N'2024-10-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD793', N'Diamond', CAST(N'2024-09-11' AS Date), CAST(N'2024-12-10' AS Date), 1, 6000000, CAST(N'2024-09-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD820', N'Diamond', CAST(N'2024-08-13' AS Date), CAST(N'2024-12-12' AS Date), 1, 6000000, CAST(N'2024-08-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD878', N'Silver', CAST(N'2024-08-30' AS Date), CAST(N'2024-12-29' AS Date), 3, 6000000, CAST(N'2024-10-30T17:35:27.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD885', N'Gold', CAST(N'2024-09-14' AS Date), CAST(N'2024-12-13' AS Date), 2, 8000000, CAST(N'2024-09-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Ads_Package] ([AdID], [Rank], [StartDate], [ExpiredDate], [Quantity], [Total], [CreateAt]) VALUES (N'AD997', N'Gold', CAST(N'2024-10-01' AS Date), CAST(N'2024-11-30' AS Date), 2, 8000000, CAST(N'2024-10-30T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD004', N'Cà phê Koi – Không gian thư giãn tuyệt vời', N'https://sgl.com.vn/wp-content/uploads/2021/10/quin-koi-coffee-garden.jpeg', N'<p>- Cà phê hương vị đậm đà, được tuyển chọn từ những hạt cà phê nguyên chất.<br>- Không gian Koi độc đáo với hồ cá đẹp mắt, tạo cảm giác thư giãn tuyệt đối.<br>- Dịch vụ phục vụ tận tình và chuyên nghiệp, luôn sẵn sàng đáp ứng nhu cầu của khách hàng.<br>- Thưởng thức nhiều loại thức uống phong phú, từ cà phê đến trà và các món tráng miệng hấp dẫn.<br>- Tổ chức các sự kiện, gặp gỡ bạn bè, hoặc đơn giản chỉ là thư giãn sau một ngày dài.<br>- Địa chỉ: 149/11 Tân Thới Nhất 17, P. Tân Thới Nhất, Q.12, TP.HCM.<br>- Điện thoại: 0972181028&nbsp;<br>- Website: theuvietemb.vn</p>', N'nhan', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD065', N'ISHI KOI - TRANG TRẠI KOI HÀNG ĐẦU', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/hinh-nen-ca-koi-2k_090134777.jpg?alt=media&token=e27ab771-503b-4e54-92e8-73f751f51cdb', N'<section class="secDirection secIntroDerection">
<div class="container">
<div class="row row-fix">
<div class="wrapper-partner">
<div class="head-title">
<h1 id="introduceIshikoifarm-secIntroDerection-text" class="text1 fs18 fw-500 wk-editable-text" style="text-align: center;"><strong>V&igrave; sao chọn ISHIKOI&nbsp;<br></strong></h1>
<div class="head-title">
<h2 id="introduceIshikoifarm-secIntro1-text" class="tittle-1 fw-700 fs28 wk-editable-text">GIỚI THIỆU</h2>
</div>
<p id="introduceIshikoifarm-secIntro1-text1" class="text1 wk-editable-text">Với niềm đam m&ecirc; với c&aacute; Koi ch&uacute;ng t&ocirc;i th&agrave;nh lập ISHI Koi Farm nhằm phục vụ nhu cầu chơi c&aacute; tr&ecirc;n to&agrave;n đất nước Việt Nam . Ch&uacute;ng t&ocirc;i tự h&agrave;o l&agrave; đối t&aacute;c của rất nhiều trại c&aacute; b&ecirc;n Nhật Bản &hellip;. Ch&uacute;ng t&ocirc;i h&acirc;n hạnh được mang đến cho c&aacute;c bạn c&aacute;c sản phẩm tốt nhất với gi&aacute; cả cạnh tranh nhất đ&uacute;ng như &yacute; nghĩa của ISHI trong tiếng Nhật . Ngo&agrave;i ra ISHI KOI FARM c&ograve;n nhận thiết kế thi c&ocirc;ng hồ c&aacute; Koi , cảnh quan s&acirc;n vườn . Ch&uacute;ng t&ocirc;i lu&ocirc;n cố gắng hết m&igrave;nh tạo ra những sản phẩm chất lượng nhất giữ vững uy t&iacute;n</p>
</div>
<h2 id="introduceIshikoifarm-secIntroDerection-text1" class="tittle-1 wk-editable-text">Lai tạo c&aacute; Koi Nhật tại Việt Nam</h2>
<ul class="menu-list">
<li id="introduceIshikoifarm-secIntroDerection-text2" class="list-item wk-editable-text">Hiện tại ISHI KOI FARM đang thử nghiệm lai tạo c&aacute; Koi Nhật tại Việt Nam</li>
<li id="introduceIshikoifarm-secIntroDerection-text3" class="list-item wk-editable-text">Đầu tư con giống với chất lượng cao , kết hợp với c&aacute;c nh&agrave; lai tạo người Nhật Bản l&agrave;m việc tại Việt Nam</li>
<li id="introduceIshikoifarm-secIntroDerection-text4" class="list-item wk-editable-text">C&aacute; sống khỏe v&agrave; sinh trưởng mạnh v&igrave; đ&atilde; được nu&ocirc;i tại việt nam từ nhỏ đ&atilde; quen với kh&iacute; hậu v&agrave; nguồn nước tại nước ta</li>
<li id="introduceIshikoifarm-secIntroDerection-text5" class="list-item wk-editable-text">Tự h&agrave;o l&agrave; đơn vị ti&ecirc;n phong kết hợp với Nhật Bản lai tạo c&aacute; Koi tại Việt Nam</li>
<li id="introduceIshikoifarm-secIntroDerection-text6" class="list-item wk-editable-text">C&aacute; c&oacute; gi&aacute; th&agrave;nh rẻ v&igrave; được nu&ocirc;i tại việt nam ( nh&acirc;n c&ocirc;ng v&agrave; hệ thống ao hồ rẻ , kh&ocirc;ng mất ph&iacute; nhập khẩu v&agrave; vận chuyển)</li>
</ul>
</div>
<div class="about-yt"><img id="introduceIshikoifarm-secIntroDerection-img" class="wk-editable-image" style="display: block; margin-left: auto; margin-right: auto;" src="https://ishikoi.vn/tassets/images/hinh-anh-secIntroDirection.png"></div>
</div>
</div>
</section>
<section id="section_id12" class="secImageBot">
<div class="container-fluid">
<div class="row mg-0">
<div class="item"><img id="introduceIshikoifarm-secImageBot-img" class="wk-editable-image" style="display: block; margin-left: auto; margin-right: auto;" src="https://ishikoi.vn/tassets/images/hinh-anh-secImageBot-1.png"></div>
<div class="item"><img id="introduceIshikoifarm-secImageBot-img2" class="wk-editable-image" style="display: block; margin-left: auto; margin-right: auto;" src="https://ishikoi.vn/tassets/images/hinh-anh-secImageBot-2.png"></div>
<div class="item"><img id="introduceIshikoifarm-secImageBot-img3" class="wk-editable-image" style="display: block; margin-left: auto; margin-right: auto;" src="https://ishikoi.vn/tassets/images/hinh-anh-secImageBot-3.png"></div>
<div class="item"><img id="introduceIshikoifarm-secImageBot-img4" class="wk-editable-image" style="display: block; margin-left: auto; margin-right: auto;" src="https://ishikoi.vn/tassets/images/hinh-anh-secImageBot-4.png"></div>
<div class="item">Li&ecirc;n hệ ngay : <a href="https://ishikoi.vn/">Ishi Koi Farm - Kết Nối Đam M&ecirc; C&aacute; Koi</a></div>
</div>
</div>
</section>', N'tin', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD081', N'Koilands Coffee - Thiên Đường Cá Koi Giữa Lòng Thành Phố', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/KoilandsCoffee.jpg?alt=media&token=020bdd6b-96d9-45bf-bd41-60923db72390', N'<p class="MsoNormal" style="text-align: center;"><strong>Koilands Coffee - Nơi Hội&nbsp;Tụ Văn H&oacute;a&nbsp;Nhật Bản&nbsp;&amp; Nghệ Thuật&nbsp;C&agrave; Ph&ecirc;</strong></p>
<p class="MsoNormal" style="text-align: center;">Giữa nhịp sống hối hả của Thủ Đức, Koilands Coffee hiện l&ecirc;n như một ốc đảo b&igrave;nh y&ecirc;n với kh&ocirc;ng gian Nhật Bản tinh tế. Tọa lạc tại 36 Đường số 12, Phường Tam B&igrave;nh, qu&aacute;n kh&ocirc;ng chỉ l&agrave; điểm dừng ch&acirc;n thưởng thức c&agrave; ph&ecirc; m&agrave; c&ograve;n l&agrave; nơi để t&acirc;m hồn được nghỉ ngơi, thư th&aacute;i.</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;"><span style="mso-no-proof: yes;"><img src="https://scontent.fsgn5-12.fna.fbcdn.net/v/t39.30808-6/277673318_404139325048677_3337303223233591144_n.jpg?_nc_cat=103&amp;ccb=1-7&amp;_nc_sid=cc71e4&amp;_nc_eui2=AeHtXDg6xWmcNRQ2IwE4TPCq-yMbk3WXgmX7IxuTdZeCZfq8wJb0YsVj9FQTRd6JHY7XKd_S0mYgLmOK7xs_dHeS&amp;_nc_ohc=mKlI1uyW8vgQ7kNvgFlRTYB&amp;_nc_zt=23&amp;_nc_ht=scontent.fsgn5-12.fna&amp;_nc_gid=AGWQkz9aI1kOsTUNGzKUzn8&amp;oh=00_AYCzLi77JNTibcdTdh_rEDkMDhYzaNeMjmCDGtrG9AjfDg&amp;oe=6727C24D"><br><!--[endif]--></span></p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;"> Kiến Tr&uacute;c&nbsp;&amp; Kh&ocirc;ng Gian</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;">Bước v&agrave;o Koilands Coffee, bạn sẽ ngay lập tức bị cuốn h&uacute;t bởi kh&ocirc;ng gian thiết kế độc đ&aacute;o mang đậm phong c&aacute;ch Nhật Bản. Những gam m&agrave;u trầm ấm của gỗ tự nhi&ecirc;n h&ograve;a quyện c&ugrave;ng &aacute;nh s&aacute;ng dịu nhẹ tạo n&ecirc;n bầu kh&ocirc;ng kh&iacute; thanh b&igrave;nh, tĩnh lặng. Điểm nhấn ấn tượng ch&iacute;nh l&agrave; những khung cửa k&iacute;nh panorama rộng lớn, nơi &aacute;nh nắng tự nhi&ecirc;n được ch&agrave;o đ&oacute;n, len lỏi qua từng g&oacute;c nhỏ của qu&aacute;n. Khi bước ra khu vực s&acirc;n vườn, bạn sẽ được đắm m&igrave;nh trong một kh&ocirc;ng gian xanh m&aacute;t với những t&aacute;n c&acirc;y sum su&ecirc;, điểm xuyết bởi những chiếc đ&egrave;n trang tr&iacute; lung linh. Tr&aacute;i tim của kh&ocirc;ng gian ch&iacute;nh l&agrave; hồ c&aacute; Koi rộng hơn 100m&sup2; được thiết kế tỉ mỉ, nơi những ch&uacute; c&aacute; Koi đủ sắc m&agrave;u bơi lội tung tăng. Điểm xuyết trong kh&ocirc;ng gian l&agrave; những chiếc cầu gỗ uốn lượn, những chiếc đ&egrave;n lồng đỏ thắm v&agrave; những tiểu cảnh nghệ thuật - tất cả tạo n&ecirc;n những g&oacute;c check-in tuyệt đẹp, như đưa bạn đến thẳng một g&oacute;c nhỏ của xứ sở hoa anh đ&agrave;o.</p>
<p class="MsoNormal" style="text-align: center;"><span style="mso-no-proof: yes;"><br><!--[endif]--></span></p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;"> Đ&agrave;n C&aacute; Koi Đặc Biệt</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;">Sở hữu hơn 100 con c&aacute; Koi được tuyển chọn kỹ lưỡng</p>
<p class="MsoNormal" style="text-align: center;">Đa dạng c&aacute;c giống c&aacute; nổi tiếng: Kohaku, Sanke, Showa, Tancho</p>
<p class="MsoNormal" style="text-align: center;">Hệ thống lọc nước hiện đại đảm bảo m&ocirc;i trường sống tốt nhất cho c&aacute;</p>
<p class="MsoNormal" style="text-align: center;">C&oacute; nh&acirc;n vi&ecirc;n chuy&ecirc;n m&ocirc;n chăm s&oacute;c đ&agrave;n c&aacute; h&agrave;ng ng&agrave;y</p>
<p class="MsoNormal" style="text-align: center;">Kh&aacute;ch c&oacute; thể mua thức ăn chuy&ecirc;n dụng để cho c&aacute;</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;"> Thực Đơn Phong Ph&uacute;</p>
<p class="MsoNormal" style="text-align: center;">C&agrave; ph&ecirc; đặc biệt: Cold Brew, Pour Over, Espresso</p>
<p class="MsoNormal" style="text-align: center;">Signature drinks: Koiland Special Coffee, Matcha Latte</p>
<p class="MsoNormal" style="text-align: center;">Tr&agrave; đạo Nhật Bản: Sencha, Hojicha, Genmaicha</p>
<p class="MsoNormal" style="text-align: center;">Nước &eacute;p v&agrave; sinh tố tươi từ tr&aacute;i c&acirc;y theo m&ugrave;a</p>
<p class="MsoNormal" style="text-align: center;">B&aacute;nh ngọt handmade: Matcha Cake, Tiramisu, Cheese Cake</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>
<p class="MsoNormal" style="text-align: center;"> Trải Nghiệm Độc Đ&aacute;o</p>
<p class="MsoNormal" style="text-align: center;">Workshop tr&agrave; đạo định kỳ v&agrave;o cuối tuần</p>
<p class="MsoNormal" style="text-align: center;">Buổi chia sẻ về văn h&oacute;a v&agrave; nghệ thuật Nhật Bản</p>
<p class="MsoNormal" style="text-align: center;">Kh&ocirc;ng gian l&agrave;m việc với wifi tốc độ cao</p>
<p class="MsoNormal" style="text-align: center;">G&oacute;c s&aacute;ch với nhiều tựa s&aacute;ch hay về Nhật Bản</p>
<p class="MsoNormal" style="text-align: center;">Dịch vụ chụp ảnh kỷ niệm chuy&ecirc;n nghiệp</p>
<p class="MsoNormal" style="text-align: center;">&nbsp;</p>', N'khoa', N'Mộc', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD083', N'ONKOI - Koi Farm lớn nhất Hà Nội', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Depositphotos_3453577_xl-2015.jpg?alt=media&token=a31e8a7e-d0fc-4b6e-b943-280456a8553f', N'<h1 class="page_title" style="text-align: center;">Gi&aacute; c&aacute; koi chuẩn nhật f0 + f1 70 cm</h1>
<div class="content_page">
<div class="content-post clearfix">
<div id="ftwp-postcontent">
<pre class="wp-block-verse"><strong>Gi&aacute; c&aacute; koi chuẩn nhật f0 + f1 70 cm trở l&ecirc;n &ndash; cam kết 100% nhập khẩu từ nhật bản</strong></pre>
<div class="is-layout-flex wp-container-242 wp-block-columns">
<div class="is-layout-flow wp-block-column">
<p>Onkoi l&agrave; koi farm c&aacute; koi Nhật Bản lớn nhất H&agrave; Nội. Tại đ&acirc;y c&oacute; đầy đủ c&aacute;c d&ograve;ng c&aacute; koi từ c&aacute;c trang trại lớn của Nhật Bản như: Dainichi Koi Farm, MoMoTaro- Koi, Isa Koi farm, Sakai Koi Farm, Marudo Koi Farm, Marusei Koi Farm&hellip; Ch&uacute;ng t&ocirc;i b&aacute;o gi&aacute; năm 2021 cho c&aacute;c em koi Size Jumpo được nhập từ c&aacute;c Koi farm n&agrave;y. Hiện đang được chăm s&oacute;c tại OnKoi.</p>
</div>
<div class="is-layout-flow wp-block-column"><iframe class="entered litespeed-loaded" style="display: table; margin-left: auto; margin-right: auto;" src="https://www.youtube.com/embed/ZAwjT3fPWrU?start=3" width="360" height="215" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="allowfullscreen" data-lazyloaded="1" data-src="https://www.youtube.com/embed/ZAwjT3fPWrU?start=3" data-ll-status="loaded"></iframe></div>
</div>
<p><strong>4</strong>&nbsp;<strong>KHUYẾN C&Aacute;O CHO C&Aacute;C BẠN SI&Ecirc;U TẦM KOI NHẬT:</strong></p>
<p><strong>1</strong>. C&aacute;c bạn chơi koi lưu &yacute; ở việt nam c&oacute; 1 v&agrave;i Koi Farm lớn, chuy&ecirc;n nghiệp đủ tiềm lực nhập c&aacute;c d&ograve;ng c&aacute; Koi size Jumpo chất lượng của Nhật Bản. Khu vực Ph&iacute;a Bắc chỉ c&oacute; Onkoi, ph&iacute;a nam c&oacute; 1 v&agrave;i Koi Farm kh&aacute;c. Để mua được Koi size JumBo v&agrave; chăm s&oacute;c được c&aacute;c em ấy cần c&oacute; đối t&aacute;c uy t&iacute;n b&ecirc;n Nhật, chuyển giao kinh nghiệm tại trại dưỡng Việt Nam, hồ nu&ocirc;i đạt ti&ecirc;u chuẩn.</p>
<p><strong>2</strong>. Bạn n&ecirc;n t&igrave;m cho m&igrave;nh 1 chuy&ecirc;n gia tư vấn &ndash; chọn c&aacute; tại trại lớn, c&oacute; hệ thống dưỡng ao b&ugrave;n v&agrave; hệ trại dưỡng c&aacute;ch ly đạt chuẩn.</p>
<p>Tại sao ch&uacute;ng t&ocirc;i phải n&oacute;i đến trại ao b&ugrave;n v&agrave; trại dưỡng đạt chuẩn v&igrave; c&aacute;c em c&aacute; bạn chơi được nh&acirc;n giống tại nhật, sau đ&oacute; được nhập khẩu (giai đoạn n&agrave;y c&aacute; thường xuy&ecirc;n đổ bệnh do chưa kịp th&iacute;ch nghi) c&aacute; cần dưỡng tại Việt Nam ở m&ocirc;i trường ao b&ugrave;n &iacute;t nhất 1 năm để c&oacute; đủ thời gian th&iacute;ch nghi kh&iacute; hậu. Khu vực ph&iacute;a bắc l&agrave; m&ocirc;i trường l&yacute; tưởng để c&aacute; ph&aacute;t triển tốt v&igrave; tạo h&oacute;a 4 m&ugrave;a + nước+ đất+ kh&iacute; hậu ph&ugrave; hợp với lo&agrave;i c&aacute; nước nợ thuần ngọt.</p>
<p>Sau khi được thuần 1 năm đem c&aacute;ch ly theo quy tr&igrave;nh 6 th&aacute;ng tr&ecirc;n ao xi măng c&aacute; đảm bảo 9 ti&ecirc;u ch&iacute; sau:</p>
<div class="is-layout-flex wp-container-245 wp-block-columns">
<div class="is-layout-flow wp-block-column">
<ol>
<li><em>Sạch nhớt.</em></li>
<li><em>Săn chắc</em></li>
<li><em>Kh&aacute;ng bệnh</em></li>
<li><em>Khỏe</em></li>
<li><em>Kh&ocirc;ng mầm virus</em></li>
<li><em>Chống stress</em></li>
<li><em>Tuổi thọ cao</em></li>
<li><em>Dạn người</em></li>
<li><em>Dẫn v&agrave; theo đ&agrave;n tốt</em></li>
</ol>
</div>
<div class="is-layout-flow wp-block-column"><iframe class="entered litespeed-loaded" style="display: table; margin-left: auto; margin-right: auto;" src="https://www.youtube.com/embed/PlkgknCOKxg" width="360" height="215" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="allowfullscreen" data-lazyloaded="1" data-src="https://www.youtube.com/embed/PlkgknCOKxg" data-ll-status="loaded"></iframe></div>
</div>
<p>Ngược lại nếu bạn mua koi tại những trại kh&ocirc;ng r&otilde; nguồn gốc, kh&ocirc;ng đạt ti&ecirc;u chẩn về trại dưỡng th&igrave; c&aacute;c em koi c&oacute; thể gặp nhiều rủi ro.</p>
<p><strong>3</strong>. Bạn n&ecirc;n tuyển những em koi c&oacute; đủ phẩm chất ngay từ đầu theo những ti&ecirc;u ch&iacute; sau:</p>
<ul>
<li><em>M&agrave;u sắc</em>&nbsp;<em>đẹp</em>.</li>
<li><em>Body &ndash; Jumbo</em>&nbsp;<em>cho tương lai đạt k&iacute;ch thước kịch đại</em>.</li>
<li><em>Tay bơi c&acirc;n đối</em>.</li>
<li><em>Nh&agrave; b&aacute;n c&oacute; th&acirc;m ni&ecirc;n v&agrave; thương hiệu</em>.</li>
<li><em>Xuất sứ trại</em>&nbsp;<em>uy t&iacute;n</em>.</li>
</ul>
<p style="text-align: center;"><a href="https://onkoi.vn/">C&ocirc;ng ty TNHH On Koi Quang Minh</a></p>
</div>
</div>
</div>', N'tin', N'Thủy', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD126', N'Bán cá Koi Nhật Bản cao cấp - Đa dạng màu sắc và kích thước', N'https://hcmtoplist.com/wp-content/uploads/2022/06/ca-canh-hong-ngoc-thu-duc-hcmtoplist.jpg', N'<p style="text-align: center;">- Chúng tôi cung cấp cá Koi Nhật Bản, biểu tượng của sự may mắn và thịnh vượng, nhập khẩu trực tiếp từ Nhật Bản với đa dạng màu sắc và kích thước.<br>- Cá Koi được nuôi dưỡng và kiểm tra sức khỏe định kỳ theo tiêu chuẩn nghiêm ngặt, đảm bảo không bệnh tật và sức khỏe tốt trước khi đến tay khách hàng.<br>- Chúng tôi còn cung cấp các dịch vụ như bảo hành sức khỏe cá trong 1 tháng, tư vấn thiết kế và bảo trì hồ cá miễn phí.<br>- Cá được vận chuyển toàn quốc với quy trình an toàn và chuyên nghiệp.</p>
<p style="text-align: center;"><img src="https://lh4.googleusercontent.com/-AS1lzLCGTNY/UhotkitWW4I/AAAAAAAABIg/1waPcLknTqM/w640-h480-no/ca-chep-koi.jpg" alt="Cá Koi Nhật Bản cao cấp"></p> 
<p style="text-align: center;">Liên hệ ngay để được tư vấn và sở hữu những chú cá Koi đẹp mắt, mang lại tài lộc và sự thịnh vượng.</p> 
<p style="text-align: center;">Công ty Koi Việt<br>Tel: 0933.549.011<br>E-mail: koiviet@gmail.com<br>Website: https://www.koiviet.com</p>', N'khoa', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD189', N'KING KOI FARM - VƯƠNG QUỐC CÁ KOI ĐẲNG CẤP', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/h3.jpeg?alt=media&token=aeb02c3d-b0ec-42af-9d81-53ac3d8a659c', N'<p class="MsoNormal" style="text-align: center;" align="center">KING&nbsp;KOI FARM&nbsp;- VƯƠNG QUỐC C&Aacute; KOI ĐẲNG&nbsp;CẤP</p>
<p class="MsoNormal" style="text-align: center;" align="center"><img src="https://storage.googleapis.com/mmstudio-images/gallery/AhvOgFGA4jcj9Xtx9NZIpIwF4Vw2/1666067256085-0.jpg" alt="Comprehension About Koi Fish with King Koi Farm | SproutNews" width="500" height="375"></p>
<p class="MsoNormal" style="text-align: center;" align="center">Bạn đ&atilde;&nbsp;bao giờ&nbsp;đắm ch&igrave;m trong vũ&nbsp;điệu của những&nbsp;ch&uacute; c&aacute;&nbsp;Koi uyển&nbsp;chuyển, nơi m&agrave; từng đường v&acirc;n, từng sắc m&agrave;u đều&nbsp;l&agrave; một t&aacute;c phẩm nghệ&nbsp;thuật ho&agrave;n mỹ? Tại King&nbsp;Koi Farm, ch&uacute;ng t&ocirc;i kh&ocirc;ng đơn&nbsp;thuần l&agrave; nơi b&aacute;n c&aacute;&nbsp;Koi - m&agrave; l&agrave; nơi&nbsp;hiện thực h&oacute;a giấc mơ về một&nbsp;khu vườn&nbsp;Nhật tĩnh lặng ngay tại nh&agrave; bạn. Mỗi&nbsp;ch&uacute; c&aacute; trong hồ như một&nbsp;n&eacute;t chấm ph&aacute; tinh tế, mang đến sự b&igrave;nh&nbsp;y&ecirc;n v&agrave; thịnh vượng cho&nbsp;kh&ocirc;ng gian sống&nbsp;của bạn.</p>
<p class="MsoNormal" style="text-align: center;" align="center">H&atilde;y tưởng tượng, mỗi buổi s&aacute;ng thức&nbsp;dậy, bạn được ch&agrave;o&nbsp;đ&oacute;n bởi những ch&uacute; c&aacute;&nbsp;Koi đủ sắc m&agrave;u bơi lội tung tăng, như một bức tranh thủy mặc sống động. Tiếng nước r&oacute;c r&aacute;ch từ hệ thống&nbsp;lọc, &aacute;nh nắng chiếu qua l&agrave;n nước trong vắt, tạo n&ecirc;n những đốm s&aacute;ng lấp l&aacute;nh&nbsp;tr&ecirc;n th&acirc;n c&aacute; - một bức&nbsp;tranh thi&ecirc;n nhi&ecirc;n ho&agrave;n hảo m&agrave; chỉ c&oacute; thể t&igrave;m thấy tại King&nbsp;Koi Farm. Đ&acirc;y kh&ocirc;ng chỉ l&agrave; niềm đam m&ecirc;, m&agrave; c&ograve;n l&agrave; nghệ&nbsp;thuật sống, l&agrave; c&aacute;ch để tận hưởng từng khoảnh khắc b&igrave;nh y&ecirc;n giữa nhịp sống hối hả.</p>
<p class="MsoNormal" style="text-align: center;" align="center"><img src="https://images.pexels.com/photos/18733131/pexels-photo-18733131/free-photo-of-ao-b-i-l-i-ca-ch-p-nh-d-ng-v-t.jpeg?auto=compress&amp;cs=tinysrgb&amp;dpr=1&amp;w=500" alt="Miễn ph&iacute; Ảnh lưu trữ miễn ph&iacute; về ao, b&igrave;nh y&ecirc;n, bơi lội Ảnh lưu trữ" width="500" height="375"></p>
<p class="MsoNormal" style="text-align: center;" align="center">V&Igrave;&nbsp;SAO KING KOI FARM&nbsp;L&Agrave; LỰA CHỌN H&Agrave;NG ĐẦU?</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull;&nbsp;15+ năm kinh nghiệm trong lĩnh vực&nbsp;c&aacute; Koi</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Nh&agrave; ph&acirc;n phối độc quyền c&aacute;c&nbsp;d&ograve;ng Koi qu&yacute; hiếm từ&nbsp;Nhật Bản</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Đội ngũ chuy&ecirc;n gia tư vấn tận t&acirc;m, am&nbsp;hiểu s&acirc;u sắc về c&aacute; Koi</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Cơ sở vật&nbsp;chất hiện đại, quy m&ocirc; lớn tại Quận 12</p>
<p class="MsoNormal" style="text-align: center;" align="center">DỊCH VỤ ĐẲNG CẤP TẠI KING&nbsp;KOI:</p>
<p class="MsoNormal" style="text-align: center;" align="center">C&aacute; Koi&nbsp;Đa Dạng:</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Koi Nhật&nbsp;Bản thuần chủng</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Koi&nbsp;F1 chất&nbsp;lượng cao</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Đủ size từ 15cm đến 75cm+</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Đa&nbsp;dạng về m&agrave;u sắc&nbsp;v&agrave; giống</p>
<p class="MsoNormal" style="text-align: center;" align="center">Sản Phẩm Chăm S&oacute;c&nbsp;Chuy&ecirc;n Nghiệp:</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Thức ăn cao&nbsp;cấp từ Nhật&nbsp;Bản</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Thuốc ph&ograve;ng v&agrave;&nbsp;trị bệnh chuy&ecirc;n dụng</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Thiết bị lọc nước c&ocirc;ng&nbsp;nghệ Nhật</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Phụ kiện chăm s&oacute;c&nbsp;đầy đủ</p>
<p class="MsoNormal" style="text-align: center;" align="center">Dịch Vụ&nbsp;To&agrave;n Diện:</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Tư vấn&nbsp;thiết kế v&agrave;&nbsp;x&acirc;y dựng hồ Koi</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Bảo h&agrave;nh d&agrave;i hạn</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Hỗ trợ&nbsp;kỹ thuật 24/7</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Vận chuyển an&nbsp;to&agrave;n to&agrave;n quốc</p>
<p class="MsoNormal" style="text-align: center;" align="center">CAM KẾT&nbsp;CỦA CH&Uacute;NG T&Ocirc;I:</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; C&aacute; Koi khỏe mạnh, đẹp chuẩn form</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Gi&aacute; cả cạnh tranh, ph&ugrave; hợp mọi ng&acirc;n s&aacute;ch</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Chứng nhận nguồn gốc&nbsp;r&otilde; r&agrave;ng</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Dịch vụ hậu m&atilde;i chu&nbsp;đ&aacute;o</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Tư vấn tận t&igrave;nh, chuy&ecirc;n nghiệp</p>
<p class="MsoNormal" style="text-align: center;" align="center">ƯU Đ&Atilde;I&nbsp;ĐẶC BIỆT:</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Giảm 10% cho kh&aacute;ch h&agrave;ng mới</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Tặng thức ăn cao cấp cho&nbsp;đơn h&agrave;ng từ&nbsp;10 triệu</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Miễn ph&iacute; vận chuyển nội th&agrave;nh</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Tư vấn setup&nbsp;hồ miễn ph&iacute;</p>
<p class="MsoNormal" style="text-align: center;" align="center">TH&Ocirc;NG TIN LI&Ecirc;N HỆ:</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Địa chỉ: 182 Trần Thị H&egrave;, Hiệp Th&agrave;nh, Quận&nbsp;12, TP.HCM</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Website: kingkoifarm.com</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Hotline:&nbsp;[Số điện thoại]</p>
<p class="MsoNormal" style="text-align: center;" align="center">&bull; Facebook: [Link Facebook]</p>
<p class="MsoNormal" style="text-align: center;" align="center">Đến với King Koi&nbsp;Farm, bạn&nbsp;kh&ocirc;ng chỉ sở hữu những&nbsp;ch&uacute; c&aacute; Koi đẹp&nbsp;m&agrave; c&ograve;n nhận được sự tư vấn tận t&igrave;nh từ đội ngũ&nbsp;chuy&ecirc;n gia h&agrave;ng đầu. Ch&uacute;ng t&ocirc;i&nbsp;cam kết mang đến cho bạn những "b&aacute;u&nbsp;vật" ho&agrave;n hảo&nbsp;nhất từ đất nước mặt trời mọc!</p>
<p class="MsoNormal" style="text-align: center;" align="center">H&atilde;y để&nbsp;King Koi Farm biến ước mơ sở hữu hồ&nbsp;c&aacute; Koi&nbsp;đẳng cấp của bạn th&agrave;nh hiện&nbsp;thực!</p>
<p class="MsoNormal" style="text-align: center;" align="center">#KingKoiFarm #CaKoi #KoiNhatBan #HoKoi #SaiGon</p>', N'khoa', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD363', N'Dịch vụ vệ sinh hồ cá Koi, chữa bệnh cá ở TPHCM , Đồng Nai, Củ Chi Dịch vụ vệ sinh hồ cá Koi, chữa bệnh cá ở TPHCM , Đồng Nai, Củ Chi.', N'https://sanvuondep.net.vn/wp-content/uploads/2023/11/5.png', N'<p style="text-align: left;">C&aacute; Koi l&agrave; một trong những loại c&aacute; cảnh được nhập từ nước ngo&agrave;i về với gi&aacute; rất đắt. V&igrave; l&agrave; một lo&agrave;i c&aacute; kh&oacute; nu&ocirc;i, n&ecirc;n hồ c&aacute; Koi cũng đ&ograve;i hỏi rất khắc khe so với c&aacute;c loại hồ nu&ocirc;i c&aacute; kh&aacute;c. Việc vệ sinh hồ c&aacute; Koi cũng kh&ocirc;ng đơn giản, n&ecirc;n nếu cần h&atilde;y t&igrave;m đến dịch vụ vệ sinh hồ c&aacute; Koi của ch&uacute;ng t&ocirc;i ở Hồ Ch&iacute; Minh.&nbsp;<br>Những dấu hiệu cho thấy cần vệ sinh cho hồ c&aacute; Koi:&nbsp;<br>&ndash; Nước trong hồ c&aacute; Koi bắt đầu ngả m&agrave;u xanh lam, bắt đầu c&oacute; dấu hiệu đục nguồn nước, kh&ocirc;ng quan s&aacute;t được c&aacute; trong hồ, r&ecirc;u tảo xanh ph&aacute;t triển qu&aacute; nhiều khiến hồ bị đục nước.&nbsp;<br>&ndash; Sau một thời gian d&agrave;i vận h&agrave;nh, m&aacute;y lọc của hồ bắt đầu kh&ocirc;ng c&ograve;n được hoạt động tốt nữa. L&aacute; c&acirc;y rơi xuống l&agrave;m mất mỹ quan của hồ v&agrave; g&oacute;p phần l&agrave;m &ocirc; nhiễm nguồn nước của hồ. G&acirc;y kh&oacute; khăn cho việc hoạt động của hệ thống lọc nước của hồ c&aacute; Koi.&nbsp;<br>&ndash; Do c&aacute;ch cho c&aacute; ăn kh&ocirc;ng đ&uacute;ng c&aacute;ch l&agrave;m cho thức ăn thừa ứ đọng lại dưới đ&aacute;y bể cũng như ph&acirc;n c&aacute; sau thời gian d&agrave;i sẽ rất nhiều l&agrave;m cho đ&aacute;y hồ c&aacute; Koi kh&ocirc;ng c&ograve;n tho&aacute;ng v&agrave; đẹp như l&uacute;c trước.&nbsp;<br>&ndash; Ngo&agrave;i ra lượng chất thải qu&aacute; nhiều m&agrave; kh&ocirc;ng được xử l&yacute; kịp sẽ sinh ra nhiều loại vi khuẩn, c&aacute;c loại vi khuẩn n&agrave;y kh&ocirc;ng chỉ l&agrave;m nước đục m&agrave; c&ograve;n c&oacute; thể sinh ra nhiều bệnh v&agrave; nghi&ecirc;m trọng hơn l&agrave; c&oacute; thể g&acirc;y chết c&aacute;.&nbsp;<br>&ndash; Hồ c&oacute; đầy r&aacute;c tr&ecirc;n bề mặt cũng l&agrave; một dấu hiệu n&ecirc;n vệ sinh hồ c&aacute;.&nbsp;<br>&ndash; Hồ c&aacute; trước đ&oacute; c&oacute; nhiều c&aacute; chết, c&oacute; nhiều v&aacute;ng bọt nổi tr&ecirc;n bề mặt, th&igrave; cần vệ sinh để khong g&acirc;y hại cho c&aacute; kh&aacute;c v&igrave; hồ đ&atilde; bị nhiễm khuẩn c&oacute; hại.&nbsp;<br>Quang Minh Landscape cung cấp dịch vụ https://cayxanhhcm.com.vn/thiet-ke-va-thi-cong-ho-ca-koi/ tại Đồng Nai, TPHCM, B&igrave;nh Dương, BRVT&hellip; Li&ecirc;n hệ với ch&uacute;ng t&ocirc;i qua Hotline 0792.662.678 để được tư vấn tận t&igrave;nh, cụ thể 24/7</p>', N'huy', N'Kim', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD419', N'Bán cá Koi Nhật Bản chất lượng cao tại Biên Hòa', N'https://cakoibienhoa.com/themes/template/images/fb_default.jpg', N'<h2 class="detail-sapo" style="text-align: center;" data-role="sapo">Cá Koi Nhật Bản - Biểu tượng của sự may mắn và thịnh vượng. Chúng tôi chuyên cung cấp cá Koi nhập khẩu trực tiếp từ Nhật Bản với chất lượng đảm bảo, kích thước đa dạng, phù hợp với mọi nhu cầu.</h2> 
<p style="text-align: center;"><img src="https://cakoibienhoa.com/themes/template/images/fb_default.jpg" alt="Cá Koi Nhật Bản chất lượng cao"></p> 
<p style="text-align: center;">Cá Koi của chúng tôi được nuôi dưỡng theo tiêu chuẩn Nhật Bản, với màu sắc đa dạng, sức sống mạnh mẽ và không mang mầm bệnh. Đội ngũ chuyên gia sẽ hỗ trợ tư vấn chăm sóc hồ cá Koi tận tình.</p> 
<p style="text-align: center;">Chúng tôi cam kết:</p> 
<ul> 
<li>Nhập khẩu cá Koi trực tiếp từ các trại cá uy tín ở Nhật Bản</li> 
<li>Cung cấp dịch vụ bảo hành sức khỏe cá trong 1 tháng</li> 
<li>Tư vấn miễn phí về thiết kế hồ cá và cách chăm sóc</li> 
<li>Vận chuyển toàn quốc, đảm bảo an toàn tuyệt đối cho cá Koi</li> 
</ul> 
<p style="text-align: center;">Liên hệ ngay để sở hữu những chú cá Koi đẳng cấp, mang lại may mắn và tài lộc cho gia đình bạn!</p>', N'khoa', N'Thủy', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD483', N'Thiết kế và thi công hồ cá Koi tại Sơn La', N'https://vn1.vdrive.vn/koixinh.com/2023/08/Dich-vu-thi-cong-ho-ca-Koi-tai-Thai-Nguyen-2.webp', N'<h2 id="ftoc-heading-31" class="ftwp-heading ftwp-heading"><strong>Quy tr&igrave;nh thiết kế thi c&ocirc;ng hồ c&aacute; Koi tại Sơn La của Koixinh</strong></h2>
<h2 class="ftwp-heading ftwp-heading"><strong>Khảo s&aacute;t thực tế</strong></h2>
<p>Trong qu&aacute; tr&igrave;nh&nbsp;<strong>x&acirc;y dựng hồ c&aacute; Koi tại Sơn La</strong>, ch&uacute;ng t&ocirc;i tu&acirc;n thủ c&aacute;c bước sau đ&acirc;y. Đầu ti&ecirc;n, chọn vị tr&iacute; ph&ugrave; hợp để x&acirc;y dựng hồ c&aacute; Koi, ưu ti&ecirc;n lựa chọn một vị tr&iacute; bằng phẳng, kh&ocirc;ng dốc hoặc l&otilde;m, nhằm tr&aacute;nh nguy cơ tr&agrave;n nước từ b&ecirc;n ngo&agrave;i khi c&oacute; mưa lớn. Đồng thời, ch&uacute;ng t&ocirc;i cũng xem x&eacute;t c&aacute;c yếu tố phong thủy để đảm bảo hồ mang lại sự h&agrave;i h&ograve;a v&agrave; t&agrave;i lộc cho ng&ocirc;i nh&agrave; hoặc khu vực xung quanh.</p>
<p>Tiếp theo, ch&uacute;ng t&ocirc;i thực hiện đo đạc ch&iacute;nh x&aacute;c k&iacute;ch thước hồ v&agrave; x&aacute;c định số lượng c&aacute; Koi cần thả dựa tr&ecirc;n y&ecirc;u cầu của kh&aacute;ch h&agrave;ng. Sau đ&oacute;, ch&uacute;ng t&ocirc;i tiến h&agrave;nh ph&aacute;c thảo sơ bộ thiết kế hồ c&aacute; Koi, đảm bảo hồ c&oacute; diện t&iacute;ch v&agrave; định h&igrave;nh ph&ugrave; hợp với kh&ocirc;ng gian sẵn c&oacute; v&agrave; mong muốn của kh&aacute;ch h&agrave;ng.</p>
<p>Bằng c&aacute;ch tu&acirc;n thủ quy tr&igrave;nh tr&ecirc;n, ch&uacute;ng t&ocirc;i cam kết mang đến hồ c&aacute; Koi ho&agrave;n hảo, tạo ra kh&ocirc;ng gian tươi mới, thư th&aacute;i v&agrave; gần gũi với thi&ecirc;n nhi&ecirc;n, đồng thời đ&aacute;p ứng đầy đủ nhu cầu v&agrave; y&ecirc;u cầu của kh&aacute;ch h&agrave;ng tại Sơn La.</p>
<h3 id="ftoc-heading-33" class="ftwp-heading ftwp-heading"><strong>Lập bản thiết kế chi tiết</strong></h3>
<p><strong>Koixinh</strong>&nbsp;l&agrave;m việc dựa tr&ecirc;n c&aacute;c y&ecirc;u cầu cụ thể từ kh&aacute;ch h&agrave;ng v&agrave; th&ocirc;ng tin thực tế về vị tr&iacute;, chiều d&agrave;i, chiều rộng của hồ, c&ugrave;ng với yếu tố mệnh của gia chủ. Ch&uacute;ng t&ocirc;i sẽ thực hiện thiết kế bản vẽ 3D để kh&aacute;ch h&agrave;ng c&oacute; thể h&igrave;nh dung r&otilde; hơn về cảnh quan của kh&ocirc;ng gian. Bản vẽ n&agrave;y cho ph&eacute;p kh&aacute;ch h&agrave;ng chỉnh sửa v&agrave; thay đổi theo &yacute; muốn của họ.</p>
<p>Bản vẽ thiết kế chi tiết sẽ bao gồm c&aacute;c th&ocirc;ng tin sau để đảm bảo qu&aacute; tr&igrave;nh&nbsp;<strong>thi c&ocirc;ng hồ c&aacute; Koi tại Sơn La</strong>&nbsp;diễn ra thuận lợi v&agrave; đạt chuẩn cao nhất:</p>
<ul>
<li><strong>Vị tr&iacute; hồ:</strong>&nbsp;X&aacute;c định đ&uacute;ng vị tr&iacute; v&agrave; hướng đặt hồ c&aacute; Koi trong kh&ocirc;ng gian.</li>
<li><strong>Kiểu d&aacute;ng v&agrave; k&iacute;ch thước:</strong>&nbsp;X&aacute;c định kiểu d&aacute;ng v&agrave; k&iacute;ch thước của hồ ph&ugrave; hợp với kh&ocirc;ng gian sẵn c&oacute;.</li>
<li><strong>Chiều s&acirc;u l&ograve;ng hồ:</strong>&nbsp;Đảm bảo s&acirc;u l&ograve;ng hồ ph&ugrave; hợp với y&ecirc;u cầu của c&aacute; Koi v&agrave; m&ocirc;i trường sống.</li>
<li><strong>Vị tr&iacute; hệ thống lọc:</strong>&nbsp;X&aacute;c định ch&iacute;nh x&aacute;c vị tr&iacute; v&agrave; kiểu hệ thống lọc để đảm bảo nước trong hồ lu&ocirc;n sạch sẽ v&agrave; an to&agrave;n cho c&aacute;.</li>
<li><strong>Thiết kế tiểu cảnh:</strong>&nbsp;Bao gồm c&aacute;c yếu tố như đ&aacute;, c&acirc;y cỏ, v&agrave; phụ kiện để tạo n&ecirc;n cảnh quan sinh động v&agrave; hấp dẫn cho hồ.</li>
<li><strong>Bố tr&iacute; c&acirc;y trong hồ:</strong>&nbsp;X&aacute;c định c&aacute;ch bố tr&iacute; c&acirc;y trong hồ sao cho tạo được sự c&acirc;n đối v&agrave; tương hỗ với c&aacute; Koi.</li>
<li><strong>Kh&ocirc;ng gian xung quanh hồ:</strong>&nbsp;Định h&igrave;nh c&aacute;c yếu tố xung quanh hồ để tạo n&ecirc;n một kh&ocirc;ng gian thẩm mỹ v&agrave; h&agrave;i h&ograve;a cho ng&ocirc;i nh&agrave; hoặc c&ocirc;ng vi&ecirc;n.</li>
</ul>
<p>Với bản vẽ chi tiết như vậy, ch&uacute;ng t&ocirc;i cam kết gi&uacute;p qu&aacute; tr&igrave;nh thi c&ocirc;ng hồ c&aacute; Koi diễn ra một c&aacute;ch dễ d&agrave;ng, nhanh ch&oacute;ng v&agrave; đạt được chất lượng cao nhất để mang lại sự h&agrave;i l&ograve;ng cho kh&aacute;ch h&agrave;ng tại Sơn La.</p>
<h3 id="ftoc-heading-34" class="ftwp-heading ftwp-heading"><strong>Thi c&ocirc;ng theo bản vẽ</strong></h3>
<p>Trước ti&ecirc;n, ch&uacute;ng t&ocirc;i sẽ bắt đầu qu&aacute; tr&igrave;nh&nbsp;<strong>x&acirc;y dựng hồ c&aacute; Koi tại Sơn La</strong>&nbsp;bằng việc dọn sạch mặt bằng v&agrave; tiến h&agrave;nh đ&agrave;o đất để tạo n&ecirc;n khung, x&aacute;c định độ s&acirc;u đ&aacute;y v&agrave; th&agrave;nh hồ. Sau đ&oacute;, ch&uacute;ng t&ocirc;i sẽ thực hiện lắp đặt hệ thống lọc ho&agrave;n chỉnh, bao gồm hệ thống h&uacute;t mặt, h&uacute;t đ&aacute;y v&agrave; đổi đ&aacute;y, hệ thống tạo d&ograve;ng, hệ thống oxy v&agrave; hệ thống UV. Những hệ thống n&agrave;y được thiết kế để ti&ecirc;u diệt mầm bệnh v&agrave; rong r&ecirc;u trong hồ, gi&uacute;p đảm bảo nước lu&ocirc;n trong l&agrave;nh v&agrave; m&ugrave;i tanh kh&ocirc;ng c&ograve;n tồn tại.</p>
<p>Đối với phần đ&aacute;y v&agrave; th&agrave;nh hồ, ch&uacute;ng t&ocirc;i sử dụng kết cấu sắt th&eacute;p để đảm bảo t&iacute;nh vững chắc v&agrave; đổ xi măng v&agrave; b&ecirc; t&ocirc;ng l&ecirc;n đ&oacute;. Kết cấu sắt th&eacute;p chắc chắn sẽ gi&uacute;p đảm bảo t&iacute;nh b&aacute;m d&iacute;nh mạnh mẽ của xi măng v&agrave; b&ecirc; t&ocirc;ng, từ đ&oacute; giảm thiểu việc hồ bị xuống cấp nhanh ch&oacute;ng v&agrave; đảm bảo tuổi thọ của hồ.</p>
<p>Th&agrave;nh hồ được x&acirc;y dựng bằng xi măng v&agrave; gạch để đảm bảo t&iacute;nh vững chắc v&agrave; sử dụng vật liệu chống thấm chuy&ecirc;n dụng như bạt, sơn, sika,&hellip; để đảm bảo hồ kh&ocirc;ng bị thấm nước. Việc sử dụng những vật liệu chống thấm chuy&ecirc;n dụng n&agrave;y gi&uacute;p đảm bảo rằng nước trong hồ sẽ kh&ocirc;ng tho&aacute;t ra v&agrave; đảm bảo m&ocirc;i trường sống của c&aacute; Koi được duy tr&igrave; ổn định.</p>
<p>Ch&uacute;ng t&ocirc;i cam kết sử dụng c&aacute;c c&ocirc;ng nghệ v&agrave; vật liệu hiện đại nhất trong qu&aacute; tr&igrave;nh&nbsp;<strong>x&acirc;y dựng hồ c&aacute; Koi tại Sơn La</strong>&nbsp;để đảm bảo chất lượng v&agrave; sự bền vững cho hồ c&aacute; của kh&aacute;ch h&agrave;ng.</p>
<h3 id="ftoc-heading-35" class="ftwp-heading ftwp-heading"><strong>Thiết kế tiểu cảnh trong v&agrave; xung quanh hồ</strong></h3>
<p>Bạn c&oacute; thể t&ugrave;y chỉnh tiểu cảnh của hồ c&aacute; Koi dựa v&agrave;o kh&ocirc;ng gian v&agrave; sở th&iacute;ch c&aacute; nh&acirc;n. C&oacute; nhiều lựa chọn để trang tr&iacute;, như h&ograve;n non bộ, đ&aacute; tảng hoặc c&acirc;y cảnh. Nếu bạn sử dụng đ&aacute;, h&atilde;y lựa chọn c&aacute;c loại đ&aacute; lớn v&agrave; nặng để tạo sự tự nhi&ecirc;n v&agrave; sắp xếp c&aacute;c h&ograve;n đ&aacute; nhỏ xung quanh ch&uacute;ng. Trồng th&ecirc;m c&acirc;y cảnh, đặc biệt l&agrave; những loại &iacute;t hoặc kh&ocirc;ng rụng l&aacute;, gi&uacute;p hồ c&aacute; lu&ocirc;n giữ được sạch sẽ.</p>
<p>Đối với hồ c&aacute; Koi, h&atilde;y kết hợp với n&uacute;i hay th&aacute;c nước để tăng t&iacute;nh thẩm mỹ v&agrave; phong thủy cho kh&ocirc;ng gian xung quanh. Khi kết hợp hồ c&aacute; Koi với h&ograve;n non bộ, bạn cần t&iacute;nh to&aacute;n chiều cao, kiểu d&aacute;ng của n&uacute;i v&agrave; hệ thống th&aacute;c nước để tạo sự c&acirc;n bằng h&agrave;i h&ograve;a. Việc th&ecirc;m h&ograve;n non bộ v&agrave;o hồ c&aacute; Koi sẽ tạo ra một khung cảnh tự nhi&ecirc;n v&agrave; ho&agrave;n hảo.</p>
<p>Th&aacute;c nước chảy trong hồ c&aacute; cũng sẽ hỗ trợ cung cấp oxy cho c&aacute; Koi, gi&uacute;p ch&uacute;ng c&oacute; m&ocirc;i trường sống tốt v&agrave; vui khỏe. Việc tăng cường oxy sẽ gi&uacute;p duy tr&igrave; sự sinh động v&agrave; sức khỏe cho c&aacute; Koi.</p>
<p>Việc trang tr&iacute; hồ c&aacute; Koi với tiểu cảnh ph&ugrave; hợp sẽ tạo n&ecirc;n một kh&ocirc;ng gian đẹp mắt v&agrave; thư gi&atilde;n, đồng thời hỗ trợ tốt cho sức khỏe v&agrave; sự ph&aacute;t triển của c&aacute; Koi.</p>
<h3 id="ftoc-heading-36" class="ftwp-heading ftwp-heading"><strong>Kiểm tra chất lượng nước, độ pH v&agrave; thả c&aacute; xuống hồ</strong></h3>
<p>Khi c&ocirc;ng việc ho&agrave;n tất, ch&uacute;ng t&ocirc;i sẽ tiến h&agrave;nh qu&aacute; tr&igrave;nh khử tr&ugrave;ng nước bằng dung dịch thuốc t&iacute;m s&aacute;t khuẩn đặc biệt d&agrave;nh ri&ecirc;ng cho hồ c&aacute;. Đồng thời, ch&uacute;ng t&ocirc;i sẽ kiểm tra nồng độ nitrat, nitric, amoniac trong hồ để đảm bảo m&ocirc;i trường sống cho c&aacute; Koi l&agrave; khỏe mạnh v&agrave; an to&agrave;n nhất.</p>
<p>Tiếp theo, ch&uacute;ng t&ocirc;i sẽ thả vi sinh v&agrave;o hồ v&agrave; tiến h&agrave;nh nu&ocirc;i vi sinh trong khoảng 5-10 ng&agrave;y trước khi thả c&aacute; Koi v&agrave;o hồ. Việc nu&ocirc;i vi sinh trước khi thả c&aacute; Koi gi&uacute;p c&acirc;n bằng vi khuẩn trong hồ, từ đ&oacute; gi&uacute;p cải thiện chất lượng nước v&agrave; tạo m&ocirc;i trường thuận lợi cho sự ph&aacute;t triển v&agrave; tăng trưởng của c&aacute; Koi.</p>
<p>Qu&aacute; tr&igrave;nh khử tr&ugrave;ng v&agrave; kiểm tra nước kỹ lưỡng, c&ugrave;ng với việc nu&ocirc;i vi sinh trước khi thả c&aacute; Koi v&agrave;o hồ, gi&uacute;p đảm bảo rằng m&ocirc;i trường sống của c&aacute; Koi được duy tr&igrave; trong t&igrave;nh trạng tốt nhất v&agrave; tối ưu nhất, mang lại sự vui khỏe v&agrave; thịnh vượng cho c&aacute;c c&aacute; Koi trong hồ.</p>
<h3 id="ftoc-heading-37" class="ftwp-heading ftwp-heading"><strong>Nghiệm thu v&agrave; b&agrave;n giao cho kh&aacute;ch h&agrave;ng</strong></h3>
<p>Đ&acirc;y l&agrave; giai đoạn cuối c&ugrave;ng trong quy tr&igrave;nh thiết kế v&agrave; x&acirc;y dựng hồ c&aacute; Koi của&nbsp;<strong>Koixinh</strong>. Trong giai đoạn n&agrave;y, ch&uacute;ng t&ocirc;i tiến h&agrave;nh kiểm tra lần cuối để đảm bảo chất lượng của hồ đạt đủ ti&ecirc;u chuẩn cao nhất. Ch&uacute;ng t&ocirc;i cam kết hỗ trợ tối đa v&agrave; tư vấn nhiệt t&igrave;nh cho kh&aacute;ch h&agrave;ng về c&aacute;ch cho c&aacute; ăn v&agrave; c&aacute;ch chăm s&oacute;c c&aacute; Koi sao cho chuẩn mực nhất.</p>
<p>Ch&uacute;ng t&ocirc;i lu&ocirc;n đặt lợi &iacute;ch v&agrave; sự h&agrave;i l&ograve;ng của kh&aacute;ch h&agrave;ng l&ecirc;n h&agrave;ng đầu v&agrave; cam kết cung cấp dịch vụ chăm s&oacute;c kh&aacute;ch h&agrave;ng tốt nhất. Bằng c&aacute;ch hỗ trợ v&agrave; tư vấn chi tiết, ch&uacute;ng t&ocirc;i mong muốn gi&uacute;p kh&aacute;ch h&agrave;ng c&oacute; được kinh nghiệm nu&ocirc;i c&aacute; Koi tốt nhất v&agrave; đảm bảo c&aacute; Koi lu&ocirc;n trong t&igrave;nh trạng khỏe mạnh v&agrave; ph&aacute;t triển tốt trong hồ.</p>
<p>Sự tận t&acirc;m v&agrave; chuy&ecirc;n nghiệp của ch&uacute;ng t&ocirc;i sẽ gi&uacute;p kh&aacute;ch h&agrave;ng y&ecirc;n t&acirc;m v&agrave; h&agrave;i l&ograve;ng với quyết định lựa chọn Koixinh trong việc&nbsp;<strong>thiết kế v&agrave; x&acirc;y dựng hồ c&aacute; Koi tại Sơn La.</strong></p>
<h2 id="ftoc-heading-10" class="ftwp-heading ftwp-heading ftwp-heading"><strong><span id="Nhung_luu_y_khi_de_thiet_ke_ho_Koi_chuyen_nghiep">Những lưu &yacute; khi thiết kế hồ c&aacute; Koi tại Sơn La</span></strong></h2>
<p>Khi thiết kế hồ c&aacute; Koi tại Sơn La, c&oacute; một số lưu &yacute; quan trọng cần c&acirc;n nhắc để đảm bảo chất lượng cao v&agrave; m&ocirc;i trường sống tốt cho c&aacute; Koi. Dưới đ&acirc;y l&agrave; những lưu &yacute; quan trọng khi thiết kế hồ c&aacute; Koi chất lượng cao:</p>
<ul>
<li><strong>Chọn vị tr&iacute; ph&ugrave; hợp:</strong>&nbsp;Chọn vị tr&iacute; ph&ugrave; hợp v&agrave; hợp l&yacute; để x&acirc;y dựng hồ c&aacute; Koi. Vị tr&iacute; n&ecirc;n c&oacute; &aacute;nh nắng mặt trời tốt v&agrave; tr&aacute;nh những khu vực c&oacute; t&aacute;c động nhiệt đới qu&aacute; mạnh v&agrave;o hồ. Đồng thời, hạn chế đặt hồ dưới &aacute;nh nắng trực tiếp cả ng&agrave;y để tr&aacute;nh tăng nhiệt độ nước qu&aacute; cao.</li>
<li><strong>X&aacute;c định k&iacute;ch thước v&agrave; h&igrave;nh dạng:</strong>&nbsp;X&aacute;c định k&iacute;ch thước v&agrave; h&igrave;nh dạng của hồ c&aacute; Koi dựa tr&ecirc;n diện t&iacute;ch sẵn c&oacute; v&agrave; &yacute; muốn của bạn. Hồ cần đủ rộng v&agrave; s&acirc;u để cung cấp đủ kh&ocirc;ng gian cho c&aacute; Koi di chuyển v&agrave; ph&aacute;t triển.</li>
<li><strong>Lựa chọn vật liệu chất lượng:</strong>&nbsp;Sử dụng vật liệu chất lượng cao để x&acirc;y dựng hồ c&aacute; Koi, đảm bảo t&iacute;nh chắc chắn v&agrave; bền vững theo thời gian. Vật liệu thường được sử dụng bao gồm xi măng, lớp chống thấm v&agrave; vật liệu sơn chịu nước.</li>
<li><strong>Hệ thống lọc:</strong>&nbsp;Chọn v&agrave; lắp đặt hệ thống lọc ph&ugrave; hợp. Điều n&agrave;y gi&uacute;p giữ cho nước trong sạch, giảm lượng chất bẩn v&agrave; đảm bảo m&ocirc;i trường sống l&agrave;nh mạnh cho c&aacute; Koi.</li>
<li><strong>C&acirc;n bằng nước v&agrave; dinh dưỡng:</strong>&nbsp;Đảm bảo c&acirc;n bằng nước trong hồ bằng c&aacute;ch kiểm tra v&agrave; điều chỉnh c&aacute;c yếu tố như pH, amoniac, nitrat v&agrave; nitrit. Cung cấp dinh dưỡng ph&ugrave; hợp v&agrave; thực phẩm tốt cho c&aacute; Koi để gi&uacute;p hỗ trợ sức khỏe v&agrave; ph&aacute;t triển của ch&uacute;ng.</li>
<li><strong>Trang tr&iacute; v&agrave; cảnh quan:</strong>&nbsp;Th&ecirc;m c&aacute;c yếu tố trang tr&iacute; như đ&aacute;, c&acirc;y cỏ, bể thủy sinh v&agrave; c&aacute;c yếu tố trang tr&iacute; kh&aacute;c để tạo điểm nhấn v&agrave; sự h&agrave;i h&ograve;a cho kh&ocirc;ng gian xung quanh hồ c&aacute; Koi.</li>
<li><strong>Đảm bảo an to&agrave;n:</strong>&nbsp;Đặc biệt quan trọng l&agrave; đảm bảo an to&agrave;n cho người xung quanh hồ c&aacute; Koi, đặc biệt l&agrave; trẻ em. Đảm bảo r&agrave;o chắn v&agrave; c&aacute;c biện ph&aacute;p an to&agrave;n kh&aacute;c để tr&aacute;nh nguy hiểm cho trẻ em v&agrave; vật nu&ocirc;i kh&aacute;c.</li>
<li><strong>Chăm s&oacute;c sau khi x&acirc;y dựng:</strong>&nbsp;Sau khi ho&agrave;n th&agrave;nh thi c&ocirc;ng, ch&uacute;ng t&ocirc;i n&ecirc;n hướng dẫn v&agrave; cung cấp th&ocirc;ng tin hữu &iacute;ch về việc chăm s&oacute;c hồ c&aacute; Koi để gi&uacute;p kh&aacute;ch h&agrave;ng duy tr&igrave; m&ocirc;i trường hồ lu&ocirc;n trong t&igrave;nh trạng tốt nhất.</li>
</ul>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://vn1.vdrive.vn/koixinh.com/2023/07/ho-2.png"></p>
<p>Khi thực hiện thiết kế hồ c&aacute; Koi chất lượng cao tại Sơn La, n&ecirc;n t&igrave;m đến c&aacute;c chuy&ecirc;n gia v&agrave; nh&agrave; cung cấp uy t&iacute;n v&agrave; c&oacute; kinh nghiệm trong lĩnh vực n&agrave;y. H&atilde;y đảm bảo rằng hồ c&aacute; Koi được x&acirc;y dựng v&agrave; thi c&ocirc;ng ch&iacute;nh x&aacute;c, đảm bảo cung cấp m&ocirc;i trường sống tốt nhất cho c&aacute; Koi của bạn.</p>
<p>Phong c&aacute;ch được lựa chọn để trang tr&iacute; hồ c&aacute; Koi cũng một phần n&agrave;o đ&oacute; n&oacute;i l&ecirc;n phong c&aacute;ch sống v&agrave; đẳng cấp của gia chủ. Ch&iacute;nh v&igrave; thế, c&oacute; rất nhiều người muốn x&acirc;y dựng v&agrave; thiết kế một hồ c&aacute; Koi trong s&acirc;n vườn cho ri&ecirc;ng m&igrave;nh. T&ugrave;y thuộc v&agrave;o diện t&iacute;ch, y&ecirc;u cầu kh&aacute;c nhau v&agrave; bản thiết kế m&agrave;&nbsp;<a href="https://koixinh.com/lien-he/"><strong>Koixinh</strong></a>&nbsp;sẽ c&oacute; b&aacute;o gi&aacute; cụ thể, chi tiết về chi ph&iacute;&nbsp;<strong>thiết kế, thi c&ocirc;ng hồ Koi tại Sơn La cũng như tại miền Bắc</strong>&nbsp;cho bạn.</p>
<p>C&oacute; thể n&oacute;i, lựa chọn một đơn vị thiết kế &ndash; thi c&ocirc;ng hồ c&aacute; Koi đạt chuẩn l&agrave; hết sức quan trọng. Nếu bạn chưa c&oacute; nhiều kinh nghiệm trong&nbsp;x&acirc;y dựng&nbsp;hồ c&aacute; Koi th&igrave; việc nhận tư vấn từ một đơn vị c&oacute; kinh nghiệm sẽ gi&uacute;p bạn kh&ocirc;ng chỉ tối ưu h&oacute;a chi ph&iacute; m&agrave; c&ograve;n n&acirc;ng cao độ thẩm mỹ. Cũng c&oacute; thể khẳng định rằng, một hồ Koi c&oacute; ph&aacute;t huy được gi&aacute; trị của n&oacute; hay kh&ocirc;ng phụ thuộc rất lớn v&agrave;o đơn vị thiết kế, thi c&ocirc;ng m&agrave; bạn lựa chọn.</p>
<p><strong>Koixinh</strong> l&agrave; đơn vị thi c&ocirc;ng hồ c&aacute; Koi với cam kết bảo h&agrave;nh trọn đời, cung cấp c&aacute;c giống c&aacute; lớn sống khỏe mạnh, thiết kế hồ đ&aacute;p ứng chuẩn c&aacute;c y&ecirc;u cầu về chất lượng đạt chuẩn. Trong qu&aacute; tr&igrave;nh sử dụng hồ c&aacute; Koi, nếu hồ hay c&aacute; gặp bất kỳ vấn đề g&igrave;, inh cam kết sẽ nhiệt t&igrave;nh tư vấn v&agrave; đồng h&agrave;nh c&ugrave;ng qu&yacute; kh&aacute;ch để sửa chữa, khắc phục. Sau khi chạy thử v&agrave; b&agrave;n giao hồ c&aacute; Koi cho kh&aacute;ch h&agrave;ng, ch&uacute;ng t&ocirc;i sẽ hướng dẫn cho bạn c&aacute;ch nu&ocirc;i c&aacute; đ&uacute;ng chuẩn v&agrave; tặng g&oacute;i ưu đ&atilde;i bảo h&agrave;nh cho bạn.</p>', N'nhan', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD551', N'Café Koi - Thư giãn cùng những chú cá Koi tuyệt đẹp', N'https://mia.vn/media/uploads/blog-du-lich/cafe-koikichi-1704808859.jpg', N'<p style="text-align: center;">- Trải nghiệm không gian thư giãn với hồ cá Koi tuyệt đẹp tại Café Koi, nơi bạn có thể thưởng thức cà phê và ngắm nhìn những chú cá Koi bơi lội trong không gian yên bình.<br>- Chúng tôi cung cấp đa dạng các loại đồ uống: cà phê, trà, sinh tố và bánh ngọt trong không gian thiên nhiên xanh mát.<br>- Đây là địa điểm lý tưởng để gặp gỡ bạn bè, họp nhóm hoặc thư giãn sau những giờ làm việc căng thẳng.<br>- Với dịch vụ tận tình và không gian thoáng đãng, Café Koi mang đến trải nghiệm độc đáo và thư thái cho quý khách.</p> 
<p style="text-align: center;"><img src="https://mia.vn/media/uploads/blog-du-lich/coffe-cay-loc-vung-1704809014.jpg" alt="Café Koi - Thư giãn cùng cá Koi"></p> 
<p style="text-align: center;">Địa chỉ: 123 Đường Bình An, Quận Thủ Đức, TP.HCM<br>Tel: 0933.549.011<br>E-mail: cafekoi@gmail.com<br>Website: https://www.cafekoi.com</p>', N'nhan', N'Thủy', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD723', N'YOKO KOI FARM - NÔNG TRẠI CÁ KOI NHẬT BẢN TẠI VIỆT NAM', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/pexels-quang-nguyen-vinh-222549-2131828.jpg?alt=media&token=09c961ea-1b40-43e4-8bee-b3286e7ff148', N'<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-4" class="markdown-section" style="text-align: center;" data-markdown-raw="
🌟 YOKO KOI FARM - THI&Ecirc;N ĐƯỜNG C&Aacute; KOI NHẬT BẢN TẠI VIỆT NAM 🌟" data-section-index="4">YOKO KOI FARM - THI&Ecirc;N ĐƯỜNG C&Aacute; KOI NHẬT BẢN TẠI VIỆT NAM&nbsp;</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-6" class="markdown-section" style="text-align: center;" data-markdown-raw="
Bạn đang t&igrave;m kiếm một địa chỉ uy t&iacute;n để sở hữu những ch&uacute; c&aacute; Koi đẳng cấp? H&atilde;y đến với YoKo Koi Farm - đơn vị ti&ecirc;n phong trong lĩnh vực nhập khẩu v&agrave; ph&acirc;n phối c&aacute; Koi ch&iacute;nh h&atilde;ng tại Việt Nam!" data-section-index="6"></p>
<div class="markdown-section-toolbar">
<div class="markdown-section-toolbar-internal">
<div class="markdown-section-toolbar-item dark">&nbsp;</div>
<div class="markdown-section-toolbar-item markdown-section-toolbar-copy dark"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://yokokoi.com/wp-content/uploads/2021/12/ho-koi-dep-2.jpg" width="1000" height="750"></div>
</div>
</div>
<p>Bạn đang t&igrave;m kiếm một địa chỉ uy t&iacute;n để sở hữu những ch&uacute; c&aacute; Koi đẳng cấp? H&atilde;y đến với YoKo Koi Farm - đơn vị ti&ecirc;n phong trong lĩnh vực nhập khẩu v&agrave; ph&acirc;n phối c&aacute; Koi ch&iacute;nh h&atilde;ng tại Việt Nam!</p>
<p>&nbsp;</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-8" class="markdown-section" style="text-align: center;" data-markdown-raw="
💎 TẠI SAO CHỌN YOKO KOI FARM?" data-section-index="8"></p>
<div class="markdown-section-toolbar">
<div>
<div class="markdown-section-toolbar-internal">
<div class="markdown-section-toolbar-item dark">&nbsp;</div>
<div class="markdown-section-toolbar-item markdown-section-toolbar-copy dark">&nbsp;</div>
</div>
</div>
</div>
<p style="text-align: center;">TẠI SAO CHỌN YOKO KOI FARM?</p>
<p>&nbsp;</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-10" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Đa dạng d&ograve;ng c&aacute; Koi: Từ Koi Nhật thuần chủng đến Koi F1 v&agrave; Koi Việt, đ&aacute;p ứng mọi nhu cầu v&agrave; ng&acirc;n s&aacute;ch" data-section-index="10">&bull; Đa dạng d&ograve;ng c&aacute; Koi: Từ Koi Nhật thuần chủng đến Koi F1 v&agrave; Koi Việt, đ&aacute;p ứng mọi nhu cầu v&agrave; ng&acirc;n s&aacute;ch</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-11" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Showroom rộng r&atilde;i tại H&agrave; Nội với 2 cơ sở tại Đ&ocirc;ng Dư, Gia L&acirc;m" data-section-index="11">&bull; Showroom rộng r&atilde;i tại H&agrave; Nội với 2 cơ sở tại Đ&ocirc;ng Dư, Gia L&acirc;m</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-12" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Dịch vụ trọn g&oacute;i: Từ tư vấn, thiết kế đến thi c&ocirc;ng hồ Koi chuy&ecirc;n nghiệp" data-section-index="12">&bull; Dịch vụ trọn g&oacute;i: Từ tư vấn, thiết kế đến thi c&ocirc;ng hồ Koi chuy&ecirc;n nghiệp</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-13" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Đội ngũ chuy&ecirc;n gia gi&agrave;u kinh nghiệm, tận t&acirc;m" data-section-index="13">&bull; Đội ngũ chuy&ecirc;n gia gi&agrave;u kinh nghiệm, tận t&acirc;m</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-15" class="markdown-section" style="text-align: center;" data-markdown-raw="
🛍️ SẢN PHẨM &amp; DỊCH VỤ TO&Agrave;N DIỆN:" data-section-index="15"></p>
<div class="markdown-section-toolbar">
<div>
<div class="markdown-section-toolbar-internal">
<div class="markdown-section-toolbar-item dark">&nbsp;</div>
<div class="markdown-section-toolbar-item markdown-section-toolbar-copy dark">&nbsp;</div>
</div>
</div>
</div>
<p style="text-align: center;">SẢN PHẨM &amp; DỊCH VỤ TO&Agrave;N DIỆN:</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-17" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; C&aacute; Koi nhập khẩu ch&iacute;nh h&atilde;ng" data-section-index="17"></p>
<p style="text-align: center;">&bull; C&aacute; Koi nhập khẩu ch&iacute;nh h&atilde;ng</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-18" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Thiết bị hồ Koi cao cấp: m&aacute;y bơm, đ&egrave;n UV, hệ thống lọc" data-section-index="18">&bull; Thiết bị hồ Koi cao cấp: m&aacute;y bơm, đ&egrave;n UV, hệ thống lọc</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-19" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Thức ăn v&agrave; thuốc điều trị chuy&ecirc;n dụng" data-section-index="19">&bull; Thức ăn v&agrave; thuốc điều trị chuy&ecirc;n dụng</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-20" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Phụ kiện chăm s&oacute;c c&aacute; đầy đủ" data-section-index="20">&bull; Phụ kiện chăm s&oacute;c c&aacute; đầy đủ</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-21" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Dịch vụ tư vấn thiết kế v&agrave; thi c&ocirc;ng hồ" data-section-index="21">&bull; Dịch vụ tư vấn thiết kế v&agrave; thi c&ocirc;ng hồ</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-23" class="markdown-section" style="text-align: center;" data-markdown-raw="
💪 CAM KẾT CỦA CH&Uacute;NG T&Ocirc;I:" data-section-index="23"></p>
<div class="markdown-section-toolbar">
<div>
<div class="markdown-section-toolbar-internal">
<div class="markdown-section-toolbar-item dark">&nbsp;</div>
<div class="markdown-section-toolbar-item markdown-section-toolbar-copy dark">&nbsp;</div>
</div>
</div>
</div>
<p style="text-align: center;">CAM KẾT CỦA CH&Uacute;NG T&Ocirc;I:</p>
<p>&nbsp;</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-25" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Sản phẩm ch&iacute;nh h&atilde;ng 100%" data-section-index="25">&bull; Sản phẩm ch&iacute;nh h&atilde;ng 100%</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-26" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Giao h&agrave;ng to&agrave;n quốc nhanh ch&oacute;ng, an to&agrave;n" data-section-index="26">&bull; Giao h&agrave;ng to&agrave;n quốc nhanh ch&oacute;ng, an to&agrave;n</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-27" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Hỗ trợ kỹ thuật 24/7" data-section-index="27">&bull; Hỗ trợ kỹ thuật 24/7</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-28" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Chế độ bảo h&agrave;nh chuy&ecirc;n nghiệp" data-section-index="28">&bull; Chế độ bảo h&agrave;nh chuy&ecirc;n nghiệp</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-29" class="markdown-section" style="text-align: center;" data-markdown-raw="
&bull; Tư vấn miễn ph&iacute; về chăm s&oacute;c v&agrave; phong thủy" data-section-index="29">&bull; Tư vấn miễn ph&iacute; về chăm s&oacute;c v&agrave; phong thủy</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-31" class="markdown-section" style="text-align: center;" data-markdown-raw="
📞 LI&Ecirc;N HỆ NGAY:" data-section-index="31"></p>
<div class="markdown-section-toolbar">
<div>
<div class="markdown-section-toolbar-internal">
<div class="markdown-section-toolbar-item dark">&nbsp;</div>
<div class="markdown-section-toolbar-item markdown-section-toolbar-copy dark">&nbsp;</div>
</div>
</div>
</div>
<p style="text-align: center;">LI&Ecirc;N HỆ NGAY:</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-32" class="markdown-section" style="text-align: center;" data-markdown-raw="
- Hotline: 0964 66 33 99" data-section-index="32"></p>
<p style="text-align: center;">Hotline: 0964 66 33 99</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-33" class="markdown-section" style="text-align: center;" data-markdown-raw="
- Website: www.yokokoi.com" data-section-index="33">Website: www.yokokoi.com</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-34" class="markdown-section" style="text-align: center;" data-markdown-raw="
- Showroom 1 &amp; 2: Th&ocirc;n 1 &amp; 2, Đ&ocirc;ng Dư, Gia L&acirc;m, H&agrave; Nội" data-section-index="34">Showroom 1 &amp; 2: Th&ocirc;n 1 &amp; 2, Đ&ocirc;ng Dư, Gia L&acirc;m, H&agrave; Nội</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-36" class="markdown-section" style="text-align: center;" data-markdown-raw="
Đến với YoKo Koi Farm, bạn kh&ocirc;ng chỉ mua một ch&uacute; c&aacute; Koi - bạn đang đầu tư v&agrave;o một t&aacute;c phẩm nghệ thuật sống, một biểu tượng của sự thịnh vượng v&agrave; may mắn cho gia đ&igrave;nh!" data-section-index="36">Đến với YoKo Koi Farm, bạn kh&ocirc;ng chỉ mua một ch&uacute; c&aacute; Koi - bạn đang đầu tư v&agrave;o một t&aacute;c phẩm nghệ thuật sống, một biểu tượng của sự thịnh vượng v&agrave; may mắn cho gia đ&igrave;nh!</p>
<p id="markdown-section-0735ee38-2e9f-4b7e-a71a-41dbdc25ba15-38" class="markdown-section" style="text-align: center;" data-markdown-raw="
#YokoKoiFarm #CaKoi #KoiNhat #HoKoi #PhongThuy" data-section-index="38">#YokoKoiFarm #CaKoi #KoiNhat #HoKoi #PhongThuy</p>', N'khoa', N'Thủy', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD759', N'Thiết kế và thi công hồ cá Koi Mini', N'https://vn1.vdrive.vn/koixinh.com/2023/01/Thiet-ke-va-thi-cong-ho-ca-Koi-Mini-%E2%80%93-Lao-Cai-Thai-Binh-Ha-Noi-%E2%80%93-Goi-0976870033-1.jpg', N'<h2 id="ftoc-heading-1" class="ftwp-heading">Thiết kế hồ c&aacute; Koi mini ngo&agrave;i trời</h2>
<p>Hồ c&aacute; Koi mini ngo&agrave;i trời l&agrave; hồ c&aacute; ph&ugrave; hợp với c&aacute;c căn hộ nhỏ ở mặt đất hoặc biệt thự mini c&oacute; kh&ocirc;ng gian s&acirc;n vườn vừa phải. K&iacute;ch thước th&ocirc;ng thường cho một hồ Koi mini ngo&agrave;i trời l&agrave; khoảng 2,5m*1,5m trở l&ecirc;n l&agrave; ph&ugrave; hợp.</p>
<p>Hồ Koi mini ch&iacute;nh l&agrave; một m&ocirc; h&igrave;nh thu nhỏ của hồ Koi b&igrave;nh thường nhưng c&oacute; k&iacute;ch thước nhỏ hơn chứ kh&ocirc;ng thể thay đổi về c&aacute;c yếu tố kỹ thuật. Ch&uacute;ng t&ocirc;i sẽ dựa v&agrave;o kh&ocirc;ng gian cụ thể của từng ng&ocirc;i nh&agrave; để c&oacute; thể thiết kế, trang tr&iacute;, v&agrave; sắp xếp mọi thứ h&agrave;i h&ograve;a nhất c&oacute; thể. Chiều s&acirc;u của hồ v&agrave;o khoảng 60 đến 80 cm l&agrave; hợp l&yacute;. Với k&iacute;ch thước v&agrave; độ s&acirc;u như n&agrave;y th&igrave; bạn c&oacute; thể x&acirc;y dựng hồ c&aacute; Koi ở nhiều vị tr&iacute; m&agrave; bạn muốn.</p>
<p>Với đội ngũ nh&acirc;n vi&ecirc;n c&oacute; kinh nghiệm trong lĩnh vực thiết kế v&agrave; thi c&ocirc;ng hồ c&aacute; Koi ngo&agrave;i trời, ch&uacute;ng t&ocirc;i đảm bảo c&aacute;c thiết kế sẽ đạt chuẩn phong thủy cho kh&aacute;ch h&agrave;ng v&agrave; mang lại kh&ocirc;ng gian xanh, ấm c&uacute;ng v&agrave; thư gi&atilde;n cho ng&ocirc;i nh&agrave;.</p>
<h3 id="ftoc-heading-2" class="ftwp-heading">Ti&ecirc;u chuẩn thiết kế v&agrave; thi c&ocirc;ng</h3>
<p>Khi thiết kế v&agrave; thi c&ocirc;ng ch&uacute;ng t&ocirc;i lu&ocirc;n đảm bảo về chất lượng, h&igrave;nh d&aacute;ng ph&ugrave; hợp, h&agrave;i h&ograve;a với ng&ocirc;i nh&agrave; m&agrave; kh&ocirc;ng mất đi vẻ những chuẩn mực về phong thủy.</p>
<h3 id="ftoc-heading-3" class="ftwp-heading">Lựa chọn vị tr&iacute;, k&iacute;ch thước v&agrave; h&igrave;nh d&aacute;ng</h3>
<p>Trước khi tiến h&agrave;nh thiết kế, nh&acirc;n vi&ecirc;n của ch&uacute;ng t&ocirc;i sẽ đến tận nơi để khảo s&aacute;t v&agrave; tư vấn cho kh&aacute;ch h&agrave;ng&nbsp; n&ecirc;n lựa chọn k&iacute;ch thước, vị tr&iacute; đặt hồ như thế n&agrave;o cho ph&ugrave; hợp.</p>
<div>
<p><img class="aligncenter lazy-load-active" style="display: block; margin-left: auto; margin-right: auto;" title="Thiết Kế V&agrave; Thi C&ocirc;ng Hồ C&aacute; Koi Mini &ndash; L&agrave;o Cai, Th&aacute;i B&igrave;nh, H&agrave; Nội &ndash; Gọi 0976870033" src="https://hocakoitrungduc.com/upload/userfiles/images/thiet-ke-ho-ca-koi-mini-ngoai-troi.jpg" alt="vị tr&iacute; thiết kế hồ c&aacute; koi mini ngo&agrave;i trời" data-src="https://hocakoitrungduc.com/upload/userfiles/images/thiet-ke-ho-ca-koi-mini-ngoai-troi.jpg"></p>
<p><img class="aligncenter lazy-load-active" style="display: block; margin-left: auto; margin-right: auto;" title="Thiết Kế V&agrave; Thi C&ocirc;ng Hồ C&aacute; Koi Mini &ndash; L&agrave;o Cai, Th&aacute;i B&igrave;nh, H&agrave; Nội &ndash; Gọi 0976870033" src="https://hocakoitrungduc.com/upload/userfiles/images/vi-tri-thiet-ke-ho-ca-koi-mini-ngoai-troi.jpg" alt="vị tr&iacute; hồ c&aacute; koi mini ngo&agrave;i trời" data-src="https://hocakoitrungduc.com/upload/userfiles/images/vi-tri-thiet-ke-ho-ca-koi-mini-ngoai-troi.jpg"><br><strong>H&igrave;nh ảnh k&iacute;ch thước hồ c&aacute; mini ngo&agrave;i trời để qu&yacute; kh&aacute;ch tham khảo</strong></p>
<p>H&igrave;nh d&aacute;ng&nbsp;để hợp cho ng&ocirc;i nh&agrave; của bạn v&agrave; phong thủy nhất l&agrave; những&nbsp;h&igrave;nh b&aacute;n nguyệt, h&igrave;nh bầu dục, h&igrave;nh elip, h&igrave;nh cung.. những h&igrave;nh dạng như vậy gi&uacute;p gia chủ &ocirc;m trọn t&agrave;i lộc.</p>
<p><img class="aligncenter lazy-load-active" style="display: block; margin-left: auto; margin-right: auto;" title="Thiết Kế V&agrave; Thi C&ocirc;ng Hồ C&aacute; Koi Mini &ndash; L&agrave;o Cai, Th&aacute;i B&igrave;nh, H&agrave; Nội &ndash; Gọi 0976870033" src="https://hocakoitrungduc.com/upload/userfiles/images/Hinh-dang-mau-ho-ca-koi(1).jpg" alt="h&igrave;nh d&aacute;ng để thiết kế hồ c&aacute; koi mini ngo&agrave;i trời" data-src="https://hocakoitrungduc.com/upload/userfiles/images/Hinh-dang-mau-ho-ca-koi(1).jpg"></p>
</div>', N'khoa', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD762', N'Quán cà phê cá Koi tuyệt đẹp', N'https://sanvuonsaigon.vn/wp-content/uploads/2022/08/quan-cafe-ca-koi-thu-duc-koi-lands-coffee-3.jpg', N'<p>Chào mừng bạn đến với quán cà phê cá Koi tuyệt đẹp, nơi mà hương vị cà phê thơm ngon kết hợp với không gian thư giãn gần gũi với thiên nhiên sẽ mang đến cho bạn những trải nghiệm tuyệt vời nhất.&nbsp;<br>Chúng tôi tự hào mang đến cho bạn:</p>
<ul>
    <li>Cà phê nguyên chất, được pha chế từ những hạt cà phê tuyển chọn, đảm bảo mang đến cho bạn những ly cà phê đậm đà và tinh tế.</li>
    <li>Không gian yên tĩnh, dễ chịu, lý tưởng cho những buổi họp mặt bạn bè, làm việc hay chỉ đơn giản là tìm một góc riêng để thưởng thức cà phê.</li>
    <li>Hồ cá Koi sống động và tuyệt đẹp, giúp bạn cảm thấy thư thái và bình yên trong từng giây phút.</li>
    <li>Đặc sản bánh ngọt và đồ uống hấp dẫn, từ bánh mì nướng giòn tan đến các loại trà thơm, đảm bảo làm hài lòng khẩu vị của bạn.</li>
    <li>Các sự kiện thú vị và chương trình khuyến mãi định kỳ, mang đến những trải nghiệm mới mẻ và bất ngờ cho khách hàng.</li>
</ul>
<p>Hãy đến và trải nghiệm một buổi chiều tuyệt vời tại quán cà phê cá Koi của chúng tôi, nơi mà mỗi giọt cà phê đều được chăm chút, mỗi khoảnh khắc đều đáng giá! Chúng tôi rất mong được chào đón bạn.</p>
<p><img src="https://phongcachmoc.vn/upload/images/tin-tuc/thiet-ke-cafe-ca-koi/thiet-ke-quan-cafe-ca-koi%20(5).jpg" alt="Quán cà phê cá Koi tuyệt đẹp"><br>Quán cà phê cá Koi&nbsp;<br>Điện thoại/Zalo: 0909902061&nbsp;<br>Địa chỉ: Số 123, Đường Koi, Phường Yên Bình, Quận 1, TP HCM&nbsp;<br>Website: https://cafe-koi.vn</p>', N'nhan', N'Thủy', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD793', N'Hợp tác xã Sản xuất và thương mại Tân Khánh thành công với mô hình nuôi cá Koi', N'https://baonamdinh.vn/file/e7837c02816d130b0181a995d7ad7e96/102024/untitled-1_20241015074751.jpg', N'<p style="text-align: center;"><em><strong>Hợp t&aacute;c x&atilde; Sản xuất v&agrave; thương mại T&acirc;n Kh&aacute;nh ở th&ocirc;n Phong Cốc, x&atilde; Minh T&acirc;n (Vụ Bản) th&agrave;nh lập năm 2021 với 16 th&agrave;nh vi&ecirc;n chuy&ecirc;n sản xuất, kinh doanh c&aacute; Koi. Với quy m&ocirc; nu&ocirc;i hơn 30ha, mỗi năm HTX cung ứng ra thị trường tr&ecirc;n 100 tấn c&aacute;. Vừa qua, HTX Sản xuất v&agrave; thương mại T&acirc;n Kh&aacute;nh l&agrave; 1 trong 63 HTX được Trung ương Hội N&ocirc;ng d&acirc;n Việt Nam c&ocirc;ng nhận l&agrave; HTX x&atilde; ti&ecirc;u biểu to&agrave;n quốc năm 2024.</strong></em></p>
<div style="text-align: center;">
<table class="image center" align="center">
<tbody>
<tr>
<td><em><img src="https://baonamdinh.vn/file/e7837c02816d130b0181a995d7ad7e96/102024/untitled-1_20241015074751.jpg" alt="Mỗi năm Hợp t&aacute;c x&atilde; sản xuất v&agrave; thương mại T&acirc;n Kh&aacute;nh, x&atilde; Minh T&acirc;n xuất b&aacute;n ra thị trường tr&ecirc;n 100 tấn c&aacute; ch&eacute;p Koi."></em></td>
</tr>
<tr>
<td class="desc"><em>Mỗi năm Hợp t&aacute;c x&atilde; sản xuất v&agrave; thương mại T&acirc;n Kh&aacute;nh, x&atilde; Minh T&acirc;n xuất b&aacute;n ra thị trường tr&ecirc;n 100 tấn c&aacute; ch&eacute;p Koi.</em></td>
</tr>
</tbody>
</table>
</div>
<p style="text-align: center;">Về T&acirc;n Kh&aacute;nh, nhắc đến &ldquo;Vua c&aacute; Koi&rdquo;, người d&acirc;n địa phương kh&ocirc;ng ai l&agrave; kh&ocirc;ng biết anh Phạm Đức Thuần, Chủ tịch HĐQT ki&ecirc;m Gi&aacute;m đốc HTX Sản xuất v&agrave; thương mại T&acirc;n Kh&aacute;nh. Lo&agrave;i thủy sản được giới thiệu l&agrave; vật nu&ocirc;i "qu&yacute; tộc" n&agrave;y l&agrave; loại c&aacute; cảnh xuất xứ từ Nhật Bản, hiện được thị trường săn đ&oacute;n. Kh&ocirc;ng chỉ l&agrave; một trong những người ti&ecirc;n phong đưa con c&aacute; ch&eacute;p Koi về bổ sung v&agrave;o danh s&aacute;ch con nu&ocirc;i thủy sản c&oacute; gi&aacute; trị, anh Thuần c&ograve;n l&agrave; &ldquo;đầu t&agrave;u&rdquo; k&eacute;o ng&agrave;nh nu&ocirc;i c&aacute; Koi ở địa phương ph&aacute;t triển vững chắc, đem lại lợi &iacute;ch kinh tế lớn cho người nu&ocirc;i. HTX kh&ocirc;ng chỉ sản xuất c&aacute; thương phẩm m&agrave; c&ograve;n ương nu&ocirc;i th&agrave;nh c&ocirc;ng c&aacute; giống cung cấp cho thị trường; li&ecirc;n kết với hơn 100 đại l&yacute; chuy&ecirc;n mua b&aacute;n c&aacute; cảnh tr&ecirc;n khắp cả nước để bao ti&ecirc;u sản phẩm cho c&aacute;c th&agrave;nh vi&ecirc;n. Hiện anh đang sở hữu một trang trại nu&ocirc;i c&aacute; Koi rộng 7,2ha được quy hoạch khoa học với hệ thống c&aacute;c ao nu&ocirc;i li&ecirc;n kết chặt chẽ với nhau c&ugrave;ng hệ thống bể ương, nu&ocirc;i dưỡng đầy đủ m&aacute;y sủi &ocirc;-xy, c&oacute; m&aacute;i che nắng, che mưa&hellip;&nbsp;</p>', N'huy', N'Hỏa', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD820', N'Bán cá Koi Nhật Bản chất lượng cao tại Yên Bái, Tuyên Quang, Cao Bằng, Bắc Kạn', N'https://nonbo.net.vn/wp-content/uploads/2021/01/ca-koi-cua-trung-quoc-va-nhat-ban-pho-bien-tren-thi-truong-hien-nay.jpg', N'<h2 class="detail-sapo" style="text-align: center;" data-role="sapo">Cá Koi Nhật Bản - Biểu tượng của sự may mắn và thịnh vượng. Chúng tôi chuyên cung cấp cá Koi nhập khẩu trực tiếp từ Nhật Bản với chất lượng đảm bảo, kích thước đa dạng, phù hợp với mọi nhu cầu.</h2> 
<p style="text-align: center;"><img src="https://nonbo.net.vn/wp-content/uploads/2021/01/ca-koi-cua-trung-quoc-va-nhat-ban-pho-bien-tren-thi-truong-hien-nay.jpg" alt="Cá Koi Nhật Bản chất lượng cao"></p> 
<p style="text-align: center;">Cá Koi của chúng tôi được nuôi dưỡng theo tiêu chuẩn Nhật Bản, với màu sắc đa dạng, sức sống mạnh mẽ và không mang mầm bệnh. Đội ngũ chuyên gia sẽ hỗ trợ tư vấn chăm sóc hồ cá Koi tận tình.</p> 
<p style="text-align: center;">Chúng tôi cam kết:</p> 
<ul> 
<li>Nhập khẩu cá Koi trực tiếp từ các trại cá uy tín ở Nhật Bản</li> 
<li>Cung cấp dịch vụ bảo hành sức khỏe cá trong 1 tháng</li> 
<li>Tư vấn miễn phí về thiết kế hồ cá và cách chăm sóc</li> 
<li>Vận chuyển toàn quốc, đảm bảo an toàn tuyệt đối cho cá Koi</li> 
</ul> 
<p style="text-align: center;">Liên hệ ngay để sở hữu những chú cá Koi đẳng cấp, mang lại may mắn và tài lộc cho gia đình bạn!</p>', N'huy', N'Mộc', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD878', N'Cách trang trí hồ cá đẹp - tạo không gian đậm chất nghệ thuật', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/pond.jpg?alt=media&token=dc08aabc-72bc-4045-89d0-a63c6ce9c364', N'<h2 id="nhung-loi-ich-ma-ho-ca-mang-lai-cho-nguoi-so-huu" dir="ltr" style="text-align: left;" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">1.&nbsp; Những lợi &iacute;ch m&agrave; hồ c&aacute; mang lại cho người sở hữu</span></h2>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Hồ c&aacute; l&agrave; kiểu thiết kế mang lại rất nhiều lợi &iacute;ch đến người sở hữu ch&uacute;ng. Trước ti&ecirc;n, ch&uacute;ng ta cần phải kể tới đ&oacute; ch&iacute;nh l&agrave; lợi &iacute;ch về mặt thẩm mỹ. Một hồ c&aacute; nho nhỏ đem lại n&eacute;t đẹp tự nhi&ecirc;n, gi&uacute;p cho kh&ocirc;ng gian trở n&ecirc;n đẹp v&agrave; c&oacute; t&iacute;nh nghệ thuật.&nbsp;</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Hơn thế, với những ng&ocirc;i nh&agrave; c&oacute; lối kiến tr&uacute;c mang phong c&aacute;ch kh&ocirc;ng gian xanh, hồ c&aacute; sẽ l&agrave; một thứ kh&ocirc;ng thể thiếu. Thiết kế n&agrave;y gi&uacute;p cho kh&ocirc;ng gian trở n&ecirc;n tho&aacute;ng m&aacute;t, h&agrave;i h&ograve;a với thi&ecirc;n nhi&ecirc;n hơn.&nbsp;</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Th&ecirc;m nữa, nu&ocirc;i c&aacute; cảnh đ&oacute;ng một vai tr&ograve; kh&aacute; lớn trong việc n&acirc;ng cao sức khỏe về thể chất v&agrave; tinh thần cho những th&agrave;nh vi&ecirc;n trong gia đ&igrave;nh. Bởi lẽ, khi c&oacute; hồ c&aacute; trong nh&agrave;, hơi nước v&agrave; c&acirc;y thủy sinh trong hồ g&oacute;p phần cung cấp oxy cho kh&ocirc;ng gian, hỗ trợ tăng cường sức khỏe. Hơn thế, việc một người chăm s&oacute;c cho hồ c&aacute;, cho c&aacute; ăn c&oacute; thể gi&uacute;p cho tinh thần thoải m&aacute;i hơn. Dần dần, đ&acirc;y trở th&agrave;nh một niềm vui đặc biệt của họ.&nbsp;</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Ngo&agrave;i ra, đặt hồ c&aacute; trong nh&agrave; cũng mang &yacute; nghĩa phong thủy rất đặc biệt. Người ta quan niệm rằng hồ c&aacute; thủy sinh l&agrave; vật tụ t&agrave;i, ph&aacute;t t&agrave;i cho gia chủ. Ch&uacute;ng c&oacute; &yacute; nghĩa mang lại t&agrave;i lộc v&agrave; may mắn.</span><br>&nbsp;</p>
<p dir="ltr" style="text-align: left;"><img src="https://hatalandscape.com/public/uploads/files/ao-ho-nhan-tao-trong-vuon-108068.jpg" alt="Hồ c&aacute; s&acirc;n vườn"></p>
<h2 id="trang-tri-ho-ca-gom-nhung-phu-kien-nao" dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">2.&nbsp; Trang tr&iacute; hồ c&aacute; gồm những phụ kiện n&agrave;o?</span></h2>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Một hồ c&aacute; đẹp cần phải được trang tr&iacute; th&ecirc;m nhiều phụ kiện. Ch&uacute;ng sẽ l&agrave;m hồ c&aacute; trở n&ecirc;n sinh động v&agrave; thu h&uacute;t hơn. Đặc biệt, những phụ kiện n&agrave;y rất quan trọng đối với sự sinh trưởng v&agrave; ph&aacute;t triển của c&aacute; trong hồ. Ch&uacute;ng sẽ nơi tr&uacute; ngụ m&agrave; l&agrave; th&agrave;nh phần gi&uacute;p ti&ecirc;u thụ những thức ăn dư thừa của c&aacute;. Dưới đ&acirc;y l&agrave; những phụ kiện phổ biến nhất m&agrave; ch&uacute;ng ta c&oacute; thể sử dụng:</span></p>
<ul style="text-align: left;">
<li dir="ltr">
<p dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Thiết bị lọc nước v&agrave; cung cấp oxy</span></p>
</li>
<li dir="ltr">
<p dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">C&aacute;c loại c&acirc;y thủy sinh như rong, r&ecirc;u, c&acirc;y sống dưới nước</span></p>
</li>
<li dir="ltr">
<p dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Đ&egrave;n thủy sinh l&agrave;m tăng m&agrave;u sắc cho hồ c&aacute;</span></p>
</li>
<li dir="ltr">
<p dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Đ&aacute;, sỏi, c&agrave;nh c&acirc;y l&agrave;m nước trong v&agrave; tăng vẻ đẹp cho bể</span></p>
</li>
<li dir="ltr">
<p dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Ph&acirc;n nền thủy sinh</span><br>&nbsp;</p>
<p dir="ltr" role="presentation"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://hatalandscape.com/public/uploads/files/thay-nuoc-ho-ca-949673.jpg" alt="Phụ kiện hồ c&aacute;"></p>
</li>
</ul>
<h2 id="cach-trang-tri-ho-ca-dep" dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">3.&nbsp; C&aacute;ch trang tr&iacute; hồ c&aacute; đẹp</span></h2>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">C&oacute; rất nhiều c&aacute;ch để trang tr&iacute; một hồ c&aacute; đẹp. Điều n&agrave;y c&ograve;n t&ugrave;y thuộc v&agrave;o sở th&iacute;ch v&agrave; thẩm mỹ của mỗi người. Song, bạn c&oacute; thể tham khảo c&aacute;ch thực hiện sau đ&acirc;y. C&oacute; thể n&oacute;i đ&acirc;y l&agrave; quy tr&igrave;nh cơ bản nhất cho việc n&agrave;y.</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Trước ti&ecirc;n, bạn cần c&oacute; cho m&igrave;nh một phong c&aacute;ch ri&ecirc;ng. Nhiều người th&iacute;ch kiểu hồ c&aacute; c&oacute; nhiều m&agrave;u xanh từ c&acirc;y thủy sinh. Nhiều người lại ưa chuộng những &aacute;nh s&aacute;ng long lanh từ những vi&ecirc;n sỏi tạo ra từ đ&aacute;y hồ n&ecirc;n sẽ trang tr&iacute; nhiều sỏi v&agrave; đ&aacute;. Nhiều người lại th&iacute;ch c&oacute; sự h&agrave;i h&ograve;a n&ecirc;n trang tr&iacute; những yếu tố tr&ecirc;n với mật độ vừa phải.&nbsp;</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Tiếp đ&oacute; l&agrave; tiến h&agrave;nh lắp đặt hệ thống lọc nước, hệ thống tạo oxy v&agrave; &aacute;nh s&aacute;ng cho bể c&aacute;. Đảm bảo rằng những sinh vật sống trong bể c&oacute; đủ điều kiện để sinh trưởng v&agrave; ph&aacute;t triển.&nbsp;</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Cuối c&ugrave;ng l&agrave; lựa chọn giống c&aacute;, số lượng c&aacute;, c&aacute;c loại giống c&acirc;y thủy sinh, sỏi đ&aacute; v&agrave; c&agrave;nh c&acirc;y ph&ugrave; hợp để trang tr&iacute; v&agrave;o b&ecirc;n trong hồ. N&ecirc;n sắp xếp xen kẽ những yếu tố tr&ecirc;n để tạo được sự đa dạng v&agrave; c&acirc;n bằng m&agrave;u sắc trong bể.&nbsp;</span><br>&nbsp;</p>
<p dir="ltr" style="text-align: left;"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://hatalandscape.com/public/uploads/files/can-bang-so-luong-ca-trong-ho-993092.jpg" alt="C&aacute;ch trang tr&iacute; hồ c&aacute; đẹp"></p>
<h2 id="nhung-luu-y-khi-trang-tri-ho-ca" dir="ltr" role="presentation"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">4.&nbsp; Những lưu &yacute; khi trang tr&iacute; hồ c&aacute;</span></h2>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Trong qu&aacute; tr&igrave;nh thực hiện, chắc chắn rằng bạn sẽ kh&ocirc;ng tr&aacute;nh khỏi những kh&oacute; khăn v&agrave; rắc rối. Để mọi việc thuận lợi hơn, bể c&aacute; c&oacute; cấu tr&uacute;c đẹp hơn bạn cũng cần ghi nhớ một v&agrave;i lưu &yacute;.</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">Cần c&acirc;n đối lượng c&aacute; v&agrave; số lượng những vật trang tr&iacute; trong bể. Kh&ocirc;ng trang tr&iacute; qu&aacute; nhiều c&acirc;y thủy sinh, l&agrave;m cản trở hoạt động của c&aacute;. Cũng kh&ocirc;ng thể nu&ocirc;i qu&aacute; nhiều c&aacute;, v&igrave; c&oacute; thể khiến ch&uacute;ng phải tranh gi&agrave;nh oxy, l&agrave;m ch&uacute;ng kh&ocirc;ng thể sống v&agrave; ph&aacute;t triển. Hơn thế, cũng kh&ocirc;ng được cho qu&aacute; nhiều sỏi v&agrave; đ&aacute; v&agrave;o trong hồ. Điều n&agrave;y khiến cho hồ bị qu&aacute; tải, trọng lượng nặng sẽ c&oacute; khả năng l&agrave;m hồ c&aacute; bị vỡ.&nbsp;</span></p>
<p style="text-align: left;">&nbsp;</p>
<p dir="ltr" style="text-align: left;"><span id="docs-internal-guid-529d5759-7fff-5f35-fa76-33d6756bbb1b">&Aacute;nh s&aacute;ng trong hồ cũng cần lựa chọn sao ph&ugrave; ph&ugrave; hợp với m&agrave;u sắc của k&iacute;nh. Tr&aacute;nh lựa chọn những m&agrave;u sắc tương phản nhau, l&agrave;m ch&oacute;i mắt người nh&igrave;n. Đặc biệt, cũng cần phải c&acirc;n nhắc vị tr&iacute; đặt bể c&aacute; cũng như c&aacute;c loại c&acirc;y thủy sinh. Ch&uacute;ng phải đ&uacute;ng với quy định trong phong thủy v&agrave; ph&ugrave; hợp với gia chủ.&nbsp;</span><br>&nbsp;</p>
<p dir="ltr"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://hatalandscape.com/public/uploads/files/thac-nuoc-mini-trong-san-vuon-515643.jpg" alt="Lưu &yacute; khi trang tr&iacute; hồ c&aacute;"></p>', N'tin', N'Mộc', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD885', N'Bán cá Koi Nhật Bản nhập khẩu - Cá cảnh cao cấp tại Thủ Đức, TPHCM', N'https://inhat.vn/wp-content/uploads/2021/03/ca-koi-tphcm-9.jpg', N'<h2 class="detail-sapo" style="text-align: center;" data-role="sapo">Cung cấp cá Koi Nhật Bản, biểu tượng may mắn và thịnh vượng, nhập khẩu trực tiếp từ Nhật Bản với đa dạng màu sắc và kích thước.</h2> 
<p style="text-align: center;"><img src="https://cdn-i.vtcnews.vn/resize/th/upload/2024/03/04/cafe-koikichi-19403461.jpg" alt="Cá Koi Nhật Bản chất lượng cao"></p> 
<p style="text-align: center;">Cá Koi của chúng tôi được nuôi dưỡng theo tiêu chuẩn Nhật Bản, với sức sống bền bỉ, không mang mầm bệnh và được kiểm định kỹ lưỡng trước khi đến tay khách hàng.</p> 
<p style="text-align: center;">Chúng tôi cam kết:</p> 
<ul> 
<li>Nhập khẩu trực tiếp từ các trại cá Koi uy tín tại Nhật Bản</li> 
<li>Cung cấp dịch vụ bảo hành sức khỏe cá trong 1 tháng</li> 
<li>Tư vấn thiết kế và bảo trì hồ cá miễn phí</li> 
<li>Vận chuyển an toàn toàn quốc</li> 
</ul> 
<p style="text-align: center;">Liên hệ ngay để sở hữu những chú cá Koi tuyệt đẹp, mang lại tài lộc và may mắn!</p>', N'khoa', N'Thổ', N'Approved')
INSERT [dbo].[Advertisement] ([AdID], [Heading], [Image], [Link], [UserID], [ElementID], [status]) VALUES (N'AD997', N'Cám Cá Koi giảm giá 20% - SALE tưng bừng mừng năm mới 2024', N'https://camcakoi.com//upload/product/cam-ca-koi-sale-tung-bung-mung-2024-2072025205.jpg', N'<h2 class="sapo">Camcakoi.com tung deal hời kh&ocirc;ng thể hấp dẫn hơn cho h&agrave;ng loạt c&aacute;c sản phẩm giảm gi&aacute; đến 30%. Chương tr&igrave;nh khuyến m&atilde;i v&ocirc; c&ugrave;ng đặc biệt mua sắm ngay c&aacute;c sản phẩm với mức gi&aacute; ưu đ&atilde;i chưa từng c&oacute;.</h2>
<div class="noidung">
<p>Lời đầu ti&ecirc;n,&nbsp;<strong><a href="https://camcakoi.com/">C&aacute;m C&aacute; Koi</a></strong>&nbsp;(Camcakoi.com) xin gửi đến Qu&yacute; Kh&aacute;ch H&agrave;ng lời ch&agrave;o tr&acirc;n trọng v&agrave; ch&acirc;n th&agrave;nh, cảm ơn Qu&yacute; Kh&aacute;ch H&agrave;ng đ&atilde; tin d&ugrave;ng c&aacute;c sản phẩm của Camcakoi trong suốt thời gian qua.</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://camcakoi.com//upload/product/cam-ca-koi-sale-tung-bung-mung-2024-2072025205.jpg" alt="Khuyen mai chao mung nam moi 2024"></p>
<p>Chương tr&igrave;nh khuyến m&atilde;i nh&acirc;n dịp tết Gi&aacute;p Th&igrave;n 2024. CamCaKoi.com đặc biệt gửi tới Qu&yacute; kh&aacute;ch h&agrave;ng khuyến m&atilde;i đặc biệt &ldquo;GIẢM&nbsp; GI&Aacute; 20%&rdquo; cho tất cả sản phẩm.&nbsp;</p>
<ul>
<li><em>Giảm gi&aacute;: 20% to&agrave;n bộ sản phẩm (Chương tr&igrave;nh sản phẩm tết 2024)</em></li>
<li><em>Thời gian &aacute;p dụng từ ng&agrave;y 28/12/2023 đến ng&agrave;y 08/01/2024.</em></li>
<li><em>Li&ecirc;n hệ hotline 0877.38.3388 để biết th&ecirc;m th&ocirc;ng tin chi tiết chương tr&igrave;nh.</em></li>
<li><em>Địa chỉ: T&ograve;a CT7A Đường Dương L&acirc;m - Văn Qu&aacute;n - H&agrave; Đ&ocirc;ng - H&agrave; Nội</em></li>
</ul>
<p>CamCaKoi l&agrave; nh&agrave; cung cấp c&aacute;c loại c&aacute;m d&agrave;nh cho c&aacute; koi chất lượng cao được từ c&aacute;c thương hiệu h&agrave;ng đầu trong v&agrave; ngo&agrave;i nước. Với chất lượng v&agrave; gi&aacute; th&agrave;nh v&ocirc; c&ugrave;ng hợp l&yacute;, c&aacute;c sản phẩm bao gồm c&aacute;m King Feed, Kibakoi, Queen Koi Feed, Daily Koi Food... được sản xuất tr&ecirc;n d&acirc;y chuyền c&ocirc;ng nghệ hiện đại từ Nhật Bản, Singapore sẽ gi&uacute;p c&aacute; nh&agrave; bạn ph&aacute;t triển tốt, khỏe mạnh.</p>
<h2>Một số sản phẩm ti&ecirc;u biểu đang được b&aacute;n tại C&aacute;m C&aacute; Koi</h2>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://camcakoi.com/lib/ckfinder/images/king-feed-top-12-loai-cam-ca-koi-hot.jpg" alt="Cam ca koi King Feed 42% dam"></p>
<p><em>Thức ăn d&agrave;nh cho c&aacute; koi - C&aacute;m&nbsp;<a href="https://camcakoi.com/cam-king-feed.html">King Feed</a>&nbsp;42% đạm</em></p>
<p><em><img style="display: block; margin-left: auto; margin-right: auto;" src="https://camcakoi.com/lib/ckfinder/images/queen-feed-top-12-loai-cam-ca-koi-hot.jpg" alt="Cam ca koi queen koi feed"></em></p>
<p style="text-align: center;"><em>C&aacute;m c&aacute; koi&nbsp;<a href="https://camcakoi.com/queen-koi-feed.html">Queen Koi Feed</a>&nbsp;- Chất lượng tốt - Gi&aacute; b&igrave;nh d&acirc;n</em></p>
<p><em><img style="display: block; margin-left: auto; margin-right: auto;" src="https://camcakoi.com/lib/ckfinder/images/kibakoi-loai-cam-ca-koi-hot.jpg" alt="Cam ca koi Kibakoi the he moi"></em></p>
<p style="text-align: center;"><em><a href="https://camcakoi.com/cam-kibakoi/thuc-an-ca-koi-kibakoi-bao-5-kg-2-in-1-tang-truong-tang-mau.html">C&aacute;m c&aacute; koi Kibakoi</a>&nbsp;thế hệ mới 2 in 1</em></p>
</div>', N'huy', N'Hỏa', N'Approved')
GO
INSERT [dbo].[Blog] ([BlogID], [Heading], [Image], [Link], [status]) VALUES (N'BL001', N'Xu hướng thiết kế, thi công hồ cá Koi đơn giản', N'https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-768x576.jpg', N'<p><em>Xu hướng thiết kế, thi c&ocirc;ng hồ c&aacute; Koi đơn giản đang rất được ưa chuộng hiện nay nhờ v&agrave;o việc tiết kiệm&nbsp;<a href="https://hocakoi.vn/chi-phi-thi-cong-ho-ca-koi-chuan-nhat/">chi ph&iacute; thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật</a>&nbsp;vốn kh&ocirc;ng hề rẻ. B&ecirc;n cạnh đ&oacute;, phong c&aacute;ch tối giản v&agrave; hiện đại ng&agrave;y c&agrave;ng được y&ecirc;u th&iacute;ch trong thiết kế cảnh quan s&acirc;n vườn, mang đến t&iacute;nh độc đ&aacute;o cao. H&atilde;y c&ugrave;ng Hocakoi.vn t&igrave;m hiểu xu hướng x&acirc;y dựng hồ c&aacute; ch&eacute;p Nhật mới n&agrave;y trong b&agrave;i viết h&ocirc;m nay nh&eacute;:</em></p>
<h2><span id="Tai_sao_xu_huong_thi_cong_ho_ca_Koi_don_gian_lai_duoc_ua_chuong"><strong>Tại sao xu hướng thi c&ocirc;ng hồ c&aacute; Koi đơn giản lại được ưa chuộng?</strong></span></h2>
<p>Như ở phần đầu ti&ecirc;n của b&agrave;i viết đ&atilde; cho thấy r&otilde; được sự l&ecirc;n ng&ocirc;i của c&aacute;c hồ c&aacute; Koi đơn giản do xu hướng thịnh h&agrave;nh v&agrave; tiết kiệm được chi ph&iacute;. Trước hết, về xu hướng trang tr&iacute; cảnh quan s&acirc;n vườn biệt thự trong những năm gần đ&acirc;y, Hocakoi.vn thấy được rằng, nhu cầu tối giản c&aacute;c hạng mục trang tr&iacute; l&agrave; yếu tố cốt l&otilde;i trong c&aacute;c bạn thiết kế. Giờ đ&acirc;y trong c&aacute;c s&acirc;n vườn cảnh quan, họ kh&ocirc;ng để qu&aacute; nhiều những l&ugrave;m c&acirc;y, bụi cỏ hay tổng hợp nhiều tiểu cảnh trang tr&iacute;. Kh&aacute;ch h&agrave;ng lu&ocirc;n muốn d&agrave;nh một kh&ocirc;ng gian mở, tho&aacute;ng đ&atilde;ng v&agrave; c&oacute; t&iacute;nh thẩm mỹ được c&acirc;n đối h&agrave;i h&ograve;a với tổng thể xung quanh. Nhờ đ&oacute; m&agrave; họ c&oacute; thể c&oacute; th&ecirc;m kh&ocirc;ng gian sinh hoạt giữa khu vườn, s&acirc;n vườn nh&agrave; m&igrave;nh. B&ecirc;n cạnh đ&oacute;, việc đơn giản h&oacute;a cảnh quan cũng gi&uacute;p chủ nh&agrave; c&oacute; thể tiết kiệm c&ocirc;ng sức v&agrave; thời gian để bảo tr&igrave;, bảo dưỡng c&aacute;c tiểu cảnh.</p>
<p><img class="wp-image-1715 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-300x225.jpg" sizes="(max-width: 639px) 100vw, 639px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian.jpg 1024w" alt="Mẫu hồ c&aacute; Koi đơn giản, hiện đại" width="639" height="479" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/thi-cong-ho-ca-koi-don-gian.jpg 1024w"></p>
<p>Tiếp theo, về&nbsp;<a href="https://hocakoi.vn/chi-phi-thi-cong-ho-ca-koi-chuan-nhat/">chi ph&iacute; thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật</a>, c&oacute; thể n&oacute;i, ng&acirc;n s&aacute;ch để x&acirc;y dựng hồ vốn kh&ocirc;ng hề nhỏ. Ngo&agrave;i ra c&ograve;n c&oacute; một loạt c&aacute;c chi ph&iacute; d&agrave;nh cho việc đầu tư c&aacute; Koi, cho bảo dưỡng hồ thường xuy&ecirc;n c&ugrave;ng c&aacute;c vật liệu m&aacute;y m&oacute;c, đ&oacute; l&agrave; chưa kể chi ph&iacute; trang tr&iacute;. Nếu c&oacute; thể tối ưu h&oacute;a trang tr&iacute; hồ c&aacute; Koi cho đơn giản th&igrave; chi ph&iacute; n&agrave;y c&oacute; thể giảm đi đ&aacute;ng kể. B&ecirc;n cạnh đ&oacute;, vốn dĩ hồ c&aacute; Koi đẹp ở việc những ch&uacute; c&aacute; đầy sắc m&agrave;u bơi lội, v&igrave; vậy nếu tiểu cảnh đơn giản sẽ l&agrave;m nổi bật vẻ đẹp tự nhi&ecirc;n của hồ. Kh&ocirc;ng chỉ vậy, với một hồ c&aacute; Koi đơn giản, bạn cũng dễ d&agrave;ng vệ sinh, chăm s&oacute;c hơn.</p>
<h2><span id="Nhung_dieu_can_luu_y_khi_xay_ho_ca_Koi_don_gian"><strong>Những điều cần lưu &yacute; khi x&acirc;y hồ c&aacute; Koi đơn giản</strong></span></h2>
<h3><span id="Khong_toi_gian_cac_thiet_bi_quan_trong_va_he_thong_loc"><em>Kh&ocirc;ng tối giản c&aacute;c thiết bị quan trọng v&agrave; hệ thống lọc</em></span></h3>
<p>Mặc d&ugrave; việc x&acirc;y hồ c&aacute; Koi đơn giản l&agrave; điều n&ecirc;n l&agrave;m, tuy nhi&ecirc;n kh&ocirc;ng phải chỗ n&agrave;o, hạng mục n&agrave;o cũng c&oacute; thể t&ugrave;y tiện cắt bớt, đặc biệt l&agrave; c&aacute;c thiết bị cần thiết v&agrave; hệ thống lọc cho hồ c&aacute; Koi. Việc duy tr&igrave; c&aacute;c thiết bị quan trọng trong vận h&agrave;nh hồ c&aacute; Koi như bơm nước, ống nước, bộ sục kh&iacute; oxy, hệ thống gi&agrave;n lọc mưa hay trống lọc&hellip;l&agrave; điều chắc chắn bạn cần đảm bảo để hoạt động của hồ được b&igrave;nh thường. Nếu bạn muốn tiết kiệm, tối ưu h&oacute;a chi ph&iacute; cho c&aacute;c thiết bị, bộ phận n&agrave;y th&igrave; phải lựa chọn sản phẩm đ&uacute;ng c&ocirc;ng suất với hồ v&agrave; thiết kế bộ lọc đ&aacute;p ứng đủ nhu cầu của hồ ch&iacute;nh thay v&igrave; sử dụng những thiết bị kh&ocirc;ng ph&ugrave; hợp.</p>
<p>Ngo&agrave;i ra bạn c&oacute; thể c&acirc;n nhắc c&oacute; hay kh&ocirc;ng sử dụng c&aacute;c thiết bị như m&aacute;y sưởi, đ&egrave;n UV diệt tảo&hellip;để thay bằng c&aacute;c giải ph&aacute;p kh&aacute;c c&oacute; chi ph&iacute; thấp hơn.</p>
<div>&nbsp;</div>
<h3><span id="Ho_ca_Koi_don_gian_o_cac_canh_quan_nhung_van_phai_co_tinh_tham_my"><em>Hồ c&aacute; Koi đơn giản ở c&aacute;c cảnh quan nhưng vẫn phải c&oacute; t&iacute;nh thẩm mỹ</em></span></h3>
<p><img class="wp-image-1712 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-300x225.jpg" sizes="(max-width: 632px) 100vw, 632px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian.jpg 1600w" alt="Hồ c&aacute; Koi đơn giản trong s&acirc;n vườn" width="632" height="474" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/ho-ca-koi-don-gian.jpg 1600w"></p>
<p>Khi nhắc đến việc x&acirc;y dựng hồ c&aacute; ch&eacute;p Nhật đơn giản th&igrave; chắc hẳn bạn sẽ nghĩ ngay đến việc lược bỏ bớt c&aacute;c hạng mục trang tr&iacute; xung quanh. Điều n&agrave;y l&agrave; đ&uacute;ng tuy nhi&ecirc;n, việc tối ưu h&oacute;a cảnh quan trang tr&iacute; cho hồ c&aacute; Koi n&ecirc;n được c&acirc;n nhắc sao cho thể hiện được phong c&aacute;ch, n&eacute;t độc đ&aacute;o ri&ecirc;ng m&agrave; kh&ocirc;ng bị qu&aacute; đơn điệu, kh&ocirc;ng c&oacute; điểm nhấn. Trang tr&iacute; c&aacute;c tiểu cảnh n&ecirc;n được sắp xếp theo phong c&aacute;ch, h&agrave;i h&ograve;a với kh&ocirc;ng gian chung chứ kh&ocirc;ng n&ecirc;n chỉ đặt một v&agrave;i chậu hoa, một v&agrave;i c&acirc;y cảnh để đơn giản h&oacute;a h&igrave;nh thức nhưng lại kh&ocirc;ng mang đến hiệu ứng thị gi&aacute;c tốt. Điều n&agrave;y cần phải c&oacute; được sự tư vấn từ c&aacute;c chuy&ecirc;n gia d&agrave;y dạn kinh nghiệm, trong đ&oacute; c&oacute; đội ngũ kiến tr&uacute;c sư của Hocakoi.vn lu&ocirc;n sẵn s&agrave;ng tư vấn thiết kế hồ c&aacute; Koi chuẩn Nhật.</p>
<h3><span id="Goi_dich_vu_thi_cong_ho_ca_Koi_Can_ban_cua_Hocakoivn"><em>G&oacute;i dịch vụ thi c&ocirc;ng hồ c&aacute; Koi Căn bản của Hocakoi.vn</em></span></h3>
<p>Hiện nay Hocakoi.vn đang triển khai dịch vụ thi c&ocirc;ng hồ c&aacute; Koi Nhật trọn g&oacute;i với g&oacute;i dịch vụ Căn Bản (Basic). Trong g&oacute;i dịch vụ n&agrave;y, bạn sẽ được trải nghiệm to&agrave;n bộ qu&aacute; tr&igrave;nh tư vấn, thiết kế, thi c&ocirc;ng chất lượng theo ti&ecirc;u chuẩn Nhật Bản, được thực hiện bởi nh&acirc;n sự của Hocakoi.vn. G&oacute;i dịch vụ Căn bản gi&uacute;p bạn tiết kiệm chi ph&iacute; với những c&ocirc;ng tr&igrave;nh hồ c&aacute; Koi cỡ nhỏ cho đến trung b&igrave;nh trong c&aacute;c ng&ocirc;i nh&agrave; c&oacute; diện t&iacute;ch s&acirc;n vườn kh&ocirc;ng qu&aacute; lớn hoặc muốn x&acirc;y dựng một tiểu cảnh hồ Koi đơn giản theo xu hướng. G&oacute;i dịch vụ Căn bản n&agrave;y sẽ đảm bảo mức&nbsp;<a href="https://hocakoi.vn/chi-phi-thi-cong-ho-ca-koi-chuan-nhat/">chi ph&iacute; thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật</a> c&acirc;n đối với ng&acirc;n s&aacute;ch của bạn. Trong g&oacute;i dịch vụ đ&atilde; bao gồm c&aacute;c hạng mục cơ bản nhất của một tiểu cảnh hồ c&aacute; Koi như ho&agrave;n thiện hồ ch&iacute;nh v&agrave; bể lọc, c&aacute;c tiểu cảnh trang tr&iacute; độc đ&aacute;o như k&egrave; đ&aacute; cuội v&acirc;n m&acirc;y 1 lớp, ghềnh th&aacute;c đ&aacute; cổ thạch &ndash; Tuyết sơn hay c&aacute;c loại hoa v&agrave; bụi c&acirc;y cơ bản.</p>', N'Published')
INSERT [dbo].[Blog] ([BlogID], [Heading], [Image], [Link], [status]) VALUES (N'BL002', N'Top 10 Mẫu hồ cá Koi giá rẻ', N'https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-768x512.jpg', N'<h2 style="text-align: center;"><span id="Nhung_vi_tri_thich_hop_de_dat_ho_ca_Koi"><strong>Những vị tr&iacute; th&iacute;ch hợp để đặt hồ c&aacute; Koi</strong></span></h2>
<p style="text-align: center;"><em>Điều quan trọng nhất đối với việc&nbsp;<a href="https://hocakoi.vn/thi-cong-ho-ca-koi-ha-noi-chuan-nhat-gia-re/">thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật gi&aacute; rẻ</a>&nbsp;l&agrave; việc x&aacute;c định vị tr&iacute; lắp đặt th&iacute;ch hợp. Với một vị tr&iacute; thuận lợi cho nước chảy, ph&ugrave; hợp cho việc thải nước bẩn của hồ c&aacute;, thuận lợi cho việc lắp đặt, thi c&ocirc;ng&hellip;th&igrave; bạn đ&atilde; c&oacute; thể tiết kiệm được kha kh&aacute; số tiền cho việc x&acirc;y dựng &ndash; bảo dưỡng, phụ kiện cho hồ rồi. Sau đ&acirc;y Hocakoi.vn sẽ c&ugrave;ng bạn xem x&eacute;t từng vị tr&iacute; lắp đặt hồ c&aacute; Koi để xem với những mẫu hồ c&aacute; Koi gi&aacute; rẻ th&igrave; n&ecirc;n đặt hồ ở đ&acirc;u l&agrave; th&iacute;ch hợp nh&eacute;.</em></p>
<p style="text-align: center;">Đầu ti&ecirc;n l&agrave; đặt hồ c&aacute; Koi s&acirc;n vườn nơi bạn c&oacute; thể c&oacute; nhiều kh&ocirc;ng gian để lựa chọn v&agrave; cũng l&agrave; vị tr&iacute; đắc địa nhất cho những ng&ocirc;i nh&agrave; c&oacute; cảnh quan s&acirc;n vườn lớn. Ở vị tr&iacute; n&agrave;y bạn c&oacute; thể lợi dụng cảnh quan tự nhi&ecirc;n sẵn c&oacute; trở th&agrave;nh tiểu cảnh trang tr&iacute; cho hồ m&agrave; kh&ocirc;ng cần phải mất th&ecirc;m chi ph&iacute; trang tr&iacute;. Hơn nữa, bạn c&oacute; thể thoải m&aacute;i lắp đặt, đi đường ống, xả thải hay lấy nguồn nước phục vụ cho hồ c&aacute; Koi. Chi ph&iacute; x&acirc;y dựng thi c&ocirc;ng hồ Koi Nhật ở s&acirc;n vườn sẽ thấp hơn cả so với những vị tr&iacute; m&agrave; Hocakoi.vn đưa ra sau đ&acirc;y. Do đ&oacute;, ưu ti&ecirc;n h&agrave;ng đầu l&agrave; bạn n&ecirc;n thi c&ocirc;ng hồ trong s&acirc;n vườn.</p>
<p style="text-align: center;"><img class="wp-image-1676 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-300x200.jpg" sizes="(max-width: 711px) 100vw, 711px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-1024x683.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-768x512.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat.jpg 1200w" alt="Mẫu hồ c&aacute; Koi tận dụng cảnh quan s&acirc;n vườn gi&aacute; rẻ" width="711" height="474" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-300x200.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-1024x683.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-768x512.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-chuan-nhat.jpg 1200w"></p>
<p style="text-align: center;">Tiếp theo, một vị tr&iacute; cũng được rất nhiều người sử dụng khi x&acirc;y dựng hồ c&aacute; Koi l&agrave; trong nh&agrave;. Hồ c&aacute; koi trong nh&agrave; ph&ugrave; hợp với những căn hộ hiện đại kh&ocirc;ng c&oacute; s&acirc;n vườn đủ rộng để thi c&ocirc;ng hơn l&agrave; những ng&ocirc;i nh&agrave; s&acirc;n vườn rộng. Bởi chi ph&iacute; cho việc l&agrave;m hồ Koi trong nh&agrave; cao hơn nhiều do phải c&oacute; kĩ thuật chống thấm cao hơn, việc thiết kế, lắp đặt, x&acirc;y dựng cũng phức tạp hơn v&igrave; c&ograve;n phải c&acirc;n nhắc đến c&aacute;c chi tiết, kết cấu của ng&ocirc;i nh&agrave; c&oacute; sẵn. Hơn nữa tiểu cảnh cho hồ c&aacute; cũng sẽ hạn chế hơn.</p>
<p style="text-align: center;">V&agrave; cuối c&ugrave;ng l&agrave; kiểu hồ c&aacute; Koi x&acirc;y tr&ecirc;n s&acirc;n thượng &ndash; loại hồ c&aacute; th&iacute;ch hợp cho những ng&ocirc;i nh&agrave; c&oacute; ban c&ocirc;ng hay s&acirc;n thượng rộng, kh&ocirc;ng gian trong nh&agrave; hạn chế hoặc kh&ocirc;ng c&oacute; s&acirc;n vườn. Kiểu hồ n&agrave;y tốn kh&aacute; nhiều chi ph&iacute; so với hai loại hồ trước do vừa phải x&acirc;y dựng ở tr&ecirc;n cao m&agrave; c&ograve;n phải c&acirc;n nhắc th&ecirc;m về kĩ thuật chống thấm, đường đi nước xả thải, hạn chế về kết cấu, x&acirc;y dựng. Do đ&oacute; m&agrave; bạn n&ecirc;n hạn chế vị tr&iacute; n&agrave;y nếu muốn x&acirc;y dựng hồ c&aacute; Koi gi&aacute; thấp.</p>
<div style="text-align: center;">&nbsp;</div>
<h2 style="text-align: center;"><span id="Nhung_dieu_can_thiet_cho_mot_ho_ca_Koi_re_nhung_dam_bao_chat_luong"><strong>Những điều cần thiết cho một hồ c&aacute; Koi rẻ nhưng đảm bảo chất lượng</strong></span></h2>
<p style="text-align: center;"><em>Để&nbsp;<a href="https://hocakoi.vn/thi-cong-ho-ca-koi-ha-noi-chuan-nhat-gia-re/">thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật gi&aacute; rẻ</a>&nbsp;th&igrave; c&oacute; một số nguy&ecirc;n tắc m&agrave; bạn n&ecirc;n lưu &yacute; để tối ưu chi ph&iacute;. Điều quan trọng nhất m&agrave; bạn n&ecirc;n biết đ&oacute; l&agrave; thay v&igrave; tự l&ecirc;n kế hoạch thi c&ocirc;ng hồ c&aacute; Koi khi chưa c&oacute; đủ kinh nghiệm, hiểu biết th&igrave; bạn n&ecirc;n lựa chọn dịch vụ thi c&ocirc;ng hồ c&aacute; Koi trọn g&oacute;i. Điều n&agrave;y sẽ tiết kiệm thời gian, c&ocirc;ng sức v&agrave; tiền bạc hơn nhiều so với việc bạn tự t&iacute;nh to&aacute;n v&igrave; đội ngũ thi c&ocirc;ng c&oacute; nhiều kinh nghiệm, am hiểu về việc x&acirc;y dựng hồ Koi v&agrave; c&oacute; thể hạch to&aacute;n chi ph&iacute;, đưa ra giải ph&aacute;p tiết kiệm cho c&ocirc;ng tr&igrave;nh. Ngo&agrave;i ra, đội ngũ thi c&ocirc;ng sẽ đảm bảo được chất lượng c&ocirc;ng tr&igrave;nh chuẩn Nhật v&agrave; c&oacute; cả ch&iacute;nh s&aacute;ch bảo h&agrave;nh đi k&egrave;m gi&uacute;p bạn kh&ocirc;ng phải lo lắng khi c&oacute; sự cố xảy ra.</em></p>
<p style="text-align: center;">Khi x&acirc;y hồ, bạn cũng n&ecirc;n định h&igrave;nh trước k&iacute;ch thước để ước t&iacute;nh chi ph&iacute; th&iacute;ch hợp. D&ugrave; x&acirc;y hồ c&aacute; k&iacute;ch thước lớn hay nhỏ th&igrave; bạn cũng n&ecirc;n ch&uacute; &yacute; độ s&acirc;u tối thiểu của hồ l&agrave; 0,9m. Nếu muốn tiết kiệm chi ph&iacute; sưởi cho m&ugrave;a đ&ocirc;ng hoặc ở những nơi kh&iacute; hậu lạnh, bạn c&oacute; thể đ&agrave;o hồ s&acirc;u hơn một ch&uacute;t để tr&aacute;nh sự thay đổi nhiệt độ đột ngột, ảnh hưởng đến sức khỏe c&aacute; Koi. Bạn cũng n&ecirc;n t&iacute;nh to&aacute;n kh&ocirc;ng gian hợp l&iacute; sao cho mật độ c&aacute; trong hồ kh&ocirc;ng vượt qu&aacute; 1m3 cho một con c&aacute; Koi cỡ trung b&igrave;nh. Mật độ c&aacute; qu&aacute; d&agrave;y sẽ l&agrave;m hồ nhanh ch&oacute;ng &ocirc; nhiễm, tăng khả năng nhiễm bệnh trong khi mật độ qu&aacute; thưa sẽ l&agrave;m giảm phản xạ của c&aacute;.</p>
<p style="text-align: center;"><img class="wp-image-1560 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-300x225.jpg" sizes="(max-width: 604px) 100vw, 604px" srcset="https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat.jpg 1600w" alt="Hồ c&aacute; Koi k&iacute;ch thước nhỏ nhưng sinh động để tối ưu chi ph&iacute;" width="604" height="453" data-src="https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/toi-uu-van-hanh-ho-ca-koi-nhat.jpg 1600w"></p>
<p style="text-align: center;">Khi&nbsp;<a href="https://hocakoi.vn/thi-cong-ho-ca-koi-ha-noi-chuan-nhat-gia-re/">thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật gi&aacute; rẻ</a>, trong c&ocirc;ng đoạn đổ b&ecirc; t&ocirc;ng l&ograve;ng hồ v&agrave; cạnh sườn th&igrave; bạn c&oacute; thể c&acirc;n nhắc sử dụng kĩ thuật trải bạt PVC hiện đại gi&uacute;p giảm bớt chi ph&iacute;. Việc l&agrave;m hồ c&aacute; Koi trải bạt cũng gi&uacute;p m&ocirc;i trường nước được c&acirc;n bằng v&agrave; bạn kh&ocirc;ng cần tốn nhiều c&ocirc;ng chăm s&oacute;c trong giai đoạn đầu khi mới nu&ocirc;i c&aacute;. Đối với những hồ c&aacute; Koi cỡ nhỏ th&igrave; bạn c&oacute; thể tham khảo hệ thống lọc gi&agrave;n lọc mưa đơn giản chứ kh&ocirc;ng cần đến c&aacute;c th&ugrave;ng lọc cao cấp, tuy nhi&ecirc;n phải vệ sinh hồ c&aacute; Koi định k&igrave; v&igrave; khả năng lọc triệt để của gi&agrave;n lọc đơn giản l&agrave; kh&ocirc;ng cao, l&acirc;u ng&agrave;y dễ để lại cặn bẩn, mọc r&ecirc;u hay nổi v&aacute;ng d&agrave;y. Hơn nữa bạn n&ecirc;n ch&uacute; &yacute; rằng c&aacute;c thiết bị lọc sẽ phải hoạt động với c&ocirc;ng suất lớn n&ecirc;n để tr&aacute;nh hư hỏng g&acirc;y tổn hại nhiều chi ph&iacute; th&igrave; n&ecirc;n đầu tư loại chất lượng tốt nhất ngay từ đầu.</p>
<p style="text-align: center;">Ngo&agrave;i ra, đối với tiểu cảnh trang tr&iacute;, bạn c&oacute; thể sử dụng những bụi c&acirc;y, hoa, cỏ đơn giản, trải đ&aacute;, ph&ugrave; hợp với k&iacute;ch cỡ của hồ c&aacute; hay tận dụng ch&iacute;nh khung cảnh tự nhi&ecirc;n. V&agrave; một điều quan trọng kh&ocirc;ng k&eacute;m l&agrave; để cho chi ph&iacute; hồ c&aacute; Koi kh&ocirc;ng qu&aacute; nặng nề, việc thường xuy&ecirc;n theo d&otilde;i, chăm s&oacute;c v&agrave; tự bảo dưỡng hồ c&aacute; Koi cũng như c&aacute;c phụ kiện sẽ gi&uacute;p &iacute;ch rất nhiều cho bạn đấy!</p>
<h2 style="text-align: center;"><span id="Top_10_mau_ho_ca_Koi_gia_re_tham_khao" style="background-color: #ecf0f1;"><strong>Top 10 mẫu hồ c&aacute; Koi gi&aacute; rẻ tham khảo</strong></span></h2>
<p style="text-align: center;">Dưới đ&acirc;y, Hocakoi.vn sẽ gợi &yacute; cho bạn 10 mẫu hồ c&aacute; Koi gi&aacute; rẻ để bạn tham khảo. Ch&uacute;ng t&ocirc;i đ&atilde; từng&nbsp;<a href="https://hocakoi.vn/thi-cong-ho-ca-koi-ha-noi-chuan-nhat-gia-re/">thi c&ocirc;ng hồ c&aacute; Koi chuẩn Nhật gi&aacute; rẻ</a>&nbsp;cho nhiều ng&ocirc;i nh&agrave; v&agrave; những mẫu hồ dưới đ&acirc;y đều rất được ưa chuộng. Ch&uacute;ng ph&ugrave; hợp với những gia đ&igrave;nh c&oacute; kinh ph&iacute; kh&ocirc;ng qu&aacute; cao nhưng vẫn đảm bảo được t&iacute;nh thẩm mỹ v&agrave; chất lượng vận h&agrave;nh.</p>
<p style="text-align: center;"><img class="wp-image-1682 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-300x200.jpg" sizes="(max-width: 610px) 100vw, 610px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-1024x683.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-768x512.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re.jpg 1200w" alt="Mẫu hồ c&aacute; Koi Nhật tự nhi&ecirc;n, gi&aacute; rẻ" width="610" height="407" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-300x200.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-1024x683.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-768x512.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-nhat-re.jpg 1200w"></p>
<p style="text-align: center;"><img class="wp-image-1681 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-300x225.jpg" sizes="(max-width: 604px) 100vw, 604px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-2048x1536.jpg 2048w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-600x450.jpg 600w" alt="Mẫu hồ c&aacute; Koi gi&aacute; rẻ chuẩn Nhật sinh động, độc đ&aacute;o" width="604" height="453" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-2048x1536.jpg 2048w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-chuan-nhat-600x450.jpg 600w"></p>
<p style="text-align: center;"><img class="wp-image-1680 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-300x192.jpg" sizes="(max-width: 604px) 100vw, 604px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-300x192.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-1024x656.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-768x492.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-600x385.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re.jpg 1200w" alt="Mẫu hồ c&aacute; Koi gi&aacute; rẻ với tiểu cảnh bụi c&acirc;y hoa cỏ" width="604" height="387" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-300x192.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-300x192.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-1024x656.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-768x492.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re-600x385.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-gia-re.jpg 1200w"></p>
<p style="text-align: center;"><img class="wp-image-1679 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat-300x200.jpg" sizes="(max-width: 600px) 100vw, 600px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat.jpg 612w" alt="Mẫu hồ c&aacute; Koi chuẩn Nhật h&igrave;nh tr&ograve;n gi&aacute; rẻ" width="600" height="400" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat-300x200.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-koi-chuan-nhat.jpg 612w"></p>
<p style="text-align: center;"><img class="wp-image-1678 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-300x225.jpg" sizes="(max-width: 598px) 100vw, 598px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re.jpg 1280w" alt="Mẫu hồ c&aacute; Koi Nhật mini gi&aacute; rẻ, dễ chăm s&oacute;c" width="598" height="449" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-re.jpg 1280w"></p>
<p style="text-align: center;"><img class="wp-image-1677 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-300x225.jpg" sizes="(max-width: 592px) 100vw, 592px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re.jpg 2048w" alt="Mẫu hồ c&aacute; Koi Nhật gi&aacute; rẻ đơn giản" width="592" height="444" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-nhat-gia-re.jpg 2048w"></p>
<p style="text-align: center;"><img class="wp-image-1675 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-300x225.jpg" sizes="(max-width: 596px) 100vw, 596px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-2048x1536.jpg 2048w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-600x450.jpg 600w" alt="Mẫu hồ c&aacute; koi c&oacute; tiểu cảnh gi&aacute; rẻ chuẩn Nhật" width="596" height="447" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-2048x1536.jpg 2048w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-gia-re-600x450.jpg 600w"></p>
<p style="text-align: center;"><img class="wp-image-1674 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-300x225.jpg" sizes="(max-width: 593px) 100vw, 593px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re.jpg 1600w" alt="Mẫu hồ c&aacute; Koi chuẩn Nhật gi&aacute; rẻ n&ecirc;n tham khảo" width="593" height="445" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-1024x768.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-768x576.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-1536x1152.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re-600x450.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-re.jpg 1600w"></p>
<p style="text-align: center;"><img class="wp-image-1673 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-gia-re-300x225.jpg" sizes="(max-width: 591px) 100vw, 591px" srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-gia-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-gia-re.jpg 533w" alt="Mẫu hồ c&aacute; Koi mini chuẩn Nhật gi&aacute; rẻ" width="591" height="443" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-gia-re-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-gia-re-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/04/mau-ho-ca-koi-chuan-nhat-gia-re.jpg 533w"></p>
<p><img class="wp-image-1567 aligncenter lazy-load-active" style="display: block; margin-left: auto; margin-right: auto;" src="https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-300x200.jpg" sizes="(max-width: 593px) 100vw, 593px" srcset="https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-1024x683.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-768x512.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-1536x1024.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi.jpg 1600w" alt="Thiết kế hồ c&aacute; Koi đơn giản với th&aacute;c nước" width="593" height="395" loading="lazy" data-src="https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-300x200.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-300x200.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-1024x683.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-768x512.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-1536x1024.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi-600x400.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/thac-nuoc-ho-ca-koi.jpg 1600w"></p>', N'Published')
INSERT [dbo].[Blog] ([BlogID], [Heading], [Image], [Link], [status]) VALUES (N'BL003', N'Những điều cần biết khi xây hồ cá Koi trong nhà', N'https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-768x485.jpg', N'<h2 style="text-align: center;"><span id="Dien_tich_xay_dung_phong_thuy_han_che" ><strong>Diện t&iacute;ch x&acirc;y dựng, phong thủy hạn chế?</strong></span></h2>
<p style="text-align: center;"><em>Nếu như khi x&acirc;y hồ c&aacute; Koi ngo&agrave;i trời, trong s&acirc;n vườn th&igrave; bạn c&oacute; nhiều diện t&iacute;ch, kh&ocirc;ng gian v&agrave; vị tr&iacute; để đặt hồ th&igrave; khi x&acirc;y hồ c&aacute; Koi trong nh&agrave;, c&aacute;c yếu tố như diện t&iacute;ch v&agrave; phong thủy sẽ hạn chế hơn rất nhiều. Diện t&iacute;ch của căn nh&agrave; ngo&agrave;i việc ph&acirc;n bổ cho c&aacute;c ph&ograve;ng chức năng c&ograve;n đặt nhiều đồ đạc v&agrave; nội thất, v&igrave; vậy diện t&iacute;ch để chứa một bể c&aacute; l&agrave; kh&ocirc;ng nhiều. Th&ecirc;m v&agrave;o đ&oacute;, trong&nbsp;<a href="https://hocakoi.vn/cac-buoc-thi-cong-ho-ca-koi-chuan-nhat/">c&aacute;c bước thi c&ocirc;ng hồ c&aacute; Koi</a>, gia chủ thường phải xem x&eacute;t đến yếu tố phong thủy để hợp mệnh, hợp tuổi t&aacute;c để quyết định đến vị tr&iacute;, hướng đặt hồ Koi. Tuy nhi&ecirc;n kh&ocirc;ng phải vị tr&iacute; n&agrave;o th&iacute;ch hợp với phong thủy cũng c&oacute; thể đặt ngay hồ c&aacute; v&agrave;o được m&agrave; c&ograve;n cần t&iacute;nh to&aacute;n để hợp với kết cấu của ng&ocirc;i nh&agrave;.</em></p>
<p style="text-align: center;"><img class="wp-image-1629 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-300x189.jpg" sizes="(max-width: 703px) 100vw, 703px" srcset="https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-300x189.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-1024x647.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-768x485.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-1536x970.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-2048x1293.jpg 2048w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-600x379.jpg 600w" alt="Hồ c&aacute; Koi được đặt trong một g&oacute;c nh&agrave;" width="703" height="443" data-src="https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-300x189.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-300x189.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-1024x647.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-768x485.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-1536x970.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-2048x1293.jpg 2048w, https://hocakoi.vn/wp-content/uploads/2020/03/thi-cong-ho-koi-nhat-trong-nha-600x379.jpg 600w"></p>
<p style="text-align: center;">Nhưng kh&ocirc;ng phải v&igrave; những yếu tố n&agrave;y m&agrave; kh&ocirc;ng thể x&acirc;y dựng hồ Koi trong nh&agrave;. C&oacute; rất nhiều gia đ&igrave;nh được Hocakoi.vn tư vấn v&agrave; c&oacute; được những bể c&aacute; Koi sinh động, mang đến gi&aacute; trị cho gia chủ. B&iacute; quyết của Hocakoi.vn cho điều n&agrave;y l&agrave; tối ưu h&oacute;a tối đa k&iacute;ch thước x&acirc;y dựng hồ. Kh&ocirc;ng cần một hồ c&aacute; Koi qu&aacute; lớn bạn mới tận hưởng được vẻ đẹp của ch&uacute;ng, miễn l&agrave; l&agrave;m sao ch&uacute;ng hợp l&yacute; với diện t&iacute;ch của căn nh&agrave; v&agrave; được trang tr&iacute; hợp phong c&aacute;ch, &yacute; th&iacute;ch của chủ nh&acirc;n l&agrave; được. B&ecirc;n cạnh đ&oacute;, lựa chọn số lượng v&agrave; loại c&aacute; Koi ph&ugrave; hợp với diện t&iacute;ch của hồ để đảm bảo sự sinh trưởng, ph&aacute;t triển của ch&uacute;ng tốt nhất.</p>
<h2 style="text-align: center;"><span id="Chu_trong_den_cac_yeu_to_ki_thuat"><strong>Ch&uacute; trọng đến c&aacute;c yếu tố kĩ thuật</strong></span></h2>
<p style="text-align: center;">Đối với việc x&acirc;y hồ c&aacute; Koi trong nh&agrave; th&igrave; c&aacute;c yếu tố thi c&ocirc;ng sẽ đ&ograve;i hỏi phức tạp hơn nhiều khi&nbsp;<a href="https://hocakoi.vn/cac-buoc-thi-cong-ho-ca-koi-chuan-nhat/">thi c&ocirc;ng hồ Koi</a>&nbsp;ngo&agrave;i trời. Cụ thể l&agrave;:</p>
<h3 style="text-align: center;"><em><span id="Xay_dung_ho_chinh_va_he_thong_be_lang_loc">X&acirc;y dựng hồ ch&iacute;nh v&agrave; hệ thống bể lắng lọc</span></em></h3>
<p style="text-align: center;">Việc đặt hồ c&aacute; Koi trong nh&agrave; sẽ đưa ra hai vấn đề m&agrave; bạn c&oacute; thể nh&igrave;n thấy được đ&oacute; l&agrave; c&oacute; n&ecirc;n đ&agrave;o hồ hay n&ecirc;n x&acirc;y hồ trong nh&agrave;? Th&ocirc;ng thường với những ng&ocirc;i nh&agrave; đang x&acirc;y dựng, việc đ&agrave;o hồ dễ d&agrave;ng hơn khi được t&iacute;nh to&aacute;n c&ugrave;ng với c&ocirc;ng tr&igrave;nh tổng thể. Ngược lại đối với những ng&ocirc;i nh&agrave; đ&atilde; ho&agrave;n thiện ki&ecirc;n cố, việc đ&agrave;o hồ trong nh&agrave; c&oacute; nhiều bất lợi v&agrave; kh&oacute; thực hiện, rất dễ ảnh hưởng đến phong thủy, v&igrave; vậy n&ecirc;n x&acirc;y hồ hoặc đặt bể th&igrave; sẽ thuận tiện hơn.</p>
<div style="text-align: center;">&nbsp;</div>
<p style="text-align: center;"><img class="wp-image-1473 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-300x224.jpg" sizes="(max-width: 652px) 100vw, 652px" srcset="https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-300x224.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-1024x765.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-768x574.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-1536x1147.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-600x448.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat.jpg 1920w" alt="Một hệ thống lọc hồ Koi mini căn bản" width="652" height="487" data-src="https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-300x224.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-300x224.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-1024x765.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-768x574.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-1536x1147.jpg 1536w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat-600x448.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/he-loc-ho-koi-nhat.jpg 1920w"></p>
<p style="text-align: center;">B&ecirc;n cạnh kết cấu của hồ ch&iacute;nh th&igrave; hệ thống hồ lắng lọc cũng l&agrave; một điều cần được quan t&acirc;m. Vị tr&iacute; đặt hồ lắng lọc thường l&agrave; đi c&ugrave;ng với bể nu&ocirc;i c&aacute; ch&iacute;nh, v&igrave; vậy sẽ đ&ograve;i hỏi sự logic khi đi đường ống trong hồ c&ugrave;ng với c&aacute;c thiết bị, phụ kiện của qu&aacute; tr&igrave;nh lọc sao cho hợp l&iacute; với nguồn nước, kh&ocirc;ng bị cồng kềnh m&agrave; vẫn c&oacute; hoạt động hiệu quả. Đối với c&aacute;c hồ c&aacute; trong nh&agrave; th&igrave; thường l&agrave; loại mini n&ecirc;n c&oacute; thể sử dụng bộ lắng lọc All-in-one, c&aacute;c th&ugrave;ng lọc cỡ vừa v&agrave; nhỏ hoặc c&aacute;c phụ kiện lắng lọc cần thiết ri&ecirc;ng rẽ. Bởi thể t&iacute;ch hồ kh&ocirc;ng qu&aacute; lớn n&ecirc;n kh&ocirc;ng đ&ograve;i hỏi c&ocirc;ng suất cao, thuận tiện cho việc lắp đặt. Một điều cần lưu &yacute; l&agrave; khi đặt bể c&aacute; Koi trong nh&agrave;, tiếng ồn m&aacute;y bơm hay tiếng ồn của m&aacute;y oxy cũng c&oacute; thể ảnh hưởng đến gia đ&igrave;nh, v&igrave; vậy n&ecirc;n lựa chọn c&aacute;c loại phụ kiện &iacute;t g&acirc;y tiếng ồn hoặc thiết kế vị tr&iacute; đặt kh&aacute;c.</p>
<h3 style="text-align: center;"><span id="Ky_thuat_chong_tham"><em>Kỹ thuật chống thấm</em></span></h3>
<p style="text-align: center;">Một yếu tố h&agrave;ng đầu kh&ocirc;ng thể thiếu trong&nbsp;<a href="https://hocakoi.vn/cac-buoc-thi-cong-ho-ca-koi-chuan-nhat/">c&aacute;c bước thi c&ocirc;ng hồ c&aacute; Koi</a>&nbsp;cần được đặc biệt quan t&acirc;m l&agrave; kỹ thuật chống thấm. Việc nước trong hồ ngấm ra nền nh&agrave;, tường nh&agrave;, trước mắt sẽ g&acirc;y n&ecirc;n mất thẩm mỹ v&agrave; sự kh&oacute; chịu. Về l&acirc;u về d&agrave;i, nước trong hồ ngấm ra sẽ dễ g&acirc;y r&ecirc;u mốc, nấm, hiện tượng b&agrave;o m&ograve;n ảnh hưởng đến kết cấu trung của ng&ocirc;i nh&agrave;. Do đ&oacute;, việc xử l&yacute; chống thấm đ&ograve;i hỏi kỹ thuật cao v&agrave; nghi&ecirc;m ngặt hơn nhiều trong việc x&acirc;y hồ c&aacute; Koi trong nh&agrave;.</p>
<p style="text-align: center;"><img class="wp-image-1363 aligncenter lazy-load-active" src="https://hocakoi.vn/wp-content/uploads/2020/03/13.2-300x225.jpg" sizes="(max-width: 628px) 100vw, 628px" srcset="https://hocakoi.vn/wp-content/uploads/2020/03/13.2-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2-1024x767.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2-768x575.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2-600x449.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2.jpg 1179w" alt="X&acirc;y dựng hồ ch&iacute;nh v&agrave; hồ lắng lọc của bể c&aacute; Koi" width="628" height="471" data-src="https://hocakoi.vn/wp-content/uploads/2020/03/13.2-300x225.jpg" data-srcset="https://hocakoi.vn/wp-content/uploads/2020/03/13.2-300x225.jpg 300w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2-1024x767.jpg 1024w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2-768x575.jpg 768w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2-600x449.jpg 600w, https://hocakoi.vn/wp-content/uploads/2020/03/13.2.jpg 1179w"></p>
<p style="text-align: center;">Tại Hocakoi.vn, khi thi c&ocirc;ng c&aacute;c c&ocirc;ng tr&igrave;nh hồ c&aacute; Koi trong nh&agrave;, ch&uacute;ng t&ocirc;i đặc biệt ch&uacute; trọng đến c&aacute;c loại vật liệu chống thấm chất lượng cao cho đ&aacute;y hồ v&agrave; th&agrave;nh hồ b&ecirc;n cạnh việc đổ b&ecirc; t&ocirc;ng v&agrave; tr&aacute;ng xi măng theo quy tr&igrave;nh th&ocirc;ng thường. Ngo&agrave;i ra trong qu&aacute; tr&igrave;nh thi c&ocirc;ng, việc lu l&egrave;n đất đ&aacute;, kỹ thuật l&agrave;m vữa, b&ecirc; t&ocirc;ng v&agrave; x&acirc;y dựng cũng hết sức được ch&uacute; trọng để hạn chế nhất t&igrave;nh trạng thấm nước.</p>
<h3 style="text-align: center;"><span id="He_thong_xa_thai_chong_tran_va_ve_sinh_ho"><em>Hệ thống xả thải, chống tr&agrave;n v&agrave; vệ sinh hồ</em></span></h3>
<p style="text-align: center;">Đối với hồ c&aacute; Koi, trong qu&aacute; tr&igrave;nh lắng lọc th&igrave; việc thiết lập hệ thống xả thải v&agrave; chống tr&agrave;n cũng rất quan trọng. Nếu đối với s&acirc;n vườn th&igrave; vị tr&iacute; xả thải c&oacute; thể thoải m&aacute;i miễn l&agrave; thuận tiện với sự bố tr&iacute; của hồ hay cảnh quan chung th&igrave; hệ thống xả thải trong nh&agrave; c&oacute; phần rắc rối v&igrave; kh&ocirc;ng thể xả chất thải bừa b&atilde;i. Điều n&agrave;y c&oacute; thể hạn chế bằng c&aacute;ch thiết lập đường ống d&agrave;i hoặc c&oacute; c&aacute;c th&ugrave;ng đựng chất thải ri&ecirc;ng v&agrave; c&oacute; thời gian lắng lọc hồ cố định. Th&ecirc;m v&agrave;o đ&oacute; hồ c&aacute; Koi trong nh&agrave; n&ecirc;n c&oacute; hệ thống chống tr&agrave;n để tr&aacute;nh t&igrave;nh trạng nước trong hồ tr&agrave;n ra ngo&agrave;i.</p>', N'Published')
INSERT [dbo].[Blog] ([BlogID], [Heading], [Image], [Link], [status]) VALUES (N'BL004', N'Phong Thủy Cá Koi: Biểu Tượng Tài Lộc và May Mắn trong Không Gian Sống', N'https://bizweb.dktcdn.net/100/004/358/files/nuoi-koi-theo-phong-thuy.jpg?v=1463238561435', N'<div class="flex-shrink-0 flex flex-col relative items-end">
    <div>
      <div class="pt-0">
        <div class="gizmo-bot-avatar flex h-8 w-8 items-center justify-center overflow-hidden rounded-full">&nbsp;</div>
      </div>
    </div>
  </div>
  <div class="group/conversation-turn relative flex w-full min-w-0 flex-col agent-turn">
    <div class="flex-col gap-1 md:gap-3">
      <div class="flex max-w-full flex-col flex-grow">
        <div class="min-h-8 text-message flex w-full flex-col items-end gap-2 whitespace-normal break-words [.text-message+&]:mt-5" dir="auto" data-message-author-role="assistant" data-message-id="e86de1e7-a943-4ad0-bc3e-19c6d945fe9d" data-message-model-slug="gpt-4o">
          <div class="flex w-full flex-col gap-1 empty:hidden first:pt-[3px]">
            <div class="markdown prose w-full break-words dark:prose-invert light">
              <h1 style="text-align: center;"><strong>Phong Thủy Cá Koi: Biểu Tượng Tài Lộc và May Mắn trong Không Gian Sống</strong></h1>
              <p style="text-align: center;"><em>Cá Koi không chỉ nổi tiếng bởi vẻ đẹp quyến rũ và sự uyển chuyển trong từng chuyển động mà còn mang ý nghĩa phong thủy sâu sắc. Trong văn hóa Á Đông, đặc biệt là Nhật Bản và Trung Quốc, cá Koi được xem như biểu tượng của <strong>tài lộc, may mắn, và sự kiên trì</strong>. Bài viết này sẽ giúp bạn hiểu rõ hơn về ý nghĩa phong thủy của cá Koi và cách ứng dụng trong không gian sống để thu hút năng lượng tích cực.</em></p>
              <hr>
              <h2><strong>Ý Nghĩa Phong Thủy của Cá Koi</strong></h2>
              <p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_700,h_373/https://tournhatban.net/wp-content/uploads/2021/07/bieu-tuong-ca-chep-3-e1627202510117.jpg" alt="Biểu tượng Cá Koi trong văn hoá "xứ Phù Tang""></p>
              <ol>
                <li><strong>Tượng trưng cho sự thịnh vượng và tài lộc:</strong> Cá Koi đại diện cho <strong>dòng chảy tài chính suôn sẻ</strong> và <strong>vận may</strong>. Đặc biệt, cá màu vàng hoặc ánh kim được xem là biểu tượng của <strong>phú quý</strong>.</li>
                <li><strong>Biểu tượng của sự kiên trì và thành công:</strong> Truyền thuyết kể rằng cá Koi vượt thác Hoàng Hà sẽ hóa thành rồng, biểu thị cho <strong>bền bỉ và vượt khó</strong>.</li>
                <li><strong>Cân bằng âm dương và năng lượng tích cực:</strong> Hồ cá Koi mang lại sự hài hòa ngũ hành và <strong>thu hút sinh khí</strong>.</li>
              </ol>
              <hr>
              <h2><strong>Những Lưu Ý Phong Thủy Khi Chăm Sóc Cá Koi</strong></h2>
              <p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://media.baoquangninh.vn/thumb/600/upload/image/202307/thumbnail/2108180_faf_13013125.jpg" alt="Thú chơi Cá Koi: Nghề chơi cũng lắm công phu"></p>
              <ol>
                <li><strong>Chất lượng nước:</strong> Nước hồ phải sạch và lưu thông liên tục, biểu tượng cho dòng tài lộc không ngừng.</li>
                <li><strong>Tránh cá chết:</strong> Cá chết mang điềm xui, cần thay thế nhanh để giữ vận may.</li>
                <li><strong>Bảo dưỡng hồ:</strong> Duy trì hồ trong trạng thái tốt để tăng sinh khí và thư giãn.</li>
              </ol>
              <hr>
              <h2><strong>Ứng Dụng Cá Koi Trong Trang Trí Không Gian Sống</strong></h2>
              <ul>
                <li><strong>Tranh cá Koi:</strong> Treo tranh trong phòng khách để kích hoạt năng lượng phong thủy.</li>
                <li><strong>Đài phun nước:</strong> Đặt đài phun nước hình cá Koi ở sân hoặc ban công để tăng may mắn.</li>
                <li><strong>Bể cá mini:</strong> Bể cá nhỏ trên bàn làm việc giúp tăng sự tập trung và bình an.</li>
              </ul>
              <hr>
              <h2><strong>Kết Luận</strong></h2>
              <p>Phong thủy cá Koi là cách hiệu quả để tạo hài hòa và thu hút năng lượng tích cực. Dù là hồ cá lớn hay chỉ đơn giản là tranh, mỗi biểu tượng đều mang thông điệp về <strong>sự thịnh vượng và kiên trì</strong>. Việc chăm sóc hồ cá đúng cách không chỉ mang lại sự thư giãn mà còn giúp <strong>cải thiện vận may và tài lộc</strong> cho gia đình.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>', N'Published')
INSERT [dbo].[Blog] ([BlogID], [Heading], [Image], [Link], [status]) VALUES (N'BL005', N'Linh Vật Mang Tài Lộc và Bình An Cho Gia Đình', N'https://printek.vn/media/enoplngp/ms007.jpeg?rmode=crop&width=400&format=webp&quality=75&height=400', N'<h3 style="text-align: center;">Linh Vật Mang T&agrave;i Lộc v&agrave; B&igrave;nh An Cho Gia Đ&igrave;nh</h3>
<p style="text-align: center;"><em>C&aacute; Koi đ&atilde; trở th&agrave;nh một biểu tượng nổi bật trong phong thủy, mang lại sự thịnh vượng v&agrave; may mắn cho những ai sở hữu ch&uacute;ng. Kh&ocirc;ng chỉ đơn thuần l&agrave; một loại c&aacute; cảnh, c&aacute; Koi c&ograve;n được coi l&agrave; một linh vật mang lại năng lượng t&iacute;ch cực cho kh&ocirc;ng gian sống. B&agrave;i viết n&agrave;y sẽ gi&uacute;p bạn kh&aacute;m ph&aacute; c&aacute;ch c&aacute; Koi c&oacute; thể ảnh hưởng đến phong thủy của ng&ocirc;i nh&agrave;, cũng như những c&aacute;ch thức để tối ưu h&oacute;a lợi &iacute;ch từ ch&uacute;ng.</em></p>
<p style="text-align: center;"><em><img src="https://i.pinimg.com/564x/b0/bb/fa/b0bbfa89846a74031d09bb5b445cc9ff.jpg"></em></p>
<h4 style="text-align: center;"><em><strong>Tại Sao C&aacute; Koi Được Xem L&agrave; Biểu Tượng Phong Thủy?</strong></em></h4>
<p>Trong văn h&oacute;a &Aacute; Đ&ocirc;ng, đặc biệt l&agrave; ở Nhật Bản v&agrave; Trung Quốc, c&aacute; Koi được coi l&agrave; biểu tượng của t&agrave;i lộc, sự ki&ecirc;n tr&igrave; v&agrave; sức mạnh. Với h&igrave;nh ảnh những ch&uacute; c&aacute; Koi bơi lội trong hồ, ch&uacute;ng kh&ocirc;ng chỉ mang lại vẻ đẹp tự nhi&ecirc;n m&agrave; c&ograve;n tượng trưng cho sức sống m&atilde;nh liệt.</p>
<p>Theo truyền thuyết, c&aacute; Koi l&agrave; h&igrave;nh mẫu cho sự bền bỉ khi vượt qua kh&oacute; khăn. H&igrave;nh ảnh c&aacute; Koi bơi ngược d&ograve;ng s&ocirc;ng Ho&agrave;ng H&agrave; để h&oacute;a th&agrave;nh rồng kh&ocirc;ng chỉ l&agrave; một c&acirc;u chuyện cổ t&iacute;ch m&agrave; c&ograve;n mang theo th&ocirc;ng điệp về sức mạnh vượt qua thử th&aacute;ch. Sự ki&ecirc;n tr&igrave; v&agrave; nỗ lực kh&ocirc;ng ngừng nghỉ sẽ mang lại th&agrave;nh c&ocirc;ng v&agrave; t&agrave;i lộc cho gia chủ.</p>
<h4 style="text-align: center;"><em><strong>C&aacute; Koi v&agrave; T&aacute;c Dụng T&iacute;ch Cực Đối Với Kh&ocirc;ng Gian Sống</strong></em></h4>
<p>Việc nu&ocirc;i c&aacute; Koi trong hồ kh&ocirc;ng chỉ gi&uacute;p bạn tạo n&ecirc;n kh&ocirc;ng gian thư gi&atilde;n m&agrave; c&ograve;n cải thiện phong thủy cho ng&ocirc;i nh&agrave;. Hồ c&aacute; Koi kh&ocirc;ng chỉ tạo ra một cảnh quan đẹp mắt m&agrave; c&ograve;n c&oacute; t&aacute;c dụng thu h&uacute;t t&agrave;i lộc, c&acirc;n bằng năng lượng &acirc;m dương v&agrave; mang lại sự an l&agrave;nh cho gia đ&igrave;nh.</p>
<ul>
<li>
<p><strong>C&acirc;n Bằng &Acirc;m Dương</strong>: Nước l&agrave; yếu tố quan trọng trong phong thủy, gi&uacute;p c&acirc;n bằng giữa &acirc;m v&agrave; dương. Hồ c&aacute; Koi mang lại cảm gi&aacute;c thanh b&igrave;nh, l&agrave;m dịu đi những căng thẳng v&agrave; lo &acirc;u trong cuộc sống h&agrave;ng ng&agrave;y.</p>
</li>
<li>
<p><strong>Th&uacute;c Đẩy T&agrave;i Lộc</strong>: Việc sở hữu c&aacute; Koi, đặc biệt l&agrave; những ch&uacute; c&aacute; c&oacute; m&agrave;u sắc tươi s&aacute;ng như v&agrave;ng v&agrave; đỏ, sẽ gi&uacute;p thu h&uacute;t t&agrave;i lộc v&agrave; may mắn. M&agrave;u v&agrave;ng tượng trưng cho sự gi&agrave;u sang, trong khi m&agrave;u đỏ biểu thị cho sức khỏe v&agrave; hạnh ph&uacute;c.</p>
</li>
</ul>
<p style="text-align: center;"><img src="https://i.pinimg.com/736x/ed/58/42/ed584268efc658d9119a09f780ce5cf8.jpg" alt="H&igrave;nh ảnh Ghim c&acirc;u chuyện"></p>
<h4 style="text-align: center;"><em><strong>Sử Dụng C&aacute; Koi Để Tăng Cường Phong Thủy Trong Kh&ocirc;ng Gian Sống</strong></em></h4>
<p>Nếu bạn kh&ocirc;ng thể x&acirc;y dựng một hồ c&aacute; Koi lớn, vẫn c&oacute; nhiều c&aacute;ch kh&aacute;c để kết hợp h&igrave;nh ảnh c&aacute; Koi v&agrave;o kh&ocirc;ng gian sống của bạn:</p>
<ul>
<li>
<p><strong>Tranh C&aacute; Koi</strong>: Treo những bức tranh c&aacute; Koi ở ph&ograve;ng kh&aacute;ch hoặc ph&ograve;ng l&agrave;m việc sẽ gi&uacute;p k&iacute;ch hoạt năng lượng phong thủy v&agrave; tạo điểm nhấn nghệ thuật cho kh&ocirc;ng gian.</p>
</li>
<li>
<p><strong>Đồ Trang Tr&iacute; H&igrave;nh C&aacute; Koi</strong>: Sử dụng c&aacute;c đồ trang tr&iacute; h&igrave;nh c&aacute; Koi như tượng hoặc đ&egrave;n trang tr&iacute; c&oacute; h&igrave;nh d&aacute;ng c&aacute; Koi. Những vật phẩm n&agrave;y kh&ocirc;ng chỉ mang lại vẻ đẹp m&agrave; c&ograve;n c&oacute; thể thu h&uacute;t t&agrave;i lộc.</p>
</li>
<li>
<p><strong>Bể C&aacute; Nhỏ</strong>: Một bể c&aacute; mini với v&agrave;i ch&uacute; c&aacute; Koi sẽ l&agrave; lựa chọn tuyệt vời cho b&agrave;n l&agrave;m việc của bạn. Sự hiện diện của nước v&agrave; c&aacute; Koi sẽ gi&uacute;p tạo cảm gi&aacute;c b&igrave;nh an v&agrave; tập trung khi l&agrave;m việc.</p>
</li>
</ul>
<h4 style="text-align: center;"><strong>Kết Luận</strong></h4>
<p>C&aacute; Koi kh&ocirc;ng chỉ l&agrave; một lo&agrave;i c&aacute; cảnh m&agrave; c&ograve;n l&agrave; biểu tượng phong thủy mang lại sự thịnh vượng v&agrave; an l&agrave;nh cho kh&ocirc;ng gian sống. Việc nu&ocirc;i dưỡng v&agrave; chăm s&oacute;c c&aacute; Koi kh&ocirc;ng chỉ tạo n&ecirc;n một kh&ocirc;ng gian đẹp mắt m&agrave; c&ograve;n g&oacute;p phần cải thiện vận may cho gia chủ. H&atilde;y để c&aacute; Koi trở th&agrave;nh một phần quan trọng trong cuộc sống của bạn, mang đến sự b&igrave;nh an, hạnh ph&uacute;c v&agrave; t&agrave;i lộc cho gia đ&igrave;nh.</p>', N'Published')
INSERT [dbo].[Blog] ([BlogID], [Heading], [Image], [Link], [status]) VALUES (N'BL006', N'Khám Phá Năng Lượng Tích Cực Từ Cá Koi Trong Phong Thủy', N'https://jpkoi.vn/wp-content/uploads/2020/04/ca-chep-koi-dep.jpg', N'<h1 style="text-align: center;"><strong>Kh&aacute;m Ph&aacute; Năng Lượng T&iacute;ch Cực Từ C&aacute; Koi Trong Phong Thủy</strong></h1>
<p style="text-align: center;"><em>C&aacute; Koi, với vẻ đẹp rực rỡ v&agrave; sự thanh tho&aacute;t, đ&atilde; trở th&agrave;nh một phần kh&ocirc;ng thể thiếu trong văn h&oacute;a phong thủy. Từ những hồ c&aacute; ngo&agrave;i trời đến c&aacute;c bể c&aacute; mini trong nh&agrave;, sự hiện diện của c&aacute; Koi kh&ocirc;ng chỉ mang lại vẻ đẹp m&agrave; c&ograve;n được coi l&agrave; một nguồn năng lượng t&iacute;ch cực, gi&uacute;p thu h&uacute;t may mắn v&agrave; t&agrave;i lộc cho gia chủ.</em></p>
<h4 style="text-align: center;">&nbsp;</h4>
<h4 style="text-align: center;"><em><strong>Sự H&agrave;i H&ograve;a Trong Kh&ocirc;ng Gian Sống</strong></em></h4>
<p>Phong thủy nhấn mạnh sự quan trọng của việc tạo ra sự h&agrave;i h&ograve;a giữa con người v&agrave; m&ocirc;i trường xung quanh. C&aacute; Koi, với h&igrave;nh d&aacute;ng v&agrave; m&agrave;u sắc đa dạng, c&oacute; thể tạo ra sự c&acirc;n bằng trong kh&ocirc;ng gian sống. Khi kết hợp c&aacute; Koi với nước, c&acirc;y cỏ, v&agrave; đ&aacute;, ch&uacute;ng tạo th&agrave;nh một bức tranh phong thủy h&agrave;i h&ograve;a, gi&uacute;p tăng cường d&ograve;ng chảy của năng lượng t&iacute;ch cực trong gia đ&igrave;nh.</p>
<h4 style="text-align: center;"><img src="https://zenkoifarm.vn/wp-content/uploads/ho-ca-koi-trong-phong-khach.jpg.webp" alt="Hồ C&aacute; Koi Trong Ph&ograve;ng Kh&aacute;ch: Ưu Điểm V&agrave; 35 Mẫu Thiết Kế Si&ecirc;u Ấn Tượng - Zen  Koi Garden"></h4>
<h4 style="text-align: center;"><em><strong>C&aacute; Koi v&agrave; D&ograve;ng Nước T&agrave;i Lộc</strong></em></h4>
<p>Trong phong thủy, nước l&agrave; một yếu tố cực kỳ quan trọng, đại diện cho sự thịnh vượng v&agrave; t&agrave;i lộc. Hồ c&aacute; Koi kh&ocirc;ng chỉ l&agrave; nơi sống của những ch&uacute; c&aacute; xinh đẹp m&agrave; c&ograve;n được coi l&agrave; "d&ograve;ng chảy" của t&agrave;i lộc. Việc nu&ocirc;i c&aacute; Koi trong hồ nước c&oacute; thể được xem như một c&aacute;ch thu h&uacute;t t&agrave;i lộc v&agrave;o ng&ocirc;i nh&agrave;. Hơn nữa, &acirc;m thanh dịu nhẹ của nước chảy sẽ mang lại cảm gi&aacute;c b&igrave;nh y&ecirc;n, gi&uacute;p gia chủ giảm stress v&agrave; t&igrave;m thấy sự tĩnh lặng trong cuộc sống.</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://i.pinimg.com/564x/f0/68/d9/f068d9524c85ed69a3cbfd5eed1c8d02.jpg"></p>
<h4 style="text-align: center;">&nbsp;</h4>
<h4 style="text-align: center;"><em><strong>C&aacute; Koi v&agrave; T&iacute;nh Biểu Tượng Trong Văn H&oacute;a</strong></em></h4>
<p>C&aacute; Koi kh&ocirc;ng chỉ được y&ecirc;u th&iacute;ch trong phong thủy m&agrave; c&ograve;n mang một &yacute; nghĩa văn h&oacute;a s&acirc;u sắc trong nhiều nền văn h&oacute;a ch&acirc;u &Aacute;. Ở Nhật Bản, c&aacute; Koi được coi l&agrave; biểu tượng của sức mạnh, sự ki&ecirc;n tr&igrave; v&agrave; quyết t&acirc;m. Truyền thuyết kể rằng c&aacute; Koi bơi ngược d&ograve;ng s&ocirc;ng v&agrave; vượt qua nhiều thử th&aacute;ch để h&oacute;a th&agrave;nh rồng. Ch&iacute;nh v&igrave; vậy, c&aacute; Koi tượng trưng cho sự ki&ecirc;n tr&igrave;, bền bỉ v&agrave; khả năng vượt qua mọi kh&oacute; khăn trong cuộc sống.</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://i.pinimg.com/564x/72/1c/cd/721ccd91313dd5df221c26d099d50188.jpg"></p>
<h4 style="text-align: center;">&nbsp;</h4>
<h4 style="text-align: center;"><em><strong>C&aacute; Koi v&agrave; Năng Lượng T&iacute;ch Cực</strong></em></h4>
<p>Sự hiện diện của c&aacute; Koi trong kh&ocirc;ng gian sống kh&ocirc;ng chỉ mang lại vẻ đẹp thẩm mỹ m&agrave; c&ograve;n l&agrave;m tăng cường năng lượng t&iacute;ch cực. Theo phong thủy, việc nu&ocirc;i c&aacute; Koi sẽ gi&uacute;p cải thiện bầu kh&ocirc;ng kh&iacute; xung quanh, tạo ra sự thư gi&atilde;n v&agrave; y&ecirc;n b&igrave;nh cho cả gia đ&igrave;nh. C&aacute; Koi cũng được xem l&agrave; một phương tiện kết nối giữa con người với thi&ecirc;n nhi&ecirc;n, gi&uacute;p gia chủ cảm nhận được sự sống động v&agrave; sức mạnh của tự nhi&ecirc;n.</p>
<p>&nbsp;</p>
<h4 style="text-align: center;"><strong>Kết Luận</strong></h4>
<p>C&aacute; Koi kh&ocirc;ng chỉ đơn thuần l&agrave; một lo&agrave;i c&aacute; cảnh m&agrave; c&ograve;n l&agrave; biểu tượng phong thủy mang lại sự thịnh vượng, h&ograve;a b&igrave;nh v&agrave; hạnh ph&uacute;c. Việc đưa c&aacute; Koi v&agrave;o kh&ocirc;ng gian sống kh&ocirc;ng chỉ gi&uacute;p tạo n&ecirc;n một m&ocirc;i trường đẹp mắt m&agrave; c&ograve;n g&oacute;p phần cải thiện vận may v&agrave; t&agrave;i lộc cho gia đ&igrave;nh. H&atilde;y để c&aacute; Koi trở th&agrave;nh một phần quan trọng trong cuộc sống của bạn, mang lại sự b&igrave;nh an v&agrave; hạnh ph&uacute;c cho gia đ&igrave;nh.</p>', N'Published')
GO
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Bạc')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Cam')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Đen')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Đỏ')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Nâu')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Trắng')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Vàng')
INSERT [dbo].[Color] ([ColorID]) VALUES (N'Xanh lục')
GO
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Bắc')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Đông')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Đông Bắc')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Đông Nam')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Nam')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Tây')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Tây Bắc')
INSERT [dbo].[Direction] ([DirectionID]) VALUES (N'Tây Nam')
GO
INSERT [dbo].[Element] ([ElementID], [Mutualism]) VALUES (N'Hỏa', N'Mộc')
INSERT [dbo].[Element] ([ElementID], [Mutualism]) VALUES (N'Kim', N'Thổ')
INSERT [dbo].[Element] ([ElementID], [Mutualism]) VALUES (N'Mộc', N'Thủy')
INSERT [dbo].[Element] ([ElementID], [Mutualism]) VALUES (N'Thổ', N'Hỏa')
INSERT [dbo].[Element] ([ElementID], [Mutualism]) VALUES (N'Thủy', N'Kim')
GO
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Bạc', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Cam', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Đen', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Đỏ', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Nâu', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Trắng', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Vàng', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Hỏa', N'Xanh lục', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Bạc', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Cam', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Đen', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Đỏ', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Nâu', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Trắng', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Vàng', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Kim', N'Xanh lục', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Bạc', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Cam', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Đen', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Đỏ', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Nâu', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Trắng', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Vàng', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Mộc', N'Xanh lục', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Bạc', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Cam', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Đen', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Đỏ', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Nâu', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Trắng', 0.5)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Vàng', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thổ', N'Xanh lục', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Bạc', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Cam', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Đen', 0.75)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Đỏ', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Nâu', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Trắng', 1)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Vàng', 0.25)
INSERT [dbo].[Element_Color] ([ElementID], [ColorID], [ColorPoint]) VALUES (N'Thủy', N'Xanh lục', 0.5)
GO
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB001', N'vị trí thoáng,cá nhiều,cà phê sữa ngon,có khu vui chơi dành cho trẻ e.', N'AD081', 5, N'hau')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB002', N'chú bảo vệ rất nhiệt tình ', N'AD081', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB003', N'Cá tuyệt đẹp . Nuôi trại lớn được đầu tư cực kì bài bản
', N'AD723', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB004', N'Mấy dòng khác khá đẹp nhưng kohaku hơi cam ko dc đỏ', N'AD189', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB005', N'Cá KOI siêu to khổng lồ, ngắm rất thích. Nhưng chỗ này không phải quán cafe, mà chuyên trưng bày và bán cá KOI là chủ yếu. Khách có thể vào nghỉ ngơi uống cafe xem cá nhưng thức uống chỉ có cafe, nước cam và chanh dây.', N'AD363', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB006', N'Đã được qua xem thực tế, thực sự rất đẹp. Mấy bé rất chất lượng. Dịch vụ rất okila
', N'AD363', 5, N'khoa')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB007', N'Trang trí hồ cá rất đẹp, shop bán hàng uy tín, anh chủ dễ thương nhiệt tình 🥰🥰 …', N'AD820', 5, N'after')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB008', N'Dịch vụ rất tốt , làm việc sạch sẽ gọn gàng . Nhân viên thân thiện . Lần sau cần đến sẽ tiếp tục sử dụng dịch vụ bên mình . Cảm thấy hài lòng .', N'AD820', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB009', N'một sự hợp tác tuyệt vời ', N'AD126', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB010', N'cá koi phong phú nhiều màu sắc, nhân viên nhiệt tình.', N'AD126', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB011', N'chất lượng tốt ', N'AD997', 5, N'hau')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB012', N'cá koi phong phú, nhiều màu sắc rực rỡ.', N'AD997', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB013', N'quy trình làm việc chuyên nghiệp', N'AD483', 5, N'khoa')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB014', N' Chương trình khuyến mãi hấp dẫn, giảm giá 20% cho cám cá Koi. Đây là cơ hội tốt cho những ai nuôi cá Koi, giúp tiết kiệm chi phí.', N'AD759', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB015', N'loại cám dành cho cá koi chất lượng cao, giá thành hợp lí', N'AD483', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB016', N'Dịch vụ thiết kế và thi công hồ cá Koi mini rất phù hợp cho những không gian nhỏ. Thông tin chi tiết về dịch vụ sẽ giúp khách hàng dễ dàng lựa chọn.', N'AD483', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB017', N'hình dáng của hồ khi nhìn từ bên ngoài rất đẹp ', N'AD419', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB018', N'Cung cấp cá Koi Nhật Bản chất lượng, phù hợp cho những ai đang tìm kiếm cá Koi đẹp và khỏe mạnh.', N'AD065', 5, N'hau')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB019', N'Cung cấp cá Koi chất lượng cao không chỉ thu hút những người nuôi cá mà còn là cơ hội cho những nhà đầu tư trong lĩnh vực cá cảnh.', N'AD762', 5, N'khoa')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB020', N'Dịch vụ thiết kế hồ cá Koi tại Sơn La mở rộng cơ hội cho những người yêu thích cá Koi ở khu vực này. Cần thêm thông tin về chất lượng dịch vụ.', N'AD083', 5, N'khoa')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB021', N'Dịch vụ này không chỉ mang lại giá trị thẩm mỹ mà còn tạo ra một môi trường sống lý tưởng cho cá Koi, giúp chúng phát triển khỏe mạnh.', N'AD551', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB022', N'Cung cấp cá Koi Nhật Bản chất lượng, phù hợp cho những ai đang tìm kiếm cá Koi đẹp và khỏe mạnh.', N'AD551', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB023', N'Cung cấp cá Koi chất lượng cao không chỉ thu hút những người nuôi cá mà còn là cơ hội cho những nhà đầu tư trong lĩnh vực cá cảnh.', N'AD419', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB024', N'Trang trại này có thể tổ chức các sự kiện hoặc hội thảo về chăm sóc cá Koi, giúp người nuôi có thêm kiến thức và kinh nghiệm.', N'AD065', 5, N'hau')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB025', N'Trang trại Koi hàng đầu, có thể cung cấp nhiều loại cá Koi khác nhau. Thông tin chi tiết sẽ giúp khách hàng hiểu rõ hơn về sản phẩm.', N'AD065', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB026', N'Một địa điểm thú vị để thư giãn và thưởng thức cà phê trong không gian có cá Koi. Rất thích hợp cho những ai yêu thích thiên nhiên.', N'AD762', 5, N'after')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB027', N'Không gian quán cà phê không chỉ đẹp mà còn mang lại cảm giác thư giãn, giúp khách hàng thoát khỏi nhịp sống hối hả hàng ngày.
', N'AD762', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB028', N'Trang trại này có thể cung cấp dịch vụ tư vấn cho những người mới bắt đầu nuôi cá Koi, giúp họ có những lựa chọn đúng đắn ngay từ đầu.
', N'AD083', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB029', N'Trang trại cá Koi lớn, cung cấp nhiều loại cá Koi cho khách hàng. Đây là điểm đến lý tưởng cho những người yêu thích cá Koi tại Hà Nội.', N'AD083', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB030', N' Không gian thư giãn với cá Koi, rất thích hợp cho những buổi gặp gỡ bạn bè hoặc gia đình. Cần thêm thông tin về menu và dịch vụ.', N'AD004', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB031', N'Không gian thư giãn này có thể trở thành điểm đến lý tưởng cho các buổi hẹn hò hoặc gặp gỡ bạn bè, tạo ra những kỷ niệm đáng nhớ.
', N'AD878', 5, N'khoa')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB032', N' Sử dụng đá tự nhiên, cây thủy sinh và các yếu tố tự nhiên khác để tạo ra một môi trường sống gần gũi với thiên nhiên. Cây cối không chỉ làm đẹp mà còn giúp cải thiện chất lượng nước.', N'AD878', 5, N'tin')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB033', N' Ánh sáng cũng rất quan trọng; sử dụng đèn LED dưới nước có thể tạo ra hiệu ứng lung linh, làm nổi bật vẻ đẹp của cá và cảnh quan xung quanh.', N'AD551', 5, N'huy')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB034', N'Quán cafe koi là một không gian lý tưởng để thư giãn và thưởng thức cà phê trong khi ngắm nhìn những chú cá koi bơi lội. Để tạo ra một quán cafe koi hấp dẫn, bạn nên xem xét các yếu tố ', N'AD551', 5, N'nhan')
INSERT [dbo].[Feedback] ([FbID], [Description], [AdID], [Rate], [UserID]) VALUES (N'FB035', N'Không gian quán nên được thiết kế mở, với nhiều cửa sổ để khách hàng có thể dễ dàng nhìn thấy hồ cá. Sử dụng các vật liệu tự nhiên như gỗ và đá để tạo cảm giác gần gũi và ấm cúng.', N'AD551', 5, N'khoa')
GO
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Asagi', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/asagi.jpg?alt=media&token=d7db3c27-ead9-422a-9277-09e0ee7ab66b', N'Thủy', N'Asagi chính là giống sản sinh ra Nishikigoi, chúng bắt nguồn từ loài cá chép đen thường sinh sống ở những vùng sông hoặc suối, những chú cá chép đen có sự tiến hóa vượt bậc và được người dân Nhật chọn lựa những chú cá có màu sắc như Trắng, Xanh dương và màu đỏ và giữ lại trong hồ.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Beni Kumonryu', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Beni_Kumonryu.jpg?alt=media&token=de20399f-5096-4b07-9de0-ff67e850ab0f', N'Hỏa', N'Koi Beni Kumonryu là một biến thể hiếm hoi của Kumonryu, chúng thường có ba màu là đỏ, đen và trắng.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Gin Rin Yamato Nishiki', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/GinRinYamatoNishiKi.jpg?alt=media&token=d452d1c9-15ec-4dcf-8217-a2927639a9b5', N'Hỏa', N'Gin Rin Yamato nishiki koi là loài cá được lai tạo khoảng thời gian sau này của giống koi sanke. Có thể nói cá koi yamato nishiki giúp vẻ đẹp màu sắc Gin Rin tiến đến một tầm mới hơn khi phủ lên mình cá một lớp ánh kim loại lấp lánh.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Ginrin Chagoi', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/GinrinChagoi.jpg?alt=media&token=285e08f0-138c-43b9-a0cb-cc7e726b913e', N'Thổ', N'Ginrin Chagoi luôn chiếm được sự yêu thích từ người chơi cá koi. Chagoi biểu tượng cho sự mạnh mẽ, dũng cảm, sẵn sàng đương đầu với thử thách để đạt được thành công.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Goromo', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Goromo.png?alt=media&token=0b9a627a-15c0-45e3-bdde-b28c0167b48e', N'Hỏa', N'Cá koi Goromo là kết quả lai tạo tình cờ giữa một con cá koi kohaku, một con Sanke hoặc một con Showa với một con cá koi Asagi. Bình thường việc lai tạo các giống koi trên với koi asagi chỉ tạo ra koi Goshiki. Chính vì đặc điểm này mà cá koi mới được đặt tên là “Goromo” – nghĩa tiếng Nhật là “được khoác áo”. Thực chất Goromo chỉ là tên rút gọn, tên đầy đủ của dòng koi Goromo này phải là Ai Goromo có nghĩa là “ được khoác áo màu xanh Indigo”.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Goshiki', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Goshiki.png?alt=media&token=ddeb6a75-4836-4fb1-889c-6fcbc401e116', N'Hỏa', N'Cá koi Goshiki là kết quả lai tạo thành công hai giống cá koi phổ biến asagi và cá koi kohaku. Có thể nói cá koi Goshiki là một con kohaku với lớp vẩy caro màu đen ấn tượng trên lưng làm nổi bật những mảng màu đỏ (hi) vốn có của giống kohaku. Từ Goshiki có nghĩa là ngũ sắc các nhà tạo giống rất yêu thích và ấn tượng với giống cá này bởi màu sắc nó khá phong phú và đẹp mắt.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Hariwake', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Hariwake.jpg?alt=media&token=0def0060-9144-4fb2-95bb-1768f97ac892', N'Thổ', N'Hariwake là một trong những dòng cá koi vàng được yêu thích nhất với màu sắc vàng rực rỡ bao phủ trên toàn thân. Điểm nổi bật của dòng cá koi này là chúng có các đốm vàng trên lưng và cánh tay của nó. Koi hariwake được coi là biểu tượng của sự giàu có và thịnh vượng theo văn hóa Nhật Bản.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Hi Utsuri', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Hi_Utsuri.png?alt=media&token=a93b59a0-6244-4b26-8f60-e17d61ce0224', N'Hỏa', N'Koi utsuri có điểm đặc trưng là những bệt màu tạo thành vệt hoặc khoang màu lớn trên màu nền đen của chúng.Tại phần đầu của cá koi utsuri luôn có những mảng hoặc vệt màu đen. Các mảng đen trên mình koi utsuri có thể là mảng lớn, chấm nhỏ hoặc vệt uốn lượn theo chiều ngang')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Ki Utsuri', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Ki_Utsuri.png?alt=media&token=08ab8319-0528-4192-9ff9-d0b4f6339335', N'Thổ', N'Koi utsuri có điểm đặc trưng là những bệt màu tạo thành vệt hoặc khoang màu lớn trên màu nền đen của chúng.Tại phần đầu của cá koi utsuri luôn có những mảng hoặc vệt màu đen. Các mảng đen trên mình koi utsuri có thể là mảng lớn, chấm nhỏ hoặc vệt uốn lượn theo chiều ngang')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Kikokuryu', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Kikokuryu.jpg?alt=media&token=5fa72317-49dc-4b13-8e16-36e18ddba4d5', N'Kim', N'Cá Kikokuryu thực chất là một Kumonryu kim loại, một con cá koi với làn da bạch kim sáng bóng và vây với màu sắc Sumi sâu trong suốt. Dòng Koi  sẽ không có 2 con nào giống nhau vì chúng rất hiếm được thấy trên thị trường.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Kikusui', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Kikusui.png?alt=media&token=5b61de72-a43d-46c8-9bea-d7c8050e79a2', N'Kim', N'Cá koi Kikusui về cơ bản là một phiên bản Doitsu của koi Hariwake, là một con koi kim loại, hai màu với màu cơ bản là trắng và hoa văn màu đỏ, cam hoặc vàng trên nền màu trắng . Kikusui cũng thường được mô tả là koi kim loại, Doitsu Kohaku koi vì nó là một con koi trắng, không vảy với hoa văn màu đỏ trên nền trắng và một lớp ánh sáng phản chiếu, hoặc bóng, trên da của cá koi.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Kin Kikokuryu', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/KinKikokuryu.jpg?alt=media&token=d57682d4-1319-4e94-b342-b8bc580df9a4', N'Thủy', N' Kin Kikokuryu kết hợp màu da cam hoặc màu vàng với các mẫu màu đen và trắng của Kikokuryu để tạo thành loại koi mới nhất trong họ cá Koi.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Kohaku', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/kohaku.jpg?alt=media&token=2852ec60-9b7b-4b86-9448-5ea5ccf872b8', N'Hỏa', N'Kohaku – dòng cá kết hợp tương phản giữa 2 màu trắng(Shiroji) và đỏ (Hi) đã tạo nên vẻ đẹp đơn giản không chỉ phổ biến nhất, đẹp nhất mà còn luôn tiềm ẩn khả năng trở thành chủng cá có giá trị cao nhất trong các dòng cá Koi.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Kujaku', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Kujaku.png?alt=media&token=570bb692-99eb-4b8e-81ba-3577a68524f5', N'Kim', N'Cá Koi KujaKu là một trong những dòng cá Koi nổi bật bởi sở hữu bộ vảy ánh bạc nền đen pha lẫn các dãy màu đỏ vô cùng kiêu hãnh và bắt mắt. Trong vài năm gần đây, Kujaku đang ngày càng gây được sự chú ý lớn tại Việt Nam, trở thành giống cá được nhiều người yêu Koi tìm kiếm.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Kumonryu', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/kumonryu.png?alt=media&token=87737e14-d431-4169-b570-3428e2a8eb10', N'Kim', N'Kumonryu là koi Doitsu có hoa văn màu đen như mực nổi lên như những đám mây sấm đen cuồn cuộn trên nền tuyết trắng. Một con Koi Ben Kumonryu được đánh giá là đẹp khi có sự tương xứng và cân bằng giữa các màu đỏ, đen và trắng trên thân của nó.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Matsuba', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/matsubaKOI.png?alt=media&token=2ea65ebd-52f5-420e-8b00-96351367e72d', N'Kim', N'Koi Matsuba là những con cá đơn sắc. Giống cá này thường có 3 màu chủ yếu là màu trắng bạc, màu vàng hoặc màu đỏ cam. Matsuba là cá koi màu kim loại với hoạ tiết lưới màu đen. Cơ thể của cá koi Matsuba có một màu với vảy hình nón rỗng')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Midorigoi', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Midorigoi.jpg?alt=media&token=2c919b0f-0683-4fbe-8a85-d094dc490d0d', N'Mộc', N'Midorigoi có màu xanh lục nhạt phủ toàn thân, với các vảy đều đặn và bóng loáng. Màu sắc chủ đạo là xanh lục, bao gồm cả vây và đuôi. Cá này có thể thuộc dòng Koi Ogon, đặc trưng bởi màu đơn sắc và sự bóng bẩy của lớp vảy.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Ochiba Shigure', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/ochibaSigure.jpg?alt=media&token=3edd0243-470a-4602-bc93-1d13bd73fef4', N'Kim', N'Ochiba là giống cá Koi được lai tạo như một sự kết hợp của Chagoi và Kohaku. Trong tiếng Anh, thuật ngữ Nhật Bản dịch gần như là là mùa thu trên mặt nước. Điều này thể hiện màu sắc ánh kim loại trên mình cá Ochiba.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Ogon', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/ogon.jpg?alt=media&token=1b828fe4-d82d-45ca-a97f-bb40934babb6', N'Thổ', N'Cá Koi Ogon được coi là một trong những giống cá Koi đẹp nhất và độc đáo nhất trên trái đất với ngoại hình đặc trưng là màu vàng óng ánh rực rỡ.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/shiro-utsuri.jpg?alt=media&token=7b489331-66f6-48e6-98ef-55a7ba49cecb', N'Kim', N'Cá koi utsuri được lai tạo sao cho thân mình của chúng thường chỉ có hai màu, trong đó màu đen (sumi) chiếm tỷ lệ nhỏ hơn, tạo thành các bệt đen (vết đen) trên thân cá.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Showa Sanshoku', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/showa_sanshoku.jpg?alt=media&token=d181dd06-ec05-47db-9f74-0a38c38a6c1b', N'Kim', N'Mặc dù tất cả các Showa phải sở hữu làn da đen (gọi là Sumi) được bao phủ bởi các dấu hiệu từ đỏ đến đỏ cam (Hi) và trắng (Shiroji) trên đó, có rất nhiều giống Showa khác nhau bao gồm các loại hoa văn và cách sắp xếp khác nhau.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Shusui', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/shusui.png?alt=media&token=fcf3508e-d4ed-4121-b1d3-8dc5cbcfa24f', N'Kim', N'Cá koi Shusui là một trong những giống cá chép đẹp và độc đáo nhất trong thế giới cá cảnh. Với thiết kế hai mảng vẩy lớn sậm màu trải dài từ vai xuống lưng, cá koi Shusui thực sự là một tác phẩm nghệ thuật sống đầy ấn tượng')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Soragoi', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Soragoi.png?alt=media&token=97dc3872-e1f0-4888-86e1-d416518dc8d2', N'Kim', N'Cá koi Soragoi (SOH-rog-GOY) là những con koi xám đơn màu thường có dạng lưới trên vảy của chúng được gọi là fukurin (FOO-koo-REEN).Do đó, hầu hết cá koi Soragoi đều có tiềm năng là cá koi rất lớn và thường hướng về thức ăn hơn các loại koi khác. Điều này rất tốt cho người nuôi cá koi vì nó có nghĩa là Soragoi và Chagoi, koi sẽ thường đến chào đón bạn ở đầu ao với hy vọng được cho ăn và bất kỳ con cá nào khác trong ao sẽ đi theo chúng!')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Taisho Sanke', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/TaishoSanke.jpg?alt=media&token=7cac13dc-a205-4d75-b2e3-318ba65996b0', N'Kim', N' Koi Taisho Sanke là một trong số 2 dòng chính được lai tạo từ cá chép hoang dã Magoi cổ xưa tại Nhật Bản.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Tancho Kohaku', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Ki_Utsuri.png?alt=media&token=08ab8319-0528-4192-9ff9-d0b4f6339335', N'Kim', N'Koi tancho kohaku chính là “quốc kì sống” của đất nước Nhật Bản, chúng có thân mình và phần bụng màu trắng muốt như tuyết, tất cả các vây cũng màu trắng và chỉ có duy nhất một chấm màu đỏ lớn ở trên đầu. Đây cũng là loại cá koi Tancho được nhiều người biết đến và ao ước được sở hữu nhất.')
INSERT [dbo].[Koi_Variety] ([KoiType], [Image], [Element], [Description]) VALUES (N'Ushutimono', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Ushutimono.jpg?alt=media&token=c200e681-db87-4dc2-b7fc-fdbbeb071944', N'Mộc', N'Ushutimono có màu xanh chiếm phần lớn cơ thể, với các vảy màu trắng xen kẽ. Hoa văn của vảy tạo ra sự tương phản rõ rệt giữa màu xanh và trắng, với màu xanh nổi bật hơn, bao phủ phần lớn thân cá. Các vây và đuôi cũng có màu xanh nhẹ. Cá này có thể là một biến thể của dòng Koi có sự pha trộn mạnh mẽ giữa hai màu xanh và trắng.')
GO
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Càn')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Cấn')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Chấn')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Đoài')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Khảm')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Khôn')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Ly')
INSERT [dbo].[LifePalace] ([LifePalaceID]) VALUES (N'Tốn')
GO
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Bắc', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Đông', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Đông Bắc', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Đông Nam', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Nam', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Tây', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Tây Bắc', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Càn', N'Tây Nam', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Bắc', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Đông', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Đông Bắc', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Đông Nam', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Nam', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Tây', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Tây Bắc', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Cấn', N'Tây Nam', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Bắc', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Đông', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Đông Bắc', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Đông Nam', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Nam', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Tây', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Tây Bắc', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Chấn', N'Tây Nam', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Bắc', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Đông', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Đông Bắc', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Đông Nam', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Nam', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Tây', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Tây Bắc', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Đoài', N'Tây Nam', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Bắc', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Đông', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Đông Bắc', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Đông Nam', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Nam', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Tây', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Tây Bắc', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khảm', N'Tây Nam', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Bắc', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Đông', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Đông Bắc', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Đông Nam', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Nam', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Tây', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Tây Bắc', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Khôn', N'Tây Nam', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Bắc', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Đông', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Đông Bắc', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Đông Nam', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Nam', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Tây', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Tây Bắc', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Ly', N'Tây Nam', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Bắc', N'Sinh khí', 1, N'Đây là hướng mang lại may mắn nhất cho chủ nhà và tạo ra khí tốt.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Đông', N'Diên niên', 0.75, N'Hướng mang đến sự hòa thuận, thúc đẩy sự nghiệp và gia tăng tuổi thọ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Đông Bắc', N'Tuyệt mệnh', 0.25, N'Hướng không tốt cho sự phát triển, gây ra bất hòa và đau buồn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Đông Nam', N'Phục vị', 0.5, N'Hướng giúp cải thiện quan hệ gia đình và mang lại bình yên.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Nam', N'Thiên y', 1, N'Đây là hướng tập trung vào sức khỏe, có thể giảm bớt bệnh tật và mang lại sự thịnh vượng.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Tây', N'Lục sát', 0.25, N'Hướng dễ hao tài, tốn của và thành viên trong gia đình gặp rủi ro, tai nạn.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Tây Bắc', N'Họa hại', 0, N'Hướng ảnh hưởng không tốt đến sức khỏe và gây rủi ro cho gia chủ.')
INSERT [dbo].[LifePalace_Direction] ([LifePalaceID], [DirectionID], [EightMansions], [PointOfDirection], [Description]) VALUES (N'Tốn', N'Tây Nam', N'Ngũ quỷ', 0.25, N'Hướng gây trở ngại trong quan hệ tình cảm và có nhiều thử thách, bệnh tật.')
GO
INSERT [dbo].[Member] ([Name], [Birthday], [UserID]) VALUES (N'After Huỳnh', CAST(N'2000-10-20' AS Date), N'after')
INSERT [dbo].[Member] ([Name], [Birthday], [UserID]) VALUES (N'Nguyễn Trung Tài', CAST(N'2005-08-19' AS Date), N'tai')
GO
INSERT [dbo].[Package] ([Rank], [Duration], [Description], [price]) VALUES (N'Diamond', 30, N'Hình ảnh lớn, xuất hiện ở đầu trang, tần suất xuất hiện nhiều, phù hợp với các doanh nghiệp lớn muốn quảng bá mạnh mẽ.', 6000000)
INSERT [dbo].[Package] ([Rank], [Duration], [Description], [price]) VALUES (N'Gold', 30, N'Hình ảnh vừa, xuất hiện ở dưới gói Dimond, tần suất xuất hiện vừa, phù hợp với doanh nghiệp vừa và nhỏ muốn có sự hiện diện ổn định.', 4000000)
INSERT [dbo].[Package] ([Rank], [Duration], [Description], [price]) VALUES (N'Silver', 30, N'Hình ảnh nhỏ, chỉ xuất hiện ở trang đăng tin, tần suất xuất hiện ít, phù hợp với doanh nghiệp cá nhân hoặc startup muốn tiết kiệm chi phí.', 2000000)
GO
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (1, N'Hỏa', N'Hình chữ nhật')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Hỏa', N'Hình lượn sóng')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.75, N'Hỏa', N'Hình tam giác')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Hỏa', N'Hình tròn')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.5, N'Hỏa', N'Hình vuông')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Kim', N'Hình chữ nhật')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.5, N'Kim', N'Hình lượn sóng')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Kim', N'Hình tam giác')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.75, N'Kim', N'Hình tròn')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (1, N'Kim', N'Hình vuông')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.75, N'Mộc', N'Hình chữ nhật')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (1, N'Mộc', N'Hình lượn sóng')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.5, N'Mộc', N'Hình tam giác')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Mộc', N'Hình tròn')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Mộc', N'Hình vuông')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Thổ', N'Hình chữ nhật')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Thổ', N'Hình lượn sóng')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (1, N'Thổ', N'Hình tam giác')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.5, N'Thổ', N'Hình tròn')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.75, N'Thổ', N'Hình vuông')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.5, N'Thủy', N'Hình chữ nhật')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.75, N'Thủy', N'Hình lượn sóng')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Thủy', N'Hình tam giác')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (1, N'Thủy', N'Hình tròn')
INSERT [dbo].[PointOfShape] ([Point], [ElementID], [ShapeID]) VALUES (0.25, N'Thủy', N'Hình vuông')
GO
INSERT [dbo].[QuantityOfFish] ([ElementID], [Description]) VALUES (N'Hỏa', N'Phù hợp nuôi số lượng cá có hàng đơn vị là 2 hoặc 7. VD: 2 con, 12 con, 7 con, 27 con,...')
INSERT [dbo].[QuantityOfFish] ([ElementID], [Description]) VALUES (N'Kim', N'Phù hợp nuôi số lượng cá có hàng đơn vị là 4 hoặc 9. VD: 4 con, 14 con, 9 con, 29 con,...')
INSERT [dbo].[QuantityOfFish] ([ElementID], [Description]) VALUES (N'Mộc', N'Phù hợp nuôi số lượng cá có hàng đơn vị là 3 hoặc 8. VD: 3 con, 13 con, 8 con, 28 con,...')
INSERT [dbo].[QuantityOfFish] ([ElementID], [Description]) VALUES (N'Thổ', N'Phù hợp nuôi số lượng cá có hàng đơn vị là 5 hoặc 0. VD: 10 con, 5 con, 15 con,...')
INSERT [dbo].[QuantityOfFish] ([ElementID], [Description]) VALUES (N'Thủy', N'Phù hợp nuôi số lượng cá có hàng đơn vị là 1 hoặc 6. VD: 1 con, 11 con, 6 con, 26 con,...')
GO
INSERT [dbo].[Shape] ([ShapeID], [image]) VALUES (N'Hình chữ nhật', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/hinhchunhat.jpg?alt=media&token=07ddfbd1-a983-410a-822b-686657f9efd3')
INSERT [dbo].[Shape] ([ShapeID], [image]) VALUES (N'Hình lượn sóng', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/hinhluonsong.jpg?alt=media&token=70cbce4c-2c65-445d-9a4e-99744da6de1b')
INSERT [dbo].[Shape] ([ShapeID], [image]) VALUES (N'Hình tam giác', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/triangular_pond.jpg?alt=media&token=29d51e03-094a-4ba9-a8f4-e5a46f0e2220')
INSERT [dbo].[Shape] ([ShapeID], [image]) VALUES (N'Hình tròn', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/hinhtron.jpg?alt=media&token=2fd87245-8ac5-4ab6-bbf0-e8bbdfcf02ef')
INSERT [dbo].[Shape] ([ShapeID], [image]) VALUES (N'Hình vuông', N'https://firebasestorage.googleapis.com/v0/b/swp391-koifengshuiconsult.appspot.com/o/Square.jpg?alt=media&token=fa0a092b-a091-4a79-be0b-11460e33e460')
GO
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Asagi', N'Đen', 0.5)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Asagi', N'Đỏ', 0.1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Asagi', N'Trắng', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Beni Kumonryu', N'Đen', 0.1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Beni Kumonryu', N'Đỏ', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Beni Kumonryu', N'Trắng', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Gin Rin Yamato Nishiki', N'Cam', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Gin Rin Yamato Nishiki', N'Đen', 0.05)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Gin Rin Yamato Nishiki', N'Trắng', 0.25)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ginrin Chagoi', N'Nâu', 0.2)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ginrin Chagoi', N'Vàng', 0.8)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Goromo', N'Đỏ', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Goromo', N'Trắng', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Goshiki', N'Đen', 0.2)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Goshiki', N'Đỏ', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Goshiki', N'Trắng', 0.1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Hariwake', N'Trắng', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Hariwake', N'Vàng', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Hi Utsuri', N'Cam', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Hi Utsuri', N'Đen', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ki Utsuri', N'Đen', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ki Utsuri', N'Vàng', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kikokuryu', N'Đen', 0.2)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kikokuryu', N'Trắng', 0.8)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kikusui', N'Đỏ', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kikusui', N'Trắng', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kin Kikokuryu', N'Đen', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kin Kikokuryu', N'Trắng', 0.1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kin Kikokuryu', N'Vàng', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kohaku', N'Đỏ', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kohaku', N'Trắng', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kujaku', N'Bạc', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kujaku', N'Đen', 0.2)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kujaku', N'Đỏ', 0.2)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kumonryu', N'Đen', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Kumonryu', N'Trắng', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Matsuba', N'Đen', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Matsuba', N'Trắng', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Midorigoi', N'Xanh lục', 1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ochiba Shigure', N'Cam', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ochiba Shigure', N'Trắng', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ogon', N'Vàng', 1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Shiro Utsuri', N'Đen', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Shiro Utsuri', N'Trắng', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Showa Sanshoku', N'Đen', 0.1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Showa Sanshoku', N'Đỏ', 0.2)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Showa Sanshoku', N'Trắng', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Shusui', N'Đen', 0.4)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Shusui', N'Trắng', 0.6)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Soragoi', N'Trắng', 1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Taisho Sanke', N'Đen', 0.15)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Taisho Sanke', N'Đỏ', 0.15)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Taisho Sanke', N'Trắng', 0.7)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Tancho Kohaku', N'Đỏ', 0.1)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Tancho Kohaku', N'Trắng', 0.9)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ushutimono', N'Trắng', 0.3)
INSERT [dbo].[Type_Color] ([KoiType], [ColorID], [Percentage]) VALUES (N'Ushutimono', N'Xanh lục', 0.7)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__A9D10534DB62F89A]    Script Date: 31/10/2024 10:29:15 CH ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ads_Package]  WITH CHECK ADD FOREIGN KEY([AdID])
REFERENCES [dbo].[Advertisement] ([AdID])
GO
ALTER TABLE [dbo].[Ads_Package]  WITH CHECK ADD FOREIGN KEY([Rank])
REFERENCES [dbo].[Package] ([Rank])
GO
ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Member] ([UserID])
GO
ALTER TABLE [dbo].[Element_Color]  WITH CHECK ADD FOREIGN KEY([ColorID])
REFERENCES [dbo].[Color] ([ColorID])
GO
ALTER TABLE [dbo].[Element_Color]  WITH CHECK ADD FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([AdID])
REFERENCES [dbo].[Advertisement] ([AdID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Member] ([UserID])
GO
ALTER TABLE [dbo].[LifePalace_Direction]  WITH CHECK ADD FOREIGN KEY([DirectionID])
REFERENCES [dbo].[Direction] ([DirectionID])
GO
ALTER TABLE [dbo].[LifePalace_Direction]  WITH CHECK ADD FOREIGN KEY([LifePalaceID])
REFERENCES [dbo].[LifePalace] ([LifePalaceID])
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Account] ([UserID])
GO
ALTER TABLE [dbo].[PointOfShape]  WITH CHECK ADD FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[PointOfShape]  WITH CHECK ADD FOREIGN KEY([ShapeID])
REFERENCES [dbo].[Shape] ([ShapeID])
GO
ALTER TABLE [dbo].[QuantityOfFish]  WITH CHECK ADD FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[Type_Color]  WITH CHECK ADD FOREIGN KEY([ColorID])
REFERENCES [dbo].[Color] ([ColorID])
GO
ALTER TABLE [dbo].[Type_Color]  WITH CHECK ADD FOREIGN KEY([KoiType])
REFERENCES [dbo].[Koi_Variety] ([KoiType])
GO
USE [master]
GO
ALTER DATABASE [CN2301C_FengShuiKoiConsulting_DB] SET  READ_WRITE 
GO
