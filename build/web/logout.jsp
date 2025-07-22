<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate(); // Xóa toàn bộ session
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng xuất</title>
        <meta http-equiv="refresh" content="3;url=index.jsp"> <!-- Chuyển về trang chủ sau 3s -->
        <style>
            body {
                background-color: #121212;
                color: #f0f0f0;
                font-family: 'Segoe UI', sans-serif;
                text-align: center;
                padding-top: 100px;
            }

            .message {
                font-size: 24px;
                margin-bottom: 20px;
            }

            .redirect {
                font-size: 16px;
                color: #bbbbbb;
            }

            a {
                color: #66ccff;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="message">Bạn đã đăng xuất thành công.</div>
        <div class="redirect">Đang chuyển về <a href="index.jsp">trang chủ</a> trong giây lát...</div>
    </body>
</html>
F