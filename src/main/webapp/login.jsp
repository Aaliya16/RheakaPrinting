<%--
  Created by IntelliJ IDEA.
  User: MSI MODERN 15
  Date: 4/12/2025
  Time: 1:04 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-color: #B0C4DEFF;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }
        .login-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 80vh;
        }
        .welcome-text {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .login-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            width: 350px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            color: #666;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .input-wrapper {
            position: relative;
            background: #f0f0f0;
            border-radius: 8px;
            padding: 10px;
            display: flex;
            align-items: center;
        }
        .input-wrapper input {
            border: none;
            background: transparent;
            width: 100%;
            padding: 5px 10px;
            outline: none;
        }
        .sign-in-btn {
            background: linear-gradient(to right, #44cc00, #22aa00);
            color: white;
            border: none;
            width: 100%;
            padding: 15px;
            border-radius: 25px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }
        .sign-in-btn:hover {
            opacity: 0.9;
        }
        .footer-links {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            font-size: 13px;
        }
        .footer-links a {
            color: #0055ff;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="login-container">
    <h1 class="welcome-text">Welcome Back!</h1>

    <div class="login-card">
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label>Email</label>
                <div class="input-wrapper">
                    <span>👤</span>
                    <input type="text" name="email" placeholder="Email" required>
                </div>
            </div>

            <div class="form-group">
                <label>Your password</label>
                <div class="input-wrapper">
                    <span>🔒</span>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
            </div>

            <button type="submit" class="sign-in-btn">Sign In</button>

            <div class="footer-links">
                <a href="register.jsp">Don't have an account?</a>
                <a href="forgotpassword.jsp">Forgot password?</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>