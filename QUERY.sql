USE [master]
GO
ALTER DATABASE [AssPRJ] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE IF EXISTS [AssPRJ]
GO
CREATE DATABASE [AssPRJ]
GO
USE [AssPRJ]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customerName] [varchar](100) NOT NULL,
	[phonenumber] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[roleId] [int] NULL,
	[address] [nvarchar](max) NULL,
	[gender] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/18/2024 3:24:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[amount] [int] NULL,
	[createAt] [datetime] NULL,
	[note] [nvarchar](max) NULL,
	[address] [nvarchar](max) NULL,
	[phone] [nvarchar](15) NULL,
	[email] [nvarchar](50) NULL,
	[accountId] [int] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/18/2024 3:24:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[quantity] [int] NULL,
	[productId] [int] NULL,
	[orderId] [int] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/18/2024 3:24:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[productID] [int] IDENTITY(1,1) NOT NULL,
	[typeID] [int] NULL,
	[productName] [nvarchar](max) NOT NULL,
	[price] [int] NOT NULL,
	[stockQuantity] [int] NOT NULL,
	[image] [nvarchar](max) NULL,
 CONSTRAINT [PK__Products__B40CC6EDAEC70205] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 3/18/2024 3:24:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/18/2024 3:24:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([id], [customerName], [email], [password], [roleId], [address], [gender]) VALUES (12, N'user', N'1', N'123', 2, N'czxczx', 1)
GO
INSERT [dbo].[Customer] ([id], [customerName], [email], [password], [roleId], [address], [gender]) VALUES (13, N'admin', N'admin@gmail.com', N'1', 1, NULL, NULL)
GO
INSERT [dbo].[Customer] ([id], [customerName], [email], [password], [roleId], [address], [gender]) VALUES (14, N'user1', N'123@gmail.com', N'123', 2, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (1, 1, N'test search', 250000, 72, N'/High-endTech/images/b3.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (2, 1, N'Product xx', 300000, 0, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (3, 1, N'Product xx', 150000, 100, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (4, 1, N'Product xx', 180000, 80, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (5, 1, N'Product xx', 500000, 48, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (6, 1, N'Product xx', 350000, 66, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (7, 2, N'Product xx', 400000, 56, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (8, 2, N'Product xx', 280000, 110, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (9, 2, N'Product xx', 230000, 130, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (10, 2, N'Product xx', 450000, 65, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (11, 2, N'Product xx', 150000, 100, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (12, 2, N'Product xx', 250000, 90, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (13, 2, N'Product xx', 120000, 110, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (14, 2, N'Product xx', 200000, 80, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (15, 2, N'Product xx', 400000, 60, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (16, 2, N'Product xx', 350000, 70, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (17, 2, N'Product xx', 500000, 55, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (18, 2, N'Product xx', 300000, 95, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (19, 2, N'Product xx', 170000, 105, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (20, 2, N'Product xx', 450000, 65, N'/FlowerShop/images/giay-Nike-Air-Force-1-Low-Premium-White-Brown-808788-996-AF1-vien-nau-like-auth-sieu-cap-gia-re-ha-noi-3848972867.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (25, 2, N'test add', 123, 123, NULL)
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (26, 2, N'test add 02', 123, 123, N'/LaptopShop/images/k2.jpg')
GO
INSERT [dbo].[Products] ([productID], [typeID], [productName], [price], [stockQuantity], [image]) VALUES (30, 2, N'123', 123, 123, N'/FlowerShop/images/b3.jpg')
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] ON 
GO
INSERT [dbo].[ProductTypes] ([id], [name]) VALUES (1, N'Test Product 02')
GO
INSERT [dbo].[ProductTypes] ([id], [name]) VALUES (2, N'Test Product 02')
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([id], [name]) VALUES (1, N'admin')
GO
INSERT [dbo].[Role] ([id], [name]) VALUES (2, N'user')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__AB6E61640FBCB5C1]    Script Date: 3/18/2024 3:24:47 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__AB6E616462E6C79D]    Script Date: 3/18/2024 3:24:47 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__AB6E6164AE8BAF09]    Script Date: 3/18/2024 3:24:47 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Table_1_createAt]  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Role] FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Role]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([accountId])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([orderId])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([productId])
REFERENCES [dbo].[Products] ([productID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK__Products__TypeID__398D8EEE] FOREIGN KEY([typeID])
REFERENCES [dbo].[ProductTypes] ([id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK__Products__TypeID__398D8EEE]
GO
