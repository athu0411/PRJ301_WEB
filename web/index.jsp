<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>MLB Store - Trang Chủ</title>
        <style>
            :root {
                --bg-dark: #1f2937;
                --bg-secondary: #374151;
                --text-light: #f3f4f6;
                --text-muted: #9ca3af;
                --primary: #3b82f6;
                --primary-hover: #2563eb;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--bg-dark);
                color: var(--text-light);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
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

            .hero {
                padding: 80px 20px;
                text-align: center;
                background: linear-gradient(to right, #111827, #1f2937);
            }

            .hero h2 {
                font-size: 36px;
                margin-bottom: 15px;
            }

            .hero p {
                font-size: 20px;
                margin-bottom: 25px;
                color: var(--text-muted);
            }

            .btn {
                background-color: var(--primary);
                color: white;
                padding: 12px 28px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            .btn:hover {
                background-color: var(--primary-hover);
            }

            .main-content {
                padding: 40px 20px;
                flex: 1;
            }

            .section-title {
                text-align: center;
                font-size: 28px;
                margin-bottom: 30px;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 25px;
                padding: 0 20px;
            }

            .product-card {
                background-color: #111827;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
                overflow: hidden;
                display: flex;
                flex-direction: column;
                transition: transform 0.3s;
            }

            .product-card:hover {
                transform: translateY(-4px);
            }

            .product-card img {
                width: 100%;
                height: 220px;
                object-fit: cover;
            }

            .product-info {
                padding: 15px;
                text-align: center;
                flex: 1;
            }

            .product-name {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 8px;
                color: var(--text-light);
            }

            .product-price {
                font-size: 16px;
                color: var(--primary);
                margin-bottom: 6px;
            }

            .product-description {
                font-size: 14px;
                color: var(--text-muted);
                height: 42px;
                overflow: hidden;
            }

            footer {
                background-color: var(--bg-secondary);
                color: var(--text-muted);
                text-align: center;
                padding: 16px;
                font-size: 14px;
                margin-top: auto;
                border-top: 1px solid var(--primary);
            }

            @media screen and (max-width: 768px) {
                header, .hero, .main-content {
                    padding: 20px;
                }

                nav a {
                    margin-left: 10px;
                }

                .hero h2 {
                    font-size: 28px;
                }
            }
        </style>
    </head>
    <body>

        <header>
            <h1>MLB Store</h1>
            <nav>
                <a href="index.jsp">Trang chủ</a>
                <a href="MainController?action=ViewProductPage">Sản phẩm</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="view-cart.jsp">Giỏ hàng</a>
                        <c:if test="${sessionScope.user.role eq 'Admin'}">
                            <a href="MainController?action=ViewAdminProduct">Quản lý</a>
                        </c:if>
                        <a href="logout.jsp">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="MainController?action=Login_View">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </header>

        <section class="hero">
            <h2>🔥 Bộ sưu tập MLB 2025 đã ra mắt!</h2>
            <p>Khám phá phong cách thể thao năng động, hiện đại và dẫn đầu xu hướng thời trang cùng MLB</p>
            <a href="MainController?action=ViewProductPage" class="btn">Khám phá ngay</a>
        </section>

        <section class="main-content">
            <h2 class="section-title">Sản phẩm nổi bật</h2>

            <div class="product-grid">
                <c:forEach var="product" items="${featuredProducts}">
                    <div class="product-card">
                        <img src="images/${product.image}" alt="${product.name}" onerror="this.src='images/default.jpg'">
                        <div class="product-info">
                            <div class="product-name">${product.name}</div>
                            <div class="product-price">₫${product.price}</div>
                            <p class="product-description">${product.description}</p>
                            <a href="product?action=detail&id=${product.productId}" class="btn">Chi tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div style="text-align: center; margin-top: 40px;">
                <a href="MainController?action=ViewProductPage" class="btn">Xem tất cả sản phẩm</a>
            </div>
        </section>

        <footer>
            <p>&copy; 2025 MLB Store. All rights reserved.</p>
            <p>Email: support@mlbstore.vn | Hotline: 0988 999 888</p>
        </footer>

    </body>
</html>
