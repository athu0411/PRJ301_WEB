<%@page import="model.UsersErrors"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Register</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                width: 400px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-top: 15px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="password"],
            input[type="email"],
            input[type="tel"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
                font-size: 14px;
            }
            input[type="submit"], .back-button {
                margin-top: 15px;
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
            }
            input[type="submit"]:hover {
                background-color: #45a049;
            }
            .back-button {
                background-color: #ccc;
                color: black;
                text-align: center;
                text-decoration: none;
                display: inline-block;
            }
            .back-button:hover {
                background-color: #bbb;
            }
            .message {
                text-align: center;
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 5px;
            }
            .error {
                background-color: #f8d7da;
                color: #842029;
            }
            .success {
                background-color: #d1e7dd;
                color: #0f5132;
            }
            .error-text {
                color: red;
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Đăng ký tài khoản</h2>

            <%
                request.setCharacterEncoding("UTF-8");
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                UsersErrors errors = (UsersErrors) request.getAttribute("USER_ERROR");
            %>

            <% if (error != null) {%>
            <div class="message error"><%= error%></div>
            <% } else if (success != null) {%>
            <div class="message success"><%= success%></div>
            <% }%>

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="Register" />

                <label for="username">Username:</label>
                <input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : ""%>" required />
                <div class="error-text"><%= errors != null ? errors.getUsername() : ""%></div>

                <label for="password">Password:</label>
                <input type="password" name="password" required />
                <div class="error-text"><%= errors != null ? errors.getPassword() : ""%></div>

                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" name="confirmPassword" required />
                <!-- Không có getConfirmPassword trong UsersErrors nên không hiển thị lỗi -->

                <label for="fullname">Full Name:</label>
                <input type="text" name="fullName" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : ""%>" required />
<!--                <div class="error-text"><%= errors != null ? errors.getFullname() : ""%></div>-->

                <label for="email">Email:</label>
                <input type="email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : ""%>" required />
                <div class="error-text"><%= errors != null ? errors.getEmail() : ""%></div>

                <label for="phone">Phone:</label>
                <input type="tel" name="phone" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : ""%>" required />
<!--                <div class="error-text"><%= errors != null ? errors.getPhone() : ""%></div>-->

                <label for="address">Address:</label>
                <input type="text" name="address" value="<%= request.getParameter("address") != null ? request.getParameter("address") : ""%>" required />
<!--                <div class="error-text"><%= errors != null ? errors.getAddress() : ""%></div>-->

                <input type="submit" value="Register"/>
            </form>

            <form action="login.jsp" method="get">
                <button type="submit" class="back-button">← Back to Login</button>
            </form>
        </div>
    </body>
</html>
