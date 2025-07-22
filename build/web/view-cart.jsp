<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng của bạn</title>
        <style>
            body {
                background-color: #1f2937;
                font-family: Arial, sans-serif;
                color: #eee;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                margin-bottom: 30px;
            }

            .top-actions {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .top-actions a {
                background-color: #00ADB5;
                padding: 8px 16px;
                border-radius: 4px;
                color: white;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .top-actions a:hover {
                background-color: #03bfc9;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #374151;
                margin-bottom: 30px;
            }

            th, td {
                padding: 12px;
                border: 1px solid #4b5563;
                text-align: center;
            }

            th {
                background-color: #111827;
            }

            img {
                max-width: 80px;
                border-radius: 4px;
            }

            .total-section {
                text-align: right;
                font-size: 1.2rem;
                font-weight: bold;
            }

            .checkout-btn {
                background-color: #00ADB5;
                padding: 10px 20px;
                color: white;
                border: none;
                border-radius: 4px;
                float: right;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .checkout-btn:hover {
                background-color: #03bfc9;
            }

            .remove-btn {
                background-color: #b91c1c;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
            }

            .remove-btn:hover {
                background-color: #dc2626;
            }

            .edit-form {
                display: flex;
                gap: 5px;
                justify-content: center;
                align-items: center;
            }

            .edit-input {
                width: 60px;
                text-align: center;
                padding: 4px;
            }

            .edit-btn {
                background-color: #00ADB5;
                color: white;
                border: none;
                padding: 4px 10px;
                border-radius: 4px;
                cursor: pointer;
            }

            .edit-btn:hover {
                background-color: #03bfc9;
            }
        </style>
    </head>
    <body>
        <h1>Giỏ hàng của bạn</h1>

        <div class="top-actions">
            <a href="MainController?action=ViewProductPage">← Tiếp tục mua sắm</a>
        </div>

        ${ errorMessage }
        ${ succesMessage }

        <c:if test="${empty sessionScope.CART.getAllItems()}">
            <p style="text-align:center;">Giỏ hàng của bạn đang trống.</p>
        </c:if>

        <c:if test="${not empty sessionScope.CART.getAllItems()}">
            <table>
                <thead>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Xóa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.CART.getAllItems()}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/image?name=${item.product.imgUrl}"
                                     alt="${item.product.productName}" />
                            </td>
                            <td>${item.product.productName}</td>
                            <td>${item.product.price}</td>

                            <!-- ✅ Form chỉnh sửa số lượng -->
                            <td>
                                <form class="edit-form" action="MainController" method="post">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" class="edit-input" />
                                    <input type="hidden" name="id" value="${item.product.productID}" />
                                    <input type="hidden" name="action" value="EditCart" />
                                    <button type="submit" class="edit-btn">Sửa</button>
                                </form>
                            </td>

                            <td>${item.totalPrice}</td>

                            <!-- ✅ Form xóa -->
                            <td>
                                <form action="MainController" method="post">
                                    <input type="hidden" name="action" value="RemoveCart" />
                                    <input type="hidden" name="id" value="${item.product.productID}" />
                                    <button type="submit" class="remove-btn">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="total-section">
                Tổng tiền: ${sessionScope.CART.totalAmount} VND
            </div>

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="Checkout" />
                <button type="submit" class="checkout-btn">Thanh toán</button>
            </form>
        </c:if>
    </body>
</html>
