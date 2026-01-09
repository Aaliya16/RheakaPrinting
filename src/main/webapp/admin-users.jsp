<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    UserAdminDao uDao = new UserAdminDao(DbConnection.getConnection());
    List<User> allUsers = uDao.getAllUsers();
    if (allUsers == null) allUsers = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f6fa; color: #2c3e50; }

        .main-content {
            margin-left: 260px; /* Matches your sidebar width */
            padding: 30px;
            min-height: 100vh;
            background: #f5f6fa;
        }

        /* 2. Force the Top Bar to be exactly 70px tall */
        .top-bar {
            background: white;
            padding: 0 35px; /* Side padding for the content inside */
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px; /* THIS IS THE KEY SIZE */
        }

        /* 3. Fix the title alignment */
        .top-bar h1 {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-weight: 600; /* This creates the specific bold effect you like */
            font-size: 24px;
            color: #1a3a6d; /* The deep navy blue used in your panel */
            margin: 0;
        }

        .admin-avatar {
            width: 40px; height: 40px; border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex; align-items: center; justify-content: center;
            color: white; font-weight: bold;
        }

        .content-card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); }
        .search-input { width: 100%; padding: 12px 20px; border: 2px solid #f0f0f0; border-radius: 8px; margin-bottom: 25px; outline: none; }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; background: #f8f9fa; color: #34495e; font-size: 12px; text-transform: uppercase; border-bottom: 2px solid #edf2f7; }
        td { padding: 18px 15px; border-bottom: 1px solid #f0f0f0; font-size: 14px; }

        .role-badge { padding: 6px 12px; border-radius: 6px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .role-badge.admin { background: #cfe2ff; color: #084298; }
        .role-badge.user { background: #e2e3e5; color: #41464b; }

        .btn-delete { width: 38px; height: 38px; border-radius: 8px; border: none; cursor: pointer; background: #ffebee; color: #e74c3c; transition: 0.3s; }
        .btn-delete:hover { background: #e74c3c; color: white; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <h1><i class="fas fa-users" style="color:#3498db"></i> User Management</h1>
        <div style="display: flex; align-items: center; gap: 15px;">
            <div class="admin-avatar">
                <%= (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A" %>
            </div>
            <strong><%= adminUser %></strong>
        </div>
    </div>

    <div class="content-card">
        <input type="text" class="search-input" id="userInput" placeholder="Search by name or email..." onkeyup="filterUsers()">

        <table id="userTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Ensure the list isn't empty before looping
                if (allUsers != null && !allUsers.isEmpty()) {
                    for (User user : allUsers) {
            %>
            <tr>
                <td>#<%= user.getUserId() %></td>
                <td><strong><%= user.getName() %></strong></td>
                <td><%= user.getEmail() %></td>
                <td>
            <span class="role-badge <%= user.getRole().toLowerCase() %>">
                <%= user.getRole() %>
            </span>
                </td>
                <td style="text-align: right;">
                    <button class="btn-action btn-delete"
                            onclick="confirmDelete(<%= user.getUserId() %>, '<%= user.getName() %>')"
                            style="background: #ffebee; color: #c62828; border: none; padding: 8px; border-radius: 5px; cursor: pointer;">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center; padding: 20px; color: #999;">
                    No users found in database.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterUsers() {
        const search = document.getElementById('userInput').value.toLowerCase();
        const rows = document.querySelectorAll('#userTable tbody tr');
        rows.forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(search) ? '' : 'none';
        });
    }

    function deleteUser(id, name) {
        if (confirm("Delete user: " + name + "?")) {
            window.location.href = "DeleteUserServlet?id=" + id;
        }
    }
</script>

<script>
    function confirmDelete(userId, userName) {
        if (confirm("Are you sure you want to delete user: " + userName + "?")) {
            // This sends the request to a DeleteUserServlet
            window.location.href = "DeleteUserServlet?id=" + userId;
        }
    }

    // Function for the search bar at the top of your screenshot
    function filterUsers() {
        let input = document.getElementById('userInput').value.toLowerCase();
        let rows = document.querySelectorAll('tbody tr');

        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(input) ? '' : 'none';
        });
    }
</script>

</body>
</html>