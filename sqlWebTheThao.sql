USE [master]
GO
/****** Object:  Database [WebTheThao]    Script Date: 12/6/2021 4:21:30 PM ******/
CREATE DATABASE [WebTheThao]
GO
USE [WebTheThao]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[idBill] [bigint] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[timeCreated] [datetime] NOT NULL,
	[recipientName] [nvarchar](50) NOT NULL,
	[recipientPhone] [varchar](15) NOT NULL,
	[recipientEmail] [varchar](50) NOT NULL,
	[recipientAddress] [nvarchar](150) NOT NULL,
	[note] [nvarchar](300) NULL,
 CONSTRAINT [PK__Bill__E6F93398B7C34B33] PRIMARY KEY CLUSTERED 
(
	[idBill] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillDetail]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDetail](
	[idBill] [bigint] NOT NULL,
	[idProduct] [int] NOT NULL,
	[productSize] [varchar](10) NOT NULL,
	[quantity] [tinyint] NOT NULL,
	[discount] [tinyint] NOT NULL,
	[totalPrice] [int] NOT NULL,
 CONSTRAINT [PK__BillDeta__E6F933984402E9D3] PRIMARY KEY CLUSTERED 
(
	[idBill] ASC,
	[idProduct] ASC,
	[productSize] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[idUser] [int] NOT NULL,
	[idProduct] [int] NOT NULL,
	[size] [varchar](10) NOT NULL,
	[quantity] [smallint] NOT NULL,
 CONSTRAINT [PK__Cart__3717C982F6D89DAC] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC,
	[idProduct] ASC,
	[size] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[img] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK__Category__3213E83F2C659E02] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[idProduct] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [tinyint] NOT NULL,
	[price] [int] NOT NULL,
	[decription] [nvarchar](1000) NOT NULL,
	[dateAdd] [date] NOT NULL,
	[discount] [smallint] NOT NULL,
 CONSTRAINT [PK__Product__5EEC79D1BB19186F] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImg]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImg](
	[idProduct] [int] NOT NULL,
	[source] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_ProductImg] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC,
	[source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductReview]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReview](
	[idBill] [bigint] NOT NULL,
	[idProduct] [int] NOT NULL,
	[productSize] [varchar](10) NOT NULL,
	[ratingScore] [smallint] NOT NULL,
	[contentText] [nvarchar](300) NOT NULL,
	[dateReview] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductReview_1] PRIMARY KEY CLUSTERED 
(
	[idBill] ASC,
	[idProduct] ASC,
	[productSize] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductStock]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStock](
	[idProduct] [int] NOT NULL,
	[size] [varchar](10) NOT NULL,
	[inStock] [smallint] NULL,
 CONSTRAINT [PK_ProductStock] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC,
	[size] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[idUser] [int] NOT NULL,
	[username] [varchar](20) NOT NULL,
	[pass] [varchar](20) NOT NULL,
	[idRole] [tinyint] NOT NULL,
 CONSTRAINT [PK__User__3213E83F69B026CE] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetail]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetail](
	[idUser] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[gender] [nvarchar](5) NULL,
	[birthday] [date] NULL,
	[address] [nvarchar](150) NULL,
	[imgAvatar] [nvarchar](150) NULL,
 CONSTRAINT [PK__UserDeta__3213E83FBCCDA9C6] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[idRole] [tinyint] NOT NULL,
	[roleName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK__UserRole__E5045C541FB98815] PRIMARY KEY CLUSTERED 
(
	[idRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlist]    Script Date: 12/6/2021 4:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlist](
	[idUser] [int] NOT NULL,
	[idProduct] [int] NOT NULL,
	[size] [varchar](10) NOT NULL,
 CONSTRAINT [PK__WishList__3717C982E65A176E] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC,
	[idProduct] ASC,
	[size] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (1, 2, CAST(N'2021-11-01T00:00:00.000' AS DateTime), N'Nguyễn Văn D', N'012345665', N'johnDoe@gmuil.com', N'66/1 Hai Bà Trưng, Phường 2, Quận Phú Nhuận, TP Hồ Chí Minh', N'Đến đèn đỏ gần nhà thuốc thì gọi em ạ')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (2, 2, CAST(N'2021-11-02T00:00:00.000' AS DateTime), N'Nguyễn Văn A', N'025102444', N'johnWick@gmuil.com', N'625/24/2 Lý Thường Kiệt, Phường 3, Quận 3, TP Hồ Chí Minh', N'Đến cây xăng sát chợ thì gọi em với ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (3, 3, CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'Nguyễn Văn D', N'021546265', N'johnHart@gmuil.com', N'21/15 Trường Chinh, Quận Đống Đa, Hà Nội', N'Điến cây cột điền gần điện máy xanh thì gọi em để em ra chỉ đường cho mấy anh vào nhé.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (5, 2, CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'Ưng Đình Chương', N'095554555', N'johnHarry@gmuil.com', N'28/14 Lý Thái Tổ, phường 2, quận Thanh Xuân, Hà Nội', N'Nếu ngày mai không có anh, ai sẽ đưa em về. Trời sắp đổ cơn mưa, sao anh còn đứng đó. Đứng đó chi cho ướt dậy cha nội.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (6, 3, CAST(N'2021-11-05T00:00:00.000' AS DateTime), N'Trọng Hiếu', N'021215021', N'johnMarc@gmuil.com', N'154/1 Lê Thánh Tông, phường Tân Thanh, Thị xã Nhơn Trạch, tỉnh Đồng Nai', N'Nhờ anh giao đến quầy tiếp tân rồi nói gửi cho Hiếu Đẹp Trai để chiều em về nhà em lấy với ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (7, 3, CAST(N'2021-11-06T00:00:00.000' AS DateTime), N'Nguyễn Văn B', N'085487114', N'johnChuong@gmuil.com', N'11/6 xã Xuân Đường, huyện Cẩm Mỹ, tỉnh Đồng Nai', N'Nếu mà ngày mai anh giao tới thì anh có thể giữ dùm em 2 ngày để em đi công tác về em lấy với ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (8, 3, CAST(N'2021-11-07T00:00:00.000' AS DateTime), N'Nguyễn Văn C', N'090289284', N'chuoaw@gmail.com', N'65 ấp Suối Cả, xã Long Giao, huyện Cẩm Mỹ, tỉnh Đồng Nai', N'Cho em cái quần jogger size lớn nhất với ạ, tại người em hơi to bự một tí. Em cám ơn shop nhiều ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (12, 3, CAST(N'2021-11-08T00:00:00.000' AS DateTime), N'Nguyễn Thị Mộng Hà', N'025555555', N'johnnyDang@gmuil.com', N'16/4 xã Xuân Đường, huyện Cẩm Mỹ, tỉnh Đồng Nai', N'Nếu mà ngày mai anh giao tới thì anh có thể giữ dùm em 2 ngày để em đi công tác về em lấy với ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (13, 3, CAST(N'2021-11-22T00:00:00.000' AS DateTime), N'Nguyễn Văn Lê Tí', N'021212541', N'minhtri@gmail.com', N'9 ấp Suối Cả, xã Long Giao, huyện Cẩm Mỹ, tỉnh Đồng Nai', N'Cho em cái quần jogger size lớn nhất với ạ, tại người em hơi to bự một tí. Em cám ơn shop nhiều ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (23, 4, CAST(N'2021-12-06T00:00:00.000' AS DateTime), N'ungDinhChuong', N'0923456781', N'uc291000@gmail.com', N'97 Man Thiện, Thành Phố Thủ Đức', N'')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (24, 4, CAST(N'2021-12-06T00:00:00.000' AS DateTime), N'ungDinhChuong', N'0923456781', N'uc291000@gmail.com', N'15 Man Thiện, Thành Phố Thủ Đức', N'Chuyển hàng sớm sớm cho em ạ.')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (28, 4, CAST(N'2021-12-06T00:00:00.000' AS DateTime), N'ungDinhChuong', N'0923456781', N'uc291000@gmail.com', N'abc', N'')
INSERT [dbo].[Bill] ([idBill], [idUser], [timeCreated], [recipientName], [recipientPhone], [recipientEmail], [recipientAddress], [note]) VALUES (38, 4, CAST(N'2021-12-06T00:00:00.000' AS DateTime), N'ungDinhChuong', N'0923456781', N'uc291000@gmail.com', N'107 Phạm Văn Đồng, Pleiku', N'')
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (1, 1, N'XL', 2, 15, 204000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (1, 4, N'XL', 1, 15, 102000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (1, 6, N'XL', 1, 10, 171000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (1, 32, N'XL', 1, 0, 320000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (2, 32, N'XL', 6, 0, 1920000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (2, 38, N'L', 1, 0, 320000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (3, 7, N'XL', 2, 0, 320000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (5, 41, N'L', 5, 0, 1600000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (6, 47, N'S', 3, 25, 612000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (7, 60, N'XS', 10, 0, 1600000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (8, 68, N'L', 3, 20, 432000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (12, 42, N'XXL', 2, 0, 640000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (12, 65, N'XXL', 5, 20, 780000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (13, 37, N'XL', 1, 0, 320000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (23, 1, N'L', 2, 15, 204000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (24, 5, N'L', 1, 10, 135000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (28, 9, N'L', 2, 10, 342000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (38, 38, N'L', 1, 0, 320000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (38, 38, N'XL', 2, 0, 640000)
INSERT [dbo].[BillDetail] ([idBill], [idProduct], [productSize], [quantity], [discount], [totalPrice]) VALUES (38, 41, N'XL', 1, 0, 320000)
GO
INSERT [dbo].[Cart] ([idUser], [idProduct], [size], [quantity]) VALUES (1, 24, N'L', 0)
INSERT [dbo].[Cart] ([idUser], [idProduct], [size], [quantity]) VALUES (2, 1, N'L', 1)
INSERT [dbo].[Cart] ([idUser], [idProduct], [size], [quantity]) VALUES (4, 38, N'L', 0)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name], [img]) VALUES (1, N'Đồ Bóng Đá', N'cate_football.png')
INSERT [dbo].[Category] ([id], [name], [img]) VALUES (2, N'Đồ Tập Gym', N'cate_gym.jpg')
INSERT [dbo].[Category] ([id], [name], [img]) VALUES (3, N'Đồ Trẻ Em', N'cate_kid.jpg')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (1, N'Áo đội tuyển Việt Nam đỏ (Sân nhà)', 1, 120000, N'Mẫu quần áo đội tuyển Việt Nam ở sân nhà, đây là mẫu quần áo mới nhất của đội tuyển.', CAST(N'2021-01-01' AS Date), 15)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (4, N'Áo đội tuyển Việt Nam trắng (Sân khách)', 1, 120000, N'Mẫu quần áo bóng đá đội tuyển Việt Nam sân khách, đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển', CAST(N'2021-01-01' AS Date), 15)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (5, N'Áo đội tuyển Tây Ban Nha đo (Sân nhà)', 1, 150000, N'Mẫu quần áo bóng đá đội tuyển Tây Ban Nha sân nhà , đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển:
Hàng VN: Giá lẻ: 90.000đ/1 bộ.
– Từ 10 bộ trở lên: 85.000đ/1 bộ.
Hàng Thái Lan F1: 200.000đ/1 áo – 260.000đ/1 bộ
– Từ 10 bộ trở lên: 250.000đ/1 bộ', CAST(N'2021-01-02' AS Date), 10)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (6, N'Áo đội tuyển Anh (Sân khách)', 1, 155000, N'Mẫu quần áo bóng đá đội tuyển Anh sân khách, đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển:
Hàng VN: Giá lẻ: 90.000đ/1 bộ.
– Từ 10 bộ trở lên: 85.000đ/1 bộ.
Hàng Thái Lan F1: 260.000đ/1 áo – 330.000đ/1 bộ
– Từ 10 bộ trở lên: 320.000đ/1 bộ', CAST(N'2021-01-02' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (7, N'Áo đội tuyển Bồ Đầu Nha sân nhà', 1, 160000, N'Mẫu quần áo bóng đá đội tuyển Bồ Đầu Nha sân nhà, đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển', CAST(N'2021-01-03' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (9, N'Áo đội tuyển Pháp sân khách', 1, 190000, N'Mẫu quần áo bóng đá đội tuyển Pháp sân khách, đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển:', CAST(N'2021-01-04' AS Date), 10)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (11, N'Áo đội tuyển Bỉ sân nhà', 1, 160000, N'Mẫu quần áo bóng đá đội tuyển Bỉ sân nhà , đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (12, N'Áo đội tuyển Argentina sân nhà', 1, 160000, N'Mẫu quần áo bóng đá đội tuyển Argentina sân nhà , đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (13, N'Áo đội tuyển Đức sân nhà', 1, 170000, N'Mẫu quần áo bóng đá đội tuyển Đức sân nhà , đây là mẫu quần áo bóng đá sân mùa giải mới của đội tuyển', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (14, N'Áo AC Milan sân khách 2021 – 2022', 1, 320000, N'Áo bóng đá AC Milan sân khách:
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 260.000VNĐ /1 áo – 330.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 250,000VNĐ/ 1 áo – 320,000VNĐ/ 1 bộ', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (19, N'Áo Arsenal sân nhà 2021 – 2022', 1, 280000, N'Áo bóng đá Arsenal sân nhà:
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 200.000VNĐ /1 áo – 260.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 190,000VNĐ/ 1 áo – 250,000VNĐ/ 1 bộ', CAST(N'2021-02-01' AS Date), 10)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (24, N'Áo Barca sân khách mẫu ba 2021 – 2022', 1, 320000, N'Áo bóng đá Barca sân khách mẫu ba:
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 260.000VNĐ /1 áo – 330.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 250,000VNĐ/ 1 áo – 320,000VNĐ/ 1 bộ', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (29, N'Áo Bayern Munich sân khách mẫu ba 2021 – 2022', 1, 200000, N'Áo bóng đá Bayern Munich sân khách mẫu ba:
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 200.000VNĐ /1 áo – 260.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 190,000VNĐ/ 1 áo – 250,000VNĐ/ 1 bộ', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (30, N'Áo Dortmund sân khách 2021 – 2022', 1, 320000, N'Áo bóng đá Dortmund sân khách:
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 260.000VNĐ /1 áo – 330.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 250,000VNĐ/ 1 áo – 320,000VNĐ/ 1 bộ', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (31, N'Áo Real Madrid sân nhà 2021 – 2022', 1, 330000, N'Áo bóng đá Real Madrid sân nhà, phần cổ áo được thiết kế dạng tròn, năng động và thể thao với sự phối màu hài hòa giữa 2 gam màu chủ đạo cam và xanh:
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 260.000VNĐ /1 áo – 330.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 250,000VNĐ/ 1 áo – 320,000VNĐ/ 1 bộ', CAST(N'2021-02-01' AS Date), 5)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (32, N'Áo Tottenham sân khách 2021 – 2022', 1, 320000, N'Áo bóng đá PSG sân nhà vẫn tiếp tục sử dụng thiết kế Hechter truyền thống trước đó, cùng với các điểm nhấn lạ mắt.
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 260.000VNĐ /1 áo – 330.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 250,000VNĐ/ 1 áo – 320,000VNĐ/ 1 bộ', CAST(N'2021-02-03' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (35, N'Áo PSG sân nhà 2021 – 2022', 1, 320000, N'Áo bóng đá PSG sân nhà vẫn tiếp tục sử dụng thiết kế Hechter truyền thống trước đó, cùng với các điểm nhấn lạ mắt.
-Hàng VN: 90.000 VNĐ /1 bộ
Từ 10 bộ trở lên: 85.000VNĐ /1 bộ.
-Hàng Thái Lan F1: 260.000VNĐ /1 áo – 330.000VNĐ /1 bộ
Giá ưu đãi từ 10 bộ trở lên: 250,000VNĐ/ 1 áo – 320,000VNĐ/ 1 bộ', CAST(N'2021-02-04' AS Date), 10)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (36, N'Áo thun thể thao Achilles xám', 2, 320000, N'Áo thun thể thao Achilles xám', CAST(N'2021-03-01' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (37, N'Áo thun thể thao Achilles xanh dương
', 2, 320000, N'Áo thun thể thao Achilles xanh dương là một trong những mẫu áo thể thao “Thần Thoại Hy Lạp” của 2020 năm nay. Áo được thiết kế với phong cách thời trang, năng động, cùng với chất liệu co giản 4 chiều. Đây sẽ là một trong những mẫu trang phục không thể thiếu khi đồng hành cùng bạn đến phòng tập hay bất cứ môn thể thao nào.

Chất liệu: 85% Polyester – 15% Spandex

Màu sắc: Xám – Xanh dương

Kiểu dáng: Áo thun thể thao nam', CAST(N'2021-03-02' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (38, N'Áo thun thể thao Bacchus đen', 2, 320000, N'Áo thun thể thao Bacchus đen là một trong những mẫu áo thể thao “Thần Thoại Hy Lạp” của 2020 năm nay. Áo được thiết kế với phong cách thời trang, năng động, cùng với chất liệu co giản 4 chiều. Đây sẽ là một trong những mẫu trang phục không thể thiếu khi đồng hành cùng bạn đến phòng tập hay bất cứ môn thể thao nào.

Chất liệu: 87% Polyester – 13% Spandex

Màu sắc: Đen – Xám – Xanh dương – Xanh rêu

Kiểu dáng: Áo thun thể thao nam

Kích thước/ Size: M – L – XL – 2XL – 3XL', CAST(N'2021-03-03' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (41, N'Áo thun thể thao Ares xám', 2, 320000, N'Áo thun thể thao Ares xám là một trong những mẫu áo thể thao “Thần Thoại Hy Lạp” của 2020 năm nay. Áo được thiết kế với phong cách thời trang, năng động, cùng với chất liệu co giản 4 chiều. Đây sẽ là một trong những mẫu trang phục không thể thiếu khi đồng hành cùng bạn đến phòng tập hay bất cứ môn thể thao nào.

Chất liệu: 87% Polyester – 13% Spandex

Màu sắc: Đen – Xám – Xanh lá

Kiểu dáng: Áo thun thể thao nam

Kích thước/ Size: M – L – XL – 2XL – 3XL', CAST(N'2021-03-04' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (42, N'Áo thun thể thao Ceres đỏ', 2, 320000, N'Áo thun thể thao Ceres đỏ là một trong những mẫu áo thể thao “Thần Thoại Hy Lạp” của 2020 năm nay. Áo được thiết kế với phong cách thời trang, năng động, cùng với chất liệu co giản 4 chiều. Đây sẽ là một trong những mẫu trang phục không thể thiếu khi đồng hành cùng bạn đến phòng tập hay bất cứ môn thể thao nào.

Chất liệu: 90% Polyester – 10% Spandex

Màu sắc: Đen – Đỏ – Trắng

Kiểu dáng: Áo thun thể thao nam

Kích thước/ Size: M – L – XL – 2XL – 3XL', CAST(N'2021-03-04' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (43, N'Quần short training tập GYM Nam 360s E9 xám
', 2, 230000, N'Quần short thể thao tập GYM E9 màu xám chuyên hỗ trợ training và tập GYM dành cho Nam. Quần được thiết kế kiểu dáng thể thao hiện đại, mang lại cho bạn cảm giác thoải mái và dễ chịu khi bạn thực hiện các bài tập thể dục và cũng có thể mặc nhà hoặc đi chơi.

Quần short nam này được xem là hoàn hảo để tập các bài tập từ đơn giản đến phức tạp, mang đến cho bạn sự thoải mái và linh hoạt hơn trong phòng tập.

Sản phẩm có nhiều màu sắc để bạn có thể dễ dàng chọn lựa.

Size: M, L, XL', CAST(N'2021-03-05' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (47, N'Quần short training tập GYM Nam 360s E7 đen', 2, 240000, N'Quần short thể thao tập GYM E7 màu đen chuyên hỗ trợ training và tập GYM dành cho Nam. Quần được thiết kế kiểu dáng thể thao hiện đại, mang lại cho bạn cảm giác thoải mái và dễ chịu khi bạn thực hiện các bài tập thể dục và cũng có thể mặc nhà hoặc đi chơi.

Quần short nam này được xem là hoàn hảo để tập các bài tập từ đơn giản đến phức tạp, mang đến cho bạn sự thoải mái và linh hoạt hơn trong phòng tập.

Sản phẩm có nhiều màu sắc để bạn có thể dễ dàng chọn lựa.

Size: M, L, XL', CAST(N'2021-03-06' AS Date), 15)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (53, N'Quần dài Joggers thể thao nam 360s LX xanh đen', 2, 480000, N'Quần jogger thể thao Nam 360s LX màu xanh đen thích hợp đi chơi, mặc nhà và đặc biệt là mặc tập GYM.

Quần mang thương hiệu 360s được thiết kế kiểu dáng thể thao hiện đại, mang lại cho bạn cảm giác thoải mái và dễ chịu khi bạn thực hiện các bài tập thể dục và cũng có thể mặc nhà hoặc đi chơi.

Quần thể thao nam này được xem là hoàn hảo để tập các bài tập từ đơn giản đến phức tạp, mang đến cho bạn sự thoải mái và linh hoạt hơn trong phòng tập.

Sản phẩm có hai màu đen và xanh đen để bạn có thể dễ dàng chọn lựa.', CAST(N'2021-03-07' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (56, N'Quần jogger Nam Hummal HYPER Gray', 2, 325000, N'Quần jogger Nam Hummal HYPER Gray chính hãng sở hữu form quần đẹp, kết hợp cùng kiểu dáng trẻ trung, mang lại sự năng động và nét khỏe khoắn cho phái mạnh. Quần được may trên nền chất liệu cotton cao cấp, người mặc thêm tự tin và thoải mái trong mọi hoạt động.

Thích hợp khi phối cùng với các item như: áo thun, giày lười hoặc giày thể thao, mũ lưỡi trai,… để thêm phần bụi bặm, cá tính, là món đồ thích hợp để các chàng sử dụng trong những chuyến đi xa, đi phượt hoặc đi cà phê cùng bạn bè.

Chất liệu: 95% cotton, 5% spandex

Màu sắc: Đen, xám

Size: XS, S, M, L, XL

Xuất xứ: Made in Vietnam.', CAST(N'2021-03-07' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (57, N'Bra 360s Lux màu vàng', 2, 160000, N'Áo Bras 360s Lux màu vàng kiểu dáng thể thao, với thiết kế nâng đỡ ngực khi tập luyện – vận động thể thao, giúp bảo vệ vùng ngực khỏi xung lực có hại đến ngực. Chất liệu co giản 4 chiều của Spandex giúp bạn thoải mái vận động, di chuyển trong từng động tác và phù hợp với mọi bộ môn thể thao.

Chất liệu: 94% Polyester – 6% Spandex

Màu sắc: Đen – Nude – Cam – Vàng – Xanh đen – Xanh lá

Kiểu dáng: Crop-top

Kích thước/ Size:  M – L – XL

Chat facebook', CAST(N'2021-03-08' AS Date), 20)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (60, N'Bra 360s Lux màu xanh lá
', 2, 160000, N'Áo Bras 360s Lux màu xanh lá kiểu dáng thể thao, với thiết kế nâng đỡ ngực khi tập luyện – vận động thể thao, giúp bảo vệ vùng ngực khỏi xung lực có hại đến ngực. Chất liệu co giản 4 chiều của Spandex giúp bạn thoải mái vận động, di chuyển trong từng động tác và phù hợp với mọi bộ môn thể thao.

Chất liệu: 94% Polyester – 6% Spandex

Màu sắc: Đen – Nude – Cam – Vàng – Xanh đen – Xanh lá

Kiểu dáng: Crop-top

Kích thước/ Size:  M – L – XL', CAST(N'2021-03-09' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (61, N'Quần Legging lửng Power xanh đen
', 2, 320000, N'Quần legging lửng Power xanh đen phối lưới hỗ trợ tập Yoga, GYM & Thể dục thẩm mỹ dành cho nữ. Được sản xuất từ chất liệu cotton kết hợp với sợi giãn spandex và thiết kế kiểu dáng đẹp, mang lại cho bạn cảm giác mát mẻ và dễ chịu khi thực hiện các bài tập thể dục.
Bạn có thể kết hợp quần legging này với áo bra thể thao và một chiếc áo tanktop ở bên ngoài rất phù hợp.

Màu sắc: Đen – Xanh đen – Hồng – Xám – Xanh rêu

Size: M – L

Chất liệu: 94% Polyester – 6% Spandex', CAST(N'2021-03-13' AS Date), 0)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (62, N'Quần Legging lửng Grid xanh rêu
', 2, 320000, N'Quần legging lửng Grid xanh rêu phối lưới hỗ trợ tập Yoga, GYM & Thể dục thẩm mỹ dành cho nữ. Được sản xuất từ chất liệu cotton kết hợp với sợi giãn spandex và thiết kế kiểu dáng đẹp, mang lại cho bạn cảm giác mát mẻ và dễ chịu khi thực hiện các bài tập thể dục.
Bạn có thể kết hợp quần legging này với áo bra thể thao và một chiếc áo tanktop ở bên ngoài rất phù hợp.

Màu sắc: Đen – Xanh đen – Hồng – Xám – Xanh rêu

Size: M – L

Chất liệu: 94% Polyester – 6% Spandex', CAST(N'2021-03-14' AS Date), 25)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (64, N'Áo thun không tay 500 cho bé gái - Xanh navy/Cam', 3, 145000, N'Áo thun không tay được thiết kế cho các hoạt động mà trẻ đổ nhiều mồ hôi và các bài tập có cường độ cao.Áo thun không tay cực kỳ mềm mại. Vải co giãn, mềm mịn. Khả năng thoát hơi ẩm tuyệt vời. Phần lưng dài hơn để che chắn tốt. Kiểu áo Racerback.', CAST(N'2021-03-15' AS Date), 20)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (65, N'Áo thun ngắn tay chạy bộ thoáng mát AT300 cho trẻ em - Xanh navy', 3, 195000, N'Chúng tôi thiết kế áo thun ngắn tay này cho trẻ em để chống nắng khi tập luyện.Áo thun ngắn tay mềm mại và chống tia cực tím này bảo vệ trẻ khỏi ánh nắng khi chạy bộ. Chúng tôi sử dụng vải co giãn, hoàn hảo để học các động tác điền kinh.', CAST(N'2021-03-15' AS Date), 20)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (66, N'Quần short tập gym 500 cho trẻ em - Xám', 3, 145000, N'Chúng tôi luôn muốn đáp ứng yêu cầu của khách hàng: quần short có thể điều chỉnh. Quan sát trẻ và lắng nghe cha mẹ, quần short này chính là giải pháp.Quần short gym trẻ em này được chỉnh sửa dựa trên phản hồi của bạn: quần short rộng hơn một chút và vải mềm mại hơn để trẻ dễ mặc hơn.', CAST(N'2021-03-17' AS Date), 20)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (67, N'Quần short 100 cho bé trai - Xám', 3, 160000, N'Quần short cơ bản này được thiết kế cho các hoạt động luyện tập không ra nhiều mồ hôi và những bài tập không cần vận động mạnh.Quần short thoải mái và đơn giản. Phom dáng đơn giản, chuyển động thoải mái. Thắt lưng co giãn. Túi ở phía sau.', CAST(N'2021-03-18' AS Date), 15)
INSERT [dbo].[Product] ([idProduct], [name], [idCategory], [price], [decription], [dateAdd], [discount]) VALUES (68, N'Đồ bơi một mảnh Taïs cho bé gái - Tím Hồng
', 3, 180000, N'Dành cho trẻ mới bắt đầu bơi cần sản phẩm dễ mặc và thoải máiĐồ bơi có độ nâng đỡ tốt nhờ lưng áo chữ H giúp bạn vận động tự do.', CAST(N'2021-03-19' AS Date), 20)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (1, N'1.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (4, N'4.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (5, N'5.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (5, N'5.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (5, N'5.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (6, N'6.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (6, N'6.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (6, N'6.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (7, N'7.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (7, N'7.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (9, N'9.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (9, N'9.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (9, N'9.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (11, N'11.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (11, N'11.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (11, N'11.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (12, N'12.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (12, N'12.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (12, N'12.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (13, N'13.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (14, N'14.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (14, N'14.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (19, N'19.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (19, N'19.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (24, N'24.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (24, N'24.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (29, N'29.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (29, N'29.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (30, N'30.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (30, N'30.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (31, N'31.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (31, N'31.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (32, N'32.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (32, N'32.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (35, N'35.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (35, N'35.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (36, N'36.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (36, N'36.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (37, N'37.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (37, N'37.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (38, N'38.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (38, N'38.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (41, N'41.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (41, N'41.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (42, N'42.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (42, N'42.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (42, N'42.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (43, N'43.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (43, N'43.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (43, N'43.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (47, N'47.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (47, N'47.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (47, N'47.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (53, N'53.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (53, N'53.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (53, N'53.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (56, N'56.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (56, N'56.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (56, N'56.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (57, N'57.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (57, N'57.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (57, N'57.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (60, N'60.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (60, N'60.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (60, N'60.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (61, N'61.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (62, N'62.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (62, N'62.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (62, N'62.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (64, N'64.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (64, N'64.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (64, N'64.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (65, N'65.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (65, N'65.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (65, N'65.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (66, N'66.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (66, N'66.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (66, N'66.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (67, N'67.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (67, N'67.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (67, N'67.2.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (68, N'68.0.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (68, N'68.1.jpg')
INSERT [dbo].[ProductImg] ([idProduct], [source]) VALUES (68, N'68.2.jpg')
GO
INSERT [dbo].[ProductReview] ([idBill], [idProduct], [productSize], [ratingScore], [contentText], [dateReview]) VALUES (1, 1, N'XL', 5, N'Hàng tốt, sử dụng ngon.', CAST(N'2021-11-05T00:00:00.000' AS DateTime))
INSERT [dbo].[ProductReview] ([idBill], [idProduct], [productSize], [ratingScore], [contentText], [dateReview]) VALUES (38, 38, N'L', 3, N'Hàng tạm ổn :)', CAST(N'2021-12-06T00:00:00.000' AS DateTime))
INSERT [dbo].[ProductReview] ([idBill], [idProduct], [productSize], [ratingScore], [contentText], [dateReview]) VALUES (38, 38, N'XL', 4, N'Size này chất lượng tốt hơn', CAST(N'2021-12-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (1, N'L', 3)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (4, N'L', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (5, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (6, N'L', 0)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (7, N'L', 8)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (9, N'L', 6)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (11, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (12, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (13, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (14, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (19, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (24, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (29, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (30, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (31, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (32, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (35, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (36, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (37, N'L', 4)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (38, N'L', 2)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (38, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (41, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (42, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (43, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (47, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (53, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (56, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (57, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (60, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (61, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (62, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (64, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (65, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (66, N'XL', 5)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (67, N'XL', 2)
INSERT [dbo].[ProductStock] ([idProduct], [size], [inStock]) VALUES (68, N'XL', 4)
GO
INSERT [dbo].[User] ([idUser], [username], [pass], [idRole]) VALUES (1, N'admin', N'123', 1)
INSERT [dbo].[User] ([idUser], [username], [pass], [idRole]) VALUES (2, N'chuong123', N'123', 2)
INSERT [dbo].[User] ([idUser], [username], [pass], [idRole]) VALUES (3, N'hieu123', N'123', 2)
INSERT [dbo].[User] ([idUser], [username], [pass], [idRole]) VALUES (4, N'chuong1234', N'1234', 2)
GO
INSERT [dbo].[UserDetail] ([idUser], [name], [phone], [email], [gender], [birthday], [address], [imgAvatar]) VALUES (1, N'Admin', N'028852555', N'admin@gmail.com', N'Nam', CAST(N'2000-01-02' AS Date), N'66/1 Võ Thị Sau, Phường 5, Thành phố Long Khánh, tỉnh Đồng Nai', N'avtAdmin.jpg')
INSERT [dbo].[UserDetail] ([idUser], [name], [phone], [email], [gender], [birthday], [address], [imgAvatar]) VALUES (2, N'Đình Chương', N'0952154141', N'n18dccn025@student.ptithcm.edu.vn', N'Nam', CAST(N'2000-07-08' AS Date), N'88 Nguyễn Văn Trỗi, phường 3, thành Phố Biên Hòa, tỉnh Đồng Nai', N'avtChuong.jpg')
INSERT [dbo].[UserDetail] ([idUser], [name], [phone], [email], [gender], [birthday], [address], [imgAvatar]) VALUES (3, N'Trọng Hiếu', N'021441445', N'hieu46@gmail.com', N'Nam', CAST(N'2000-11-01' AS Date), N'23 Nguyễn Đình Chiểu, phường Xuân Thanh, TP Long Khánh, tỉnh Đồng Nai', N'avtHieu.jpg')
INSERT [dbo].[UserDetail] ([idUser], [name], [phone], [email], [gender], [birthday], [address], [imgAvatar]) VALUES (4, N'ungDinhChuong', N'0923456781', N'uc291000@gmail.com', N'', NULL, N'', N'985.jpg')
GO
INSERT [dbo].[UserRole] ([idRole], [roleName]) VALUES (1, N'admin')
INSERT [dbo].[UserRole] ([idRole], [roleName]) VALUES (2, N'customer')
GO
INSERT [dbo].[Wishlist] ([idUser], [idProduct], [size]) VALUES (2, 38, N'L')
INSERT [dbo].[Wishlist] ([idUser], [idProduct], [size]) VALUES (2, 38, N'XL')
INSERT [dbo].[Wishlist] ([idUser], [idProduct], [size]) VALUES (4, 19, N'L')
INSERT [dbo].[Wishlist] ([idUser], [idProduct], [size]) VALUES (4, 29, N'L')
INSERT [dbo].[Wishlist] ([idUser], [idProduct], [size]) VALUES (4, 38, N'L')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Username]    Script Date: 12/6/2021 4:21:30 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [IX_Username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Email]    Script Date: 12/6/2021 4:21:30 PM ******/
ALTER TABLE [dbo].[UserDetail] ADD  CONSTRAINT [IX_Email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [df_timeCreated]  DEFAULT (getdate()) FOR [timeCreated]
GO
ALTER TABLE [dbo].[ProductReview] ADD  CONSTRAINT [df_dateReview]  DEFAULT (getdate()) FOR [dateReview]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([idUser])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_User]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillDetail_Bill] FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([idBill])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK_BillDetail_Bill]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillDetail_Product] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Product] ([idProduct])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK_BillDetail_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Product] ([idProduct])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([idUser])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_User]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Category] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[ProductImg]  WITH CHECK ADD  CONSTRAINT [FK_ProductImg_Product] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Product] ([idProduct])
GO
ALTER TABLE [dbo].[ProductImg] CHECK CONSTRAINT [FK_ProductImg_Product]
GO
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_BillDetail] FOREIGN KEY([idBill], [idProduct], [productSize])
REFERENCES [dbo].[BillDetail] ([idBill], [idProduct], [productSize])
GO
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_BillDetail]
GO
ALTER TABLE [dbo].[ProductStock]  WITH CHECK ADD  CONSTRAINT [FK_ProductStock_Product] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Product] ([idProduct])
GO
ALTER TABLE [dbo].[ProductStock] CHECK CONSTRAINT [FK_ProductStock_Product]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_UserRole] FOREIGN KEY([idRole])
REFERENCES [dbo].[UserRole] ([idRole])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_UserRole]
GO
ALTER TABLE [dbo].[UserDetail]  WITH CHECK ADD  CONSTRAINT [FK_UserDetail_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([idUser])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[UserDetail] CHECK CONSTRAINT [FK_UserDetail_User]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_WishList_Product] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Product] ([idProduct])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_WishList_Product]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_Wishlist_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([idUser])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_Wishlist_User]
GO
USE [master]
GO
ALTER DATABASE [WebTheThao] SET  READ_WRITE 
GO
