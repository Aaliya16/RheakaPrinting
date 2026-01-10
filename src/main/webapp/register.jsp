<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 20/12/2025
  Time: 12:24 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign Up - Rheaka Design</title>
    <style>
        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column; /* This stacks Header, Content, and Footer vertically */
            min-height: 100vh;
        }

        .signup-container {
            flex: 1; /* This pushes the footer to the bottom of the page */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 0; /* Ensures space between header and card */
        }
        .welcome-text {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .signup-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            width: 350px;
        }
        .form-group {
            margin-bottom: 15px;
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
        .signup-btn {
            background: linear-gradient(to right, #44cc00, #22aa00); /* Green gradient matching login.jsp */
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
        .signup-btn:hover {
            opacity: 0.9;
        }
        .footer-links {
            text-align: center;
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
<div class="signup-container">
    <h1 class="welcome-text">Create Account</h1>

    <div class="signup-card">
        <%
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("1")) {
        %>
        <div class="error-message">❌ Registration failed. Please try again.</div>
        <%
        } else if (error.equals("server")) {
        %>
        <div class="error-message">❌ Server error. Please contact support.</div>
        <%
                }
            }

            String success = request.getParameter("success");
            if (success != null && success.equals("1")) {
        %>
        <div class="success-message">✓ Registration successful! Please login.</div>
        <%
            }
        %>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label>Username</label>
                <div class="input-wrapper">
                    <span>👤</span>
                    <input type="text" name="name" placeholder="Full Name" required>
                </div>
            </div>

            <div class="form-group">
                <label>Email</label>
                <div class="input-wrapper">
                    <span>✉️</span>
                    <input type="email" name="email" placeholder="Email Address" required>
                </div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <span>🔒</span>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
            </div>

            <button type="submit" class="signup-btn">Sign Up</button>

            <div class="footer-links">
                <p>Already have an account? <a href="login.jsp">Sign In</a></p>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>