<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Rheaka Design</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Shared visual theme: Steel Blue gradient background */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        /* Centering the reset card on the page */
        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 100px 20px;
        }
        /* Card styling for the reset form */
        .card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }
        p {
            color: #666;
            font-size: 14px;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        .input-group {
            position: relative;
            margin-bottom: 25px;
        }
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
        }
        .input-group input {
            width: 100%;
            padding: 12px 12px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f1f1f1;
            box-sizing: border-box;
            outline: none;
        }
        /* Standardized button style matching the site's primary color */
        .btn-reset {
            background: #4682B4;
            color: white;
            border: none;
            padding: 15px;
            width: 100%;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-reset:hover {
            background: #4682B4;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
        }
        footer {
            text-align: center;
            padding: 20px;
            color: #666;
            font-size: 12px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <div class="card">
        <h2>Forgot your password</h2>
        <p>Please enter the email address you'll like your password reset information sent to</p>

        <form action="ForgotPasswordServlet" method="post">
            <div class="input-group">
                <i class="fa-solid fa-envelope"></i>
                <input type="email" name="email" placeholder="Enter email address" required>
            </div>

            <button type="submit" class="btn-reset">Request reset link</button>

            <a href="login.jsp" class="back-link">Back To Login</a>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>

</body>
</html>