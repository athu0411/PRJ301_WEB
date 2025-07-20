<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Products" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm - MLB Store</title>
        <style>
            :root {
                --bg-dark: #1f2937;
                --bg-secondary: #374151;
                --text-light: #f3f4f6;
                --text-muted: #9ca3af;
                --primary: #3b82f6;
                --primary-hover: #2563eb;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--bg-dark);
                color: var(--text-light);
                margin: 0;
            }

            header {
                background-color: var(--bg-secondary);
                padding: 20px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid var(--primary);
            }

            header h1 {
                font-size: 26px;
                font-weight: bold;
                color: var(--text-light);
            }

            nav a {
                color: var(--text-light);
                margin-left: 20px;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }

            nav a:hover {
                color: var(--primary);
            }

            .container {
                max-width: 900px;
                margin: 40px auto;
                padding: 20px;
                background-color: #111827;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.2);
            }

            .product-img {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .product-name {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .product-price {
                font-size: 22px;
                color: var(--primary);
                margin-bottom: 10px;
            }

            .product-description {
                font-size: 16px;
                color: var(--text-muted);
                margin-bottom: 10px;
            }

            .product-qty {
                font-size: 15px;
                color: #ccc;
                margin-bottom: 20px;
            }

            .btn {
                background-color: var(--primary);
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 500;
                transition: background-color 0.3s;
                border: none;
                cursor: pointer;
            }

            .btn:hover {
                background-color: var(--primary-hover);
            }

            .back-link {
                display: inline-block;
                margin-top: 30px;
                color: var(--primary);
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            footer {
                background-color: var(--bg-secondary);
                color: var(--text-muted);
                text-align: center;
                padding: 16px;
                font-size: 14px;
                border-top: 1px solid var(--primary);
                margin-top: 40px;
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <header>
            <h1>MLB Store</h1>
            <nav>
                <a href="index.jsp">Trang chủ</a>
                <a href="MainController?action=ViewProductPage">Sản phẩm</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="cart.jsp">Giỏ hàng</a>
                        <a href="logout.jsp">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="MainController?action=Login_View">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </header>

        <!-- Main -->
        <div class="container">
            <c:choose>
                <c:when test="${not empty product}">
                    <img class="product-img" src="images/uploads/${product.imgUrl}" alt="${product.productName}" onerror="this.src='images/default.jpg'">
                    <div class="product-name">${product.productName}</div>
                    <div class="product-price">₫${product.price}</div>
                    <div class="product-description">${product.description}</div>
                    <div class="product-qty">Số lượng còn lại: ${product.quantity}</div>

                    <!-- Thêm vào giỏ hàng -->
                    <form action="MainController" method="post" style="margin-top: 20px;">
                        <input type="hidden" name="action" value="AddToCart" />
                        <input type="hidden" name="id" value="${product.productID}" />
                        <label for="quantity">Số lượng:</label>
                        <input type="number" name="quantity" id="quantity" value="1" min="1" max="${product.quantity}" required style="width: 60px; margin-left: 6px; padding: 4px;" />
                        <button type="submit" class="btn" style="margin-left: 10px;">Thêm vào giỏ</button>
                    </form>

                    <a class="back-link" href="MainController?action=ViewProductPage">← Quay lại danh sách</a>
                </c:when>
                <c:otherwise>
                    <p style="color:red;">Không tìm thấy sản phẩm</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Footer -->
        <footer>
            <p>&copy; 2025 MLB Store. All rights reserved.</p>
            <p>Email: support@mlbstore.vn | Hotline: 0988 999 888</p>
        </footer>

    </body>
</html>
