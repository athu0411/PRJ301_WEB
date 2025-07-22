<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #121212;
                margin: 0;
                padding: 20px;
                color: #e0e0e0;
            }
            h1 {
                text-align: center;
                color: #ffffff;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #1f1f1f;
                margin-top: 20px;
                color: #e0e0e0;
            }
            th, td {
                border: 1px solid #333;
                padding: 12px;
                text-align: center;
            }
            th {
                background-color: #2a2a2a;
                color: #ffffff;
            }
            img {
                max-width: 100px;
            }
            .actions button {
                margin: 0 5px;
                padding: 6px 12px;
                border: none;
                background-color: #444;
                color: white;
                cursor: pointer;
                border-radius: 4px;
                transition: background-color 0.3s, transform 0.2s;
            }
            .actions button:hover {
                background-color: #666;
                transform: scale(1.05);
            }
            .actions button.delete {
                background-color: #b71c1c;
            }
            .actions button.delete:hover {
                background-color: #e53935;
            }
            .top-actions {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }
            .top-actions a {
                text-decoration: none;
                background-color: #2962ff;
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .top-actions a:hover {
                background-color: #448aff;
            }
        </style>
    </head>
    <body>
        <h1>Quản lý sản phẩm</h1>
        ${ successMessage }

        <div class="top-actions">
            <a href="index.jsp">Trang chủ</a>
            <a href="MainController?action=Logout">Logout</a>
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
                    <th>Danh mục</th> <!-- Thêm cột -->
                    <th>Hình ảnh</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${ requestScope.LIST_PRODUCT }">
                    <tr>
                        <td>${product.productID}</td>
                        <td>${product.productName}</td>
                        <td>${product.description}</td>
                        <td>$ ${product.price}</td>
                        <td>${product.quantity}</td>
                        <td>${product.categoryID}</td> <!-- Thêm giá trị -->
                        <td>
                            <img src="${pageContext.request.contextPath}/image?name=${product.imgUrl}"
                                 alt="${product.productName}"
                                 onerror="this.src='images/default.jpg'"
                                 style="width: 100%; height: 250px; object-fit: cover; border-radius: 4px;" />
                        </td>
                        <td class="actions">
                            <button type="button"
                                    onclick="openEditModal('${product.productID}',
                                                    '${fn:escapeXml(product.productName)}',
                                                    '${fn:escapeXml(product.description)}',
                                                    '${product.price}',
                                                    '${product.quantity}',
                                                    '${product.categoryID}')">
                                Sửa
                            </button>
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

        <!-- Modal sửa sản phẩm -->
        <div id="editModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
             background: rgba(0,0,0,0.5); justify-content:center; align-items:center; z-index:9999;">
            <div style="background:#1f1f1f; padding:20px; border-radius:8px; width:400px; position:relative; color:white;">
                <h3 style="margin-top:0;">Sửa sản phẩm</h3>
                <form id="editForm" action="MainController" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="UpdateProduct" />
                    <input type="hidden" name="productId" id="editProductId" />

                    <label for="editName">Tên sản phẩm:</label><br/>
                    <input type="text" id="editName" name="name" required /><br/><br/>

                    <label for="editDescription">Mô tả:</label><br/>
                    <textarea id="editDescription" name="description" rows="3" required></textarea><br/><br/>

                    <label for="editPrice">Giá:</label><br/>
                    <input type="number" step="0.01" id="editPrice" name="price" required /><br/><br/>

                    <label for="editQuantity">Số lượng:</label><br/>
                    <input type="number" id="editQuantity" name="quantity" required /><br/><br/>

                    <label for="editCategoryID">Danh mục (CategoryID):</label><br/>
                    <input type="text" id="editCategoryID" name="categoryID" required /><br/><br/> <!-- Thêm trường -->

                    <label for="editImage">Hình ảnh mới:</label><br/>
                    <input type="file" id="editImage" name="image" /><br/><br/>

                    <button type="submit">Cập nhật</button>
                    <button type="button" onclick="closeModal()">Hủy</button>
                </form>
            </div>
        </div>

        <script>
            function openEditModal(productID, name, description, price, quantity, categoryID) {
                document.getElementById("editProductId").value = productID;
                document.getElementById("editName").value = name;
                document.getElementById("editDescription").value = description;
                document.getElementById("editPrice").value = price;
                document.getElementById("editQuantity").value = quantity;
                document.getElementById("editCategoryID").value = categoryID;
                document.getElementById("editModal").style.display = "flex";
            }

            function closeModal() {
                document.getElementById("editModal").style.display = "none";
            }
        </script>
    </body>
</html>
