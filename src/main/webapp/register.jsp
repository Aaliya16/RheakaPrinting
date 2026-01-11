<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign Up - Rheaka Design</title>
    <style>
        /* Base styling with the signature Steel Blue gradient */
        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        /* Flex container to keep the footer at the bottom */
        .signup-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }
        .welcome-text {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        /* Centered white signup card */
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
        /* Input wrapper to hold the icon and the field together */
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
        /* Button styling matching the primary brand color */
        .signup-btn {
            background: #4682B4;
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
        .field-icon {
            width: 20px;
            height: 20px;
            object-fit: contain;
            flex-shrink: 0;
            margin-right: 12px;
        }

        .input-wrapper {
            background: #f0f0f0;
            border-radius: 12px;
            padding: 8px 15px;
            display: flex;
            align-items: center;
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
                    <img src="${pageContext.request.contextPath}/assets/img/icons8-account-male-50.png" class="field-icon" alt="Lock">
                    <input type="text" name="name" placeholder="Username" required>
                </div>
            </div>

            <div class="form-group">
                <label>Email</label>
                <div class="input-wrapper">
                    <img src="${pageContext.request.contextPath}/assets/img/icons8-email-30.png" class="field-icon" alt="User">
                    <input type="email" name="email" placeholder="Email" required>
                </div>
            </div>

            <div class="form-group">
                <label>Your password</label>
                <div class="input-wrapper">
                    <img src="${pageContext.request.contextPath}/assets/img/icons8-lock-30.png" class="field-icon" alt="Lock">
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