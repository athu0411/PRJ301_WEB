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


INSERT INTO Products (ProductName, Description, Price, Quantity, ImageURL, CategoryID, CreatedAt)
VALUES
(N'Nón MLB', N'Nón đẹp', 150.00, 10, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 2, GETDATE()),
(N'Dép MLB', N'Dép sành điệu', 199.00, 5, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 4, GETDATE()),
(N'Áo Hoodie', N'Áo ấm mùa đông', 420.00, 8, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Quần Short', N'Quần ngắn thể thao', 215.00, 6, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 3, GETDATE()),
(N'Vớ cổ cao', N'Vớ cao cấp', 45.00, 15, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 4, GETDATE()),
(N'Áo thun trắng', N'Áo thun đơn giản', 120.00, 20, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Áo sơ mi kẻ', N'Áo thời trang công sở', 320.00, 12, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Quần jean rách', N'Phong cách đường phố', 380.00, 7, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 3, GETDATE()),
(N'Giày sneaker', N'Giày thể thao năng động', 650.00, 4, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 2, GETDATE()),
(N'Áo khoác gió', N'Áo chống gió nhẹ', 490.00, 6, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Túi đeo chéo', N'Túi nhỏ gọn thời trang', 270.00, 9, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 5, GETDATE()),
(N'Nón bucket', N'Nón cá tính', 130.00, 13, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 2, GETDATE()),
(N'Dép lê', N'Dép tiện lợi mùa hè', 99.00, 10, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 4, GETDATE()),
(N'Vớ cổ ngắn', N'Vớ ngắn thể thao', 39.00, 18, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 4, GETDATE()),
(N'Áo nỉ MLB', N'Áo nỉ mùa đông', 385.00, 5, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Quần nỉ', N'Quần nỉ mặc ở nhà', 210.00, 8, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 3, GETDATE()),
(N'Áo MLB New', N'Áo thiết kế mới', 299.00, 11, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Áo khoác jeans', N'Cá tính và bụi bặm', 520.00, 3, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 1, GETDATE()),
(N'Giày MLB trắng', N'Giày trắng hot trend', 700.00, 6, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 2, GETDATE()),
(N'Balo MLB', N'Balo học sinh sành điệu', 350.00, 9, 'c0cee3ae-f8bf-4efd-b928-d189c8d69c64.jpg', 5, GETDATE());

INSERT INTO Categories (CategoryName, Description) VALUES
(N'Áo thun', N'Các loại áo thun cotton, thời trang'),       -- ID 1
(N'Quần jean', N'Quần jean nam nữ các loại'),               -- ID 2
(N'Áo khoác', N'Áo khoác ấm và thời trang'),                -- ID 3
(N'Phụ kiện', N'Kính, dây nịt, mũ,...');                   -- ID 4


