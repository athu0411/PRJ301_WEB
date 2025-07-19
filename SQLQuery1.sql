-- Tạo Database
CREATE DATABASE ClothingStore;
GO

USE ClothingStore;
GO

-- Bảng người dùng
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    Role NVARCHAR(20) DEFAULT 'Customer',
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Bảng danh mục sản phẩm
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);
GO

-- Bảng sản phẩm
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    ImageURL NVARCHAR(255),
    CategoryID INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- Bảng đơn hàng
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,
    UserID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2),
    Status NVARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

INSERT INTO Users (Username, PasswordHash, FullName, Email, Phone, Address, Role)
VALUES
('admin1', 'hashedpassword1', N'Nguyễn Văn A', 'admin1@example.com', '0901234567', N'123 Lê Lợi, Q1', 'Admin'),
('khach1', 'hashedpassword2', N'Trần Thị B', 'khach1@example.com', '0934567890', N'456 Trần Hưng Đạo, Q5', 'Customer');

INSERT INTO Categories (CategoryName, Description) VALUES
(N'Áo thun', N'Các loại áo thun cotton, thời trang'),
(N'Quần jean', N'Quần jean nam nữ các loại'),
(N'Áo khoác', N'Áo khoác ấm và thời trang'),
(N'Phụ kiện', N'Kính, dây nịt, mũ,...');

INSERT INTO Products (ProductName, Description, Price, Quantity, ImageURL, CategoryID)
VALUES
(N'Áo thun trắng basic', N'Chất cotton 100%, form rộng', 199000, 50, 'aothun_trang.jpg', 1),
(N'Áo thun đen Unisex', N'Mềm mại, co giãn 4 chiều', 209000, 40, 'aothun_den.jpg', 1),
(N'Quần jean xanh nam', N'Dáng slimfit, co giãn', 399000, 30, 'jean_nam.jpg', 2),
(N'Áo khoác gió nữ', N'Chống nước nhẹ, phong cách Hàn Quốc', 499000, 20, 'khoac_nu.jpg', 3),
(N'Mũ bucket thời trang', N'Màu kem, unisex', 99000, 100, 'mu_bucket.jpg', 4);


SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Users;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

