<%-- admin-users.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Logic remains exactly the same
    UserDAO uDao = new UserDAO(DbConnection.getConnection());
    List<User> allUsers = uDao.getAllUsers();
    if (allUsers == null) allUsers = new ArrayList<>();

    int totalUsers = allUsers.size();
    int adminCount = 0;
    for(User u : allUsers) {
        if("admin".equalsIgnoreCase(u.getRole())) adminCount++;
    }
    int customerCount = totalUsers - adminCount;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --brand-color: #6c5ce7; /* Professional Purple */
            --brand-light: rgba(108, 92, 231, 0.1);
            --bg-body: #f1f2f6;
            --text-main: #2d3436;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

        .main-content { margin-left: 260px; padding: 30px; min-height: 100vh; }

        /* Standardized Top Bar */
        .top-bar {
            background: white;
            padding: 20px 35px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left { display: flex; align-items: center; gap: 20px; }

        /* Standardized Icon Box size */
        .header-icon-box {
            width: 50px; height: 50px; min-width: 50px;
            background: var(--brand-color);
            border-radius: 15px; display: flex; align-items: center; justify-content: center;
            color: white;
        }
        .header-icon-box i { font-size: 22px; }

        .top-bar h1 { font-size: 24px; color: var(--text-main); margin: 0; line-height: 1.2; }

        .search-container {
            background: #f1f2f6; border-radius: 12px; padding: 10px 20px;
            display: flex; align-items: center; gap: 10px; width: 350px;
        }
        .search-container input { border: none; background: transparent; outline: none; width: 100%; font-size: 14px; }

        .admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--brand-color); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        /* Monochrome Stats Grid */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 30px; }
        .stat-card {
            background: white; padding: 25px; border-radius: 20px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.04); transition: 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-val { font-size: 32px; font-weight: 800; color: var(--text-main); }
        .stat-label { font-size: 11px; color: #b2bec3; text-transform: uppercase; font-weight: 700; margin-top: 5px; }

        .stat-icon-mini {
            width: 45px; height: 45px; border-radius: 12px;
            background: var(--brand-light);
            display: flex; align-items: center; justify-content: center;
            color: var(--brand-color); font-size: 18px;
        }

        .content-card {
            background: white; padding: 30px; border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04); min-height: 400px;
        }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; color: #b2bec3; font-size: 11px; text-transform: uppercase; border-bottom: 2px solid #f1f2f6; }
        td { padding: 20px 15px; border-bottom: 1px solid #f1f2f6; font-size: 14px; }

        .role-badge { padding: 6px 12px; border-radius: 6px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .role-badge.admin { background: #d1e7dd; color: #0f5132; }
        .role-badge.user { background: #f1f2f6; color: #636e72; }

        .btn-delete { width: 38px; height: 38px; border-radius: 10px; border: none; cursor: pointer; background: #fff5f5; color: #ee5253; transition: 0.2s; }
        .btn-delete:hover { transform: scale(1.1); background: #ee5253; color: white; }

        /* Back Button */
        .back-container { display: flex; justify-content: flex-end; margin-top: 30px; }
        .btn-back {
            display: flex; align-items: center; gap: 8px; padding: 12px 25px;
            background: white; color: var(--brand-color); border: 2px solid var(--brand-color);
            border-radius: 12px; font-weight: 700; font-size: 14px; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { background: var(--brand-color); color: white; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <%-- Standardized Top Bar --%>
    <div class="top-bar">
        <div class="header-left">
            <div class="header-icon-box"><i class="fas fa-users"></i></div>
            <h1>User<br><span style="font-weight: 400; font-size: 22px;">Management</span></h1>
        </div>

        <div class="search-container">
            <i class="fas fa-search" style="color: var(--brand-color);"></i>
            <input type="text" id="userInput" onkeyup="filterUsers()" placeholder="Search by name or email...">
        </div>

        <div class="admin-profile">
            <strong style="font-size: 14px; margin-right: 10px;"><%= adminUser %></strong>
            <div class="avatar-circle">
                <%= (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <%-- 4-Column Stats Grid --%>
    <div class="stats-grid">
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= totalUsers %></div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-user-friends"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= adminCount %></div>
                <div class="stat-label">Admins</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-user-shield"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= customerCount %></div>
                <div class="stat-label">Customers</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-user-tag"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val">Live</div>
                <div class="stat-label">Status</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-signal"></i></div>
        </div>
    </div>

    <div class="content-card">
        <table id="userTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>User Details</th>
                <th>Role</th>
                <th style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (!allUsers.isEmpty()) {
                for (User user : allUsers) { %>
            <tr>
                <td>#<%= user.getUserId() %></td>
                <td>
                    <div style="font-weight: 700; color: var(--text-main);"><%= user.getName() %></div>
                    <div style="font-size: 12px; color: var(--brand-color);"><%= user.getEmail() %></div>
                </td>
                <td>
                    <span class="role-badge <%= user.getRole().toLowerCase() %>">
                        <%= user.getRole() %>
                    </span>
                </td>
                <td style="text-align: right;">
                    <button class="btn-delete" title="Delete User"
                            onclick="confirmDelete(<%= user.getUserId() %>, '<%= user.getName().replace("'", "\\'") %>')">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="4" style="text-align: center; padding: 60px; color: #b2bec3;">
                    <i class="fas fa-user-slash" style="font-size: 40px; display: block; margin-bottom: 15px;"></i>
                    No users found in database.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <%-- Standardized Back Button --%>
        <div class="back-container">
            <button onclick="window.history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </button>
        </div>
    </div>
</div>

<script>
    function filterUsers() {
        const search = document.getElementById('userInput').value.toLowerCase();
        const rows = document.querySelectorAll('#userTable tbody tr');
        rows.forEach(row => {
            const rowText = row.innerText.toLowerCase();
            row.style.display = rowText.includes(search) ? '' : 'none';
        });
    }

    function confirmDelete(userId, userName) {
        if (confirm("Are you sure you want to delete user: " + userName + "?\nThis action cannot be undone.")) {
            window.location.href = "DeleteUserServlet?id=" + userId;
        }
    }
</script>

</body>
</html>