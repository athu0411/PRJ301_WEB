<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 20px;
            }
            h1 {
                text-align: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            img {
                max-width: 100px;
            }
            .actions button {
                margin: 0 5px;
                padding: 6px 12px;
                border: none;
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
            }
            .actions button.delete {
                background-color: #f44336;
            }
            .top-actions {
                text-align: right;
                margin-bottom: 15px;
            }
            .top-actions a {
                text-decoration: none;
                background-color: #2196F3;
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <h1>Quản lý sản phẩm</h1>
        ${ successMessage }

        <div class="top-actions">
            <a href="add-product.jsp">Thêm sản phẩm</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Mô tả</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Hình ảnh</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${productList}">
                    <tr>
                        <td>${product.productID}</td>
                        <td>${product.productName}</td>
                        <td>${product.description}</td>
                        <td>${product.price}</td>
                        <td>${product.quantity}</td>
                        <td>
                            <img src="${product.imgUrl}" alt="${product.productName}" />
                        </td>
                        <td class="actions">
                            <form action="MainController" method="get" style="display:inline;" enctype="multipart/form-data">
                                <input type="hidden" name="productId" value="${product.productID}" />
                                <button type="submit">Sửa</button>
                                <input type="hidden" name="action" value="UpdateProduct"/>
                            </form>
                            <form action="MainController" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                <input type="hidden" name="productId" value="${product.productID}" />
                                <button type="submit" class="delete">Xóa</button>
                                <input type="hidden" name="action" value="DeleteProduct"/>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
