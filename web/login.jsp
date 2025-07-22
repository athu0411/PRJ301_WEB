<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #121212;
                color: #f0f0f0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .login-container {
                background: #1e1e1e;
                padding: 60px 80px;
                border-radius: 18px;
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.6);
                width: 600px;
                box-sizing: border-box;
            }

            h2 {
                text-align: center;
                font-size: 32px;
                margin-bottom: 35px;
                color: #ffffff;
            }

            label {
                font-size: 20px;
                color: #cccccc;
            }

            input[type="text"], input[type="password"], .btn {
                width: 100%;
                padding: 16px 20px;
                margin: 14px 0;
                border-radius: 8px;
                border: 1px solid #444;
                background-color: #2c2c2c;
                color: #f0f0f0;
                box-sizing: border-box;
                font-size: 18px;
            }

            input[type="text"]::placeholder,
            input[type="password"]::placeholder {
                color: #999999;
            }

            .btn {
                font-weight: bold;
                color: white;
                border: none;
                cursor: pointer;
            }

            .btn-login {
                background-color: #388e3c;
            }

            .btn-login:hover {
                background-color: #2e7d32;
            }

            .btn-register {
                background-color: #1976d2;
            }

            .btn-register:hover {
                background-color: #1565c0;
            }

            .error {
                color: #ff6b6b;
                text-align: center;
                margin-bottom: 20px;
                font-size: 18px;
            }

        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>

            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>

            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="Login"/>

                <label for="username">Username:</label>
                <input type="text" name="username" id="username" required />

                <label for="password">Password:</label>
                <input type="password" name="password" id="password" required />

                <input type="submit" class="btn btn-login" value="Login" />
            </form>

            <form action="MainController" method="GET">
                <input type="submit" class="btn btn-register" value="Sign Up" name="action"/>
            </form>
        </div>
    </body>
</html>
