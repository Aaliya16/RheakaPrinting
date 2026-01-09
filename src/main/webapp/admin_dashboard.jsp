<%-- admin_dashboard.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*, com.example.rheakaprinting.dao.*, com.example.rheakaprinting.model.DbConnection, java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Using the new Admin DAOs for live website integration
    UserAdminDao userAdminDao = new UserAdminDao(com.example.rheakaprinting.model.DbConnection.getConnection());
    OrderAdminDao orderAdminDao = new OrderAdminDao(com.example.rheakaprinting.model.DbConnection.getConnection());

    int totalUsers = userAdminDao.getTotalUsers();
    int adminCount = userAdminDao.getAdminCount();

    List<com.example.rheakaprinting.model.Order> orderList = orderAdminDao.getAllOrders();
    int totalOrders = (orderList != null) ? orderList.size() : 0;

    double totalRevenue = 0.0;
    int pendingOrders = 0;

    if (orderList != null) {
        for(com.example.rheakaprinting.model.Order o : orderList) {
            totalRevenue += (o.getPrice() * o.getQuantity());
            if("pending".equalsIgnoreCase(o.getStatus())) {
                pendingOrders++;
            }
        }
    }

    adminUser = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f6fa; color: #2c3e50; }
        .main-content { margin-left: 260px; padding: 30px; min-height: 100vh; }

        .top-bar {
            background: white; padding: 0 35px; border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08); margin-bottom: 30px;
            display: flex; justify-content: space-between; align-items: center;
            height: 70px;
        }
        .top-bar h1 { font-size: 24px; font-weight: 600; color: #1a3a6d; margin: 0; }

        .admin-avatar {
            width: 35px; height: 35px; border-radius: 50%;
            background: #5f27cd; color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        /* Modified Summary Cards: Hover animation only, not interactive */
        .stat-card {
            background: white; padding: 15px 25px; height: 110px;
            border-radius: 12px; display: flex; align-items: center; gap: 20px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth hover transition */
            cursor: default; /* Removes the "hand" cursor */
        }

        .stat-card:hover {
            transform: translateY(-5px); /* Gentle lift animation */
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
        }

        .stat-icon { width: 55px; height: 55px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px; color: white; }
        .blue { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .green { background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%); }
        .pink { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .yellow { background: linear-gradient(135deg, #f6d365 0%, #fda085 100%); }

        .quick-actions-grid {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 20px; margin-bottom: 30px;
        }
        .action-card {
            background: white; padding: 20px; border-radius: 12px;
            text-decoration: none; display: flex; align-items: center; gap: 15px;
            border: 1px solid #edf2f7; transition: all 0.2s ease; cursor: pointer;
        }
        .action-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: #3498db; }

        /* Animation Classes */
        @keyframes cardPulse {
            0% { transform: scale(1); }
            50% { transform: scale(0.92); }
            100% { transform: scale(1); }
        }
        .animate-pulse { animation: cardPulse 0.3s ease-in-out; }

        .action-icon { width: 45px; height: 45px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .action-info h3 { font-size: 15px; font-weight: 600; color: #1a3a6d; margin: 0; }
        .action-info p { font-size: 12px; color: #7f8c8d; margin: 0; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div style="display: flex; align-items: center; gap: 15px;">
            <i class="fas fa-shield-alt" style="font-size: 24px; color: #3498db;"></i>
            <h1>Dashboard Overview</h1>
        </div>
        <div style="display:flex; align-items:center; gap:12px;">
            <div style="text-align: right;">
                <%-- Bolded and updated welcome message --%>
                <span style="display:block; font-size: 11px; color: #2c3e50; text-transform: uppercase; font-weight: 800;">Welcome, Administrator</span>
                <strong style="font-size: 14px;"><%= adminUser %></strong>
            </div>
            <div class="admin-avatar">
                <%= (adminUser != null && adminUser.length() > 0) ? adminUser.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <%-- 1. Dashboard Summary with Animation --%>
    <%-- 1. Dashboard Summary (Hover Animation Only) --%>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon blue"><i class="fas fa-shopping-cart"></i></div>
            <div><h3 style="font-size:22px;"><%= totalOrders %></h3><p style="color:#7f8c8d; font-size:13px;">Total Orders</p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green"><i class="fas fa-users"></i></div>
            <div><h3 style="font-size:22px;"><%= totalUsers %></h3><p style="color:#7f8c8d; font-size:13px;">Users</p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon pink"><i class="fas fa-money-bill-wave"></i></div>
            <div><h3 style="font-size:20px;">RM <%= String.format("%.2f", totalRevenue) %></h3><p style="color:#7f8c8d; font-size:13px;">Revenue</p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon yellow"><i class="fas fa-hourglass-half"></i></div>
            <div><h3 style="font-size:22px;"><%= pendingOrders %></h3><p style="color:#7f8c8d; font-size:13px;">Pending</p></div>
        </div>
    </div>

    <h2 style="font-size: 18px; margin-bottom: 20px; color: #1a3a6d;">Quick Actions</h2>
    <div class="quick-actions-grid">
        <a href="javascript:void(0)" onclick="playAnim(this, 'admin-products.jsp')" class="action-card">
            <div class="action-icon" style="background: #e1f5fe; color: #0288d1;"><i class="fas fa-tag"></i></div>
            <div class="action-info"><h3>Manage Products</h3><p>Update inventory</p></div>
        </a>

        <a href="javascript:void(0)" onclick="playAnim(this, 'admin-orders.jsp')" class="action-card">
            <div class="action-icon" style="background: #fff3e0; color: #f57c00;"><i class="fas fa-shopping-bag"></i></div>
            <div class="action-info"><h3>Process Orders</h3><p>Manage sales</p></div>
        </a>

        <a href="javascript:void(0)" onclick="playAnim(this, 'admin-users.jsp')" class="action-card">
            <div class="action-icon" style="background: #f0f4ff; color: #5f27cd;"><i class="fas fa-users"></i></div>
            <div class="action-info"><h3>Manage Users</h3><p>Customer accounts</p></div>
        </a>

        <a href="javascript:void(0)" onclick="playAnim(this, 'admin-contact-messages.jsp')" class="action-card">
            <div class="action-icon" style="background: #e8f5e9; color: #2e7d32;"><i class="fas fa-envelope"></i></div>
            <div class="action-info"><h3>Messages</h3><p>Customer inquiries</p></div>
        </a>

        <a href="javascript:void(0)" onclick="playAnim(this, 'admin-settings.jsp')" class="action-card">
            <div class="action-icon" style="background: #f3e5f5; color: #7b1fa2;"><i class="fas fa-cog"></i></div>
            <div class="action-info"><h3>System Settings</h3><p>Configure panel</p></div>
        </a>
    </div>
</div>

<script>
    function playAnim(element, url) {
        element.classList.add('animate-pulse');
        setTimeout(() => {
            if(url !== '#') window.location.href = url;
            element.classList.remove('animate-pulse');
        }, 300);
    }
</script>

</body>
</html>