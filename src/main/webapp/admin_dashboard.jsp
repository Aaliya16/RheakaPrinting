<%-- admin_dashboard.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*, com.example.rheakaprinting.dao.*, com.example.rheakaprinting.model.DbConnection, java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // ALL LOGIC KEPT EXACTLY THE SAME
    UserDAO userAdminDao = new UserDAO(com.example.rheakaprinting.model.DbConnection.getConnection());
    OrderDao orderAdminDao = new OrderDao(com.example.rheakaprinting.model.DbConnection.getConnection());

    List<com.example.rheakaprinting.model.Order> orderList = orderAdminDao.getAllOrders();
    int totalUsers = userAdminDao.getTotalUsers();

    int totalOrders = (orderList != null) ? orderList.size() : 0;
    int pendingOrders = 0;
    double totalRevenue = 0.0;

    if (orderList != null) {
        for(com.example.rheakaprinting.model.Order o : orderList) {
            totalRevenue += o.getPrice();
            if("pending".equalsIgnoreCase(o.getStatus())) {
                pendingOrders++;
            }
        }
    }

    // Re-assigning variable from auth check
    adminUser = (String) session.getAttribute("userName");
    String avatarLetter = (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --brand-color: #6c5ce7; /* Professional Purple */
            --brand-light: rgba(108, 92, 231, 0.1);
            --text-main: #2d3436;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

        /* Animation for the dashboard entry */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 30px;
            opacity: 0; /* Starts hidden */
            will-change: transform, opacity;
            /* FIX: Changed animation name to match keyframes below */
            animation: smoothSlideUp 0.7s cubic-bezier(0.22, 1, 0.36, 1) forwards;
        }

        /* FIX: Keyframes must match the name used in the animation property above */
        @keyframes smoothSlideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Staggered Row Animation - Makes the table rows "roll in" */
        tbody tr {
            opacity: 0;
            animation: rowAppear 0.5s ease-out forwards;
        }

        tbody tr:nth-child(1) { animation-delay: 0.2s; }
        tbody tr:nth-child(2) { animation-delay: 0.3s; }
        tbody tr:nth-child(3) { animation-delay: 0.4s; }
        tbody tr:nth-child(4) { animation-delay: 0.5s; }

        @keyframes rowAppear {
            from { opacity: 0; transform: translateX(-10px); }
            to { opacity: 1; transform: translateX(0); }
        }

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
        .header-icon-box {
            width: 50px; height: 50px; background: var(--brand-color);
            border-radius: 12px; display: flex; align-items: center; justify-content: center;
            color: white; font-size: 20px;
        }

        .top-bar h1 { font-size: 24px; color: var(--text-main); margin: 0; line-height: 1.2; }

        admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--brand-color); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 30px; }
        .stat-card {
            background: white; padding: 25px; border-radius: 20px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.04);
            transition: 0.3s ease;
        }
        .stat-card:hover { transform: translateY(-5px); }

        .stat-val { font-size: 28px; font-weight: 800; color: var(--text-main); }
        .stat-label { font-size: 11px; color: #b2bec3; text-transform: uppercase; font-weight: 700; margin-top: 5px; }

        /* Monochrome Icons */
        .stat-icon-mini {
            width: 45px; height: 45px; border-radius: 12px;
            background: var(--brand-light);
            display: flex; align-items: center; justify-content: center;
            color: var(--brand-color); font-size: 18px;
        }

        .quick-actions-grid {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 20px; margin-bottom: 30px;
        }
        .action-card {
            background: white; padding: 20px; border-radius: 20px;
            text-decoration: none; display: flex; align-items: center; gap: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.04);
            transition: all 0.2s ease; cursor: pointer;
        }
        .action-card:hover { transform: translateY(-5px); border-left: 4px solid var(--brand-color); }

        .action-icon {
            width: 45px; height: 45px; border-radius: 12px;
            background: #f1f2f6; display: flex; align-items: center;
            justify-content: center; font-size: 18px; color: var(--brand-color);
        }
        .action-info h3 { font-size: 15px; font-weight: 700; color: #1a3a6d; margin: 0; }
        .action-info p { font-size: 12px; color: #7f8c8d; margin: 0; }

        .section-title { font-size: 18px; margin-bottom: 20px; color: var(--text-main); font-weight: 700; }

        .back-container { display: flex; justify-content: flex-end; margin-top: 25px; }
        .btn-back {
            display: flex; align-items: center; gap: 8px; padding: 10px 20px;
            background: white; color: var(--brand-color); border: 2px solid var(--brand-color);
            border-radius: 12px; font-weight: 700; font-size: 13px; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { background: var(--brand-color); color: white; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div class="header-left">
            <div class="header-icon-box"><i class="fas fa-th-large"></i></div>
            <h1>Dashboard<br><span style="font-weight: 400; font-size: 22px;">Overview</span></h1>
        </div>

        <div class="admin-profile" style="display: flex; align-items: center; gap: 15px;">
            <%-- NEW: Welcome Greeting --%>
            <div style="text-align: right;">
        <span style="display:block; font-size: 14px; color: var(--text-main); font-weight: 600;">
            Welcome, Administrator
        </span>
            </div>

            <%-- Avatar Circle --%>
            <div class="avatar-circle">
                <%= (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= totalOrders %></div>
                <div class="stat-label">Total Orders</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-shopping-cart"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= totalUsers %></div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-users"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val" style="font-size: 22px;">RM <%= String.format("%.2f", totalRevenue) %></div>
                <div class="stat-label">Revenue</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-wallet"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= pendingOrders %></div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-hourglass-half"></i></div>
        </div>
    </div>

    <h2 class="section-title">Quick Tools</h2>
    <div class="quick-actions-grid">
        <%-- SWAPPED: Orders first, then Products --%>
        <a href="admin-orders.jsp" class="action-card">
            <div class="action-icon"><i class="fas fa-shopping-bag"></i></div>
            <div class="action-info"><h3>Process Orders</h3><p>Manage customer sales</p></div>
        </a>

        <a href="admin-products.jsp" class="action-card">
            <div class="action-icon"><i class="fas fa-tag"></i></div>
            <div class="action-info"><h3>Manage Products</h3><p>Update inventory</p></div>
        </a>

        <a href="admin-users.jsp" class="action-card">
            <div class="action-icon"><i class="fas fa-user-cog"></i></div>
            <div class="action-info"><h3>Manage Users</h3><p>Customer accounts</p></div>
        </a>

            <a href="admin-quotes.jsp" class="action-card">
                <div class="action-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                <div class="action-info"><h3>Quote Requests</h3><p>View custom inquiries</p></div>
            </a>

        <a href="admin-contact-messages.jsp" class="action-card">
            <div class="action-icon"><i class="fas fa-envelope"></i></div>
            <div class="action-info"><h3>Messages</h3><p>Customer inquiries</p></div>
        </a>

        <%-- ADDED: Settings Card --%>
        <a href="admin-settings.jsp" class="action-card">
            <div class="action-icon"><i class="fas fa-cog"></i></div>
            <div class="action-info"><h3>Settings</h3><p>System configuration</p></div>
        </a>
    </div>

    <div class="back-container">
        <button onclick="window.history.back()" class="btn-back">
            <i class="fas fa-arrow-left"></i> Go Back
        </button>
    </div>
</div>

</body>
</html>