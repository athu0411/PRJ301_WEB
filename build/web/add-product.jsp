<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin: Thêm sản phẩm</title>
        <style>
            :root {
                --bg-dark: #1f2937;
                --bg-secondary: #374151;
                --text-light: #f3f4f6;
                --text-muted: #9ca3af;
                --primary: #00ADB5;
                --primary-hover: #008d95;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--bg-dark);
                color: var(--text-light);
                margin: 0;
                padding: 0;
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

            .container {
                max-width: 700px;
                margin: 40px auto;
                background-color: #111827;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: var(--primary);
            }

            form label {
                display: block;
                margin-top: 15px;
                font-weight: 500;
            }

            input[type="text"],
            input[type="number"],
            select,
            textarea,
            input[type="file"] {
                width: 100%;
                padding: 10px;
                margin-top: 6px;
                border: none;
                border-radius: 6px;
                background-color: #1e293b;
                color: var(--text-light);
            }

            textarea {
                resize: vertical;
            }

            .btn-group {
                text-align: center;
                margin-top: 25px;
            }

            input[type="submit"] {
                background-color: var(--primary);
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: var(--primary-hover);
            }

            .message {
                text-align: center;
                margin-top: 15px;
                font-weight: bold;
            }

            .message.error {
                color: #f87171;
            }

            .message.success {
                color: #34d399;
            }
        </style>
    </head>
    <body>
        <header>
            <h1>MLB Store Admin</h1>
        </header>

        <div class="container">
            <h2>Thêm sản phẩm mới</h2>

            <form action="MainController" method="POST" enctype="multipart/form-data">
                <label for="name">Tên sản phẩm:</label>
                <input type="text" name="name" id="name" placeholder="Tên sản phẩm" required />

                <label for="price">Giá:</label>
                <input type="text" name="price" id="price" placeholder="VD: 199000" required />

                <label for="stock">Số lượng:</label>
                <input type="number" name="stock" id="stock" placeholder="VD: 100" required />

                <label for="category">Danh mục:</label>
                <select name="categoryID" id="category" required>
                    <option value="">--Chọn danh mục--</option>
                    <option value="1">Áo thun</option>
                    <option value="2">Áo sơ mi</option>
                    <option value="3">Quần jean</option>
                    <option value="4">Quần tây</option>
                    <option value="5">Áo khoác</option>
                    <option value="6">Váy</option>
                    <option value="7">Khác</option>
                </select>

                <label for="image">Ảnh sản phẩm:</label>
                <input type="file" name="image" id="image" />

                <label for="description">Mô tả:</label>
                <textarea name="description" id="description" placeholder="Mô tả chi tiết..." rows="4"></textarea>

                <input type="hidden" name="action" value="AddProduct" />
                <input type="hidden" name="productId" value="" />

                <div class="btn-group">
                    <input type="submit" value="Thêm sản phẩm" />
                </div>
            </form>

            <div class="message error">${requestScope.errorMessage}</div>
            <div class="message success">${requestScope.successMessage}</div>
        </div>
    </body>
</html>
