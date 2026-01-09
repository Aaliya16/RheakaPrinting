<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/1/2026
  Time: 5:28 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Rheaka Printing</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #2c3e50;
            --accent: #3498db;
            --danger: #e74c3c;
            --success: #2ecc71;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .admin-login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 400px;
            width: 100%;
            padding: 40px;
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .admin-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .admin-header .shield-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .admin-header h1 {
            color: var(--primary);
            font-size: 24px;
            margin-bottom: 5px;
        }

        .admin-header p {
            color: #7f8c8d;
            font-size: 14px;
        }

        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            animation: shake 0.5s;
        }

        .alert-danger {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: var(--primary);
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
        }

        input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #7f8c8d;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link a:hover {
            color: var(--accent);
        }

        .security-note {
            background: #fff3cd;
            border: 1px solid #ffc107;
            padding: 10px;
            border-radius: 8px;
            font-size: 13px;
            color: #856404;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="admin-login-container">
    <div class="admin-header">
        <div class="shield-icon">🛡️</div>
        <h1>Admin Panel</h1>
        <p>Rheaka Printing Management</p>
    </div>

    <div class="security-note">
        🔒 Authorized Personnel Only
    </div>

    <% if(request.getParameter("msg") != null) {
        String msg = request.getParameter("msg");
        if(msg.equals("failed")) { %>
    <div class="alert alert-danger">
        ❌ Invalid admin credentials
    </div>
    <% } else if(msg.equals("unauthorized")) { %>
    <div class="alert alert-danger">
        ⚠️ Admin access required
    </div>
    <% }
    } %>

    <form action="AdminLoginServlet" method="POST">
        <div class="form-group">
            <label for="adminUsername">Admin Username</label>
            <div class="input-wrapper">
                <span class="input-icon">👤</span>
                <input type="text"
                       id="adminUsername"
                       name="adminUsername"
                       placeholder="Enter admin username"
                       required>
            </div>
        </div>

        <div class="form-group">
            <label for="adminPassword">Admin Password</label>
            <div class="input-wrapper">
                <span class="input-icon">🔐</span>
                <input type="password"
                       id="adminPassword"
                       name="adminPassword"
                       placeholder="Enter admin password"
                       required>
            </div>
        </div>

        <button type="submit" class="btn-login">
            Login to Admin Panel
        </button>
    </form>

    <div class="back-link">
        <a href="index.jsp">← Back to Main Site</a>
    </div>
</div>

</body>
</html>