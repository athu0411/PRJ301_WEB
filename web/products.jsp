<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>MLB Store - Danh sách sản phẩm</title>
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
                max-width: 1000px;
                margin: 40px auto;
                padding: 0 20px;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            .products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                gap: 25px;
            }

            .product-card {
                background-color: #111827;
                border-radius: 8px;
                padding: 15px;
                text-align: center;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
                transition: transform 0.3s;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 4px;
                margin-bottom: 10px;
            }

            .product-name {
                font-weight: bold;
                margin: 10px 0 5px;
                color: var(--text-light);
            }

            .product-price {
                color: var(--primary);
                margin-bottom: 10px;
            }

            .product-description {
                font-size: 14px;
                color: var(--text-muted);
                height: 40px;
                overflow: hidden;
                margin-bottom: 10px;
            }

            .btn {
                background-color: var(--primary);
                color: white;
                padding: 8px 16px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.3s;
            }

            .btn:hover {
                background-color: var(--primary-hover);
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

        <!-- Main content -->
        <div class="container">
            <h2>Danh sách sản phẩm</h2>

            <c:if test="${not empty errorMessage}">
                <p style="color: red; text-align: center;">${errorMessage}</p>
            </c:if>

            <div class="products-grid">
                <c:forEach var="product" items="${LIST_PRODUCT}">
                    <div class="product-card">
                        <img class="product-img"
                             src="images/uploads/${product.imgUrl}"
                             alt="${product.productName}"
                             onerror="this.src='images/default.jpg'">
                        <div class="product-name">${product.productName}</div>
                        <div class="product-price">₫${product.price}</div>
                        <div class="product-description">${product.description}</div>

                        <!-- Nút Xem chi tiết -->
                        <a href="MainController?action=ViewProductDetail&id=${product.productID}" class="btn" style="margin-bottom: 8px; display: inline-block;">Xem chi tiết</a>

                        <!-- Form Thêm vào giỏ hàng -->
                        <form action="MainController" method="post" style="margin-top: 5px;">
                            <input type="hidden" name="action" value="AddToCart" />
                            <input type="hidden" name="productId" value="${product.productID}" />
                            <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" style="width: 60px; padding: 4px;" required />
                            <button type="submit" class="btn" style="margin-left: 6px;">Thêm vào giỏ</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${totalPages > 1}">
                <div style="text-align: center; margin-top: 30px;">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span style="display: inline-block; margin: 0 5px; padding: 8px 14px; background-color: var(--primary); color: white; border-radius: 5px; font-weight: bold;">
                                    ${i}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <a href="MainController?action=ViewProductPage&page=${i}"
                                   style="display: inline-block; margin: 0 5px; padding: 8px 14px; background-color: var(--bg-secondary); color: var(--text-light); border-radius: 5px; text-decoration: none;">
                                    ${i}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if> 
        </div>

        <!-- Footer -->
        <footer>
            <p>&copy; 2025 MLB Store. All rights reserved.</p>
            <p>Email: support@mlbstore.vn | Hotline: 0988 999 888</p>
        </footer>

    </body>
</html>
