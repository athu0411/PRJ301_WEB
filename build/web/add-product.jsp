<%-- 
    Document   : add-product
    Created on : Jul 19, 2025, 11:34:17 AM
    Author     : Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin: Add Product</title>
    </head>
    <body>
        <h1>Add new product</h1>
        
        <form action="MainController" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="productId" id="productId" value="" required="" /> <br />
            Name: <input type="text" name="name" id="name" placeholder="Tên sản phẩm" required="" /> <br />
            Price: <input type="number" name="price" id="price" placeholder="Giá" required="" /> <br />
            Stock: <input type="number" name="stock" id="stock" placeholder="Kho" required="" /> <br />
            Category: <select name="categoryID" id="category">
                <option value="">--Chọn danh mục--</option>
                <option value="1">Danh mục 1</option>
                <option value="2">Danh mục 2</option>
            </select> <br />
            Picture: <input type="file" name="image" id="image" /> <br />
            <textarea name="description" id="description" placeholder="Mô tả"></textarea> <br />

            <input type="submit" value="Add"/>
            <input type="hidden" name="action" value="AddProduct" />
        </form>
        ${ requestScope.errorMessage }
        ${ requestScope.successMessage }
    </body>
</html>
