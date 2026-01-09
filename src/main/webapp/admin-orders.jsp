<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Variable 'adminUser' is provided by admin-auth-check.jsp.

    DecimalFormat dcf = new DecimalFormat("#.##");

    // FIXED: Use OrderAdminDao to get ALL orders for the admin view
    OrderAdminDao orderAdminDao = new OrderAdminDao(DbConnection.getConnection());
    List<Order> allOrders = orderAdminDao.getAllOrders();

    if (allOrders == null) {
        allOrders = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders Management - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #2c3e50;
            --secondary: #34495e;
            --accent: #3498db;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light: #ecf0f1;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
        }
        .main-content {
            margin-left: 260px;
            padding: 30px;
            min-height: 100vh;
            background: #f5f6fa;
        }

        .top-bar {
            background: white;
            padding: 0 35px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }
        .top-bar h1 {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-weight: 600;
            font-size: 24px;
            color: #1a3a6d;
            margin: 0;
        }

        .content-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        }

        .admin-info { display: flex; align-items: center; gap: 15px; }
        .admin-avatar {
            width: 40px; height: 40px; border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex; align-items: center; justify-content: center;
            color: white; font-weight: bold; box-shadow: 0 4px 10px rgba(102, 126, 234, 0.3);
        }

        /* Stats Grid */
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 35px; }
        .stat-card {
            background: white; padding: 25px; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            display: flex; align-items: center; gap: 20px; transition: 0.3s;
        }
        .stat-icon { width: 60px; height: 60px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 28px; color: white; }

        .stat-icon.orange { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .stat-icon.blue { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .stat-icon.green { background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%); }
        .stat-icon.red { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }

        /* Table Styling */
        .content-card {
            background: white; padding: 30px; border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        .filter-bar { display: flex; gap: 15px; margin-bottom: 25px; }
        .search-input { flex: 1; padding: 12px 20px; border: 2px solid #f0f0f0; border-radius: 8px; outline: none; }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; background: #f8f9fa; color: var(--secondary); font-size: 12px; text-transform: uppercase; border-bottom: 2px solid #edf2f7; }
        td { padding: 18px 15px; border-bottom: 1px solid #f0f0f0; font-size: 14px; }

        .status-badge { padding: 6px 12px; border-radius: 6px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .status-badge.pending { background: #fff3cd; color: #856404; }
        .status-badge.processing { background: #cfe2ff; color: #084298; }
        .status-badge.completed { background: #d1e7dd; color: #0f5132; }

        .btn-action { width: 38px; height: 38px; border-radius: 8px; border: none; cursor: pointer; transition: 0.3s; display: inline-flex; align-items: center; justify-content: center; }
        .btn-view { background: #e3f2fd; color: #1976d2; }
        .btn-edit { background: #fff3cd; color: #856404; margin-left: 5px; }

        /* Modal */
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); backdrop-filter: blur(4px); }
        .modal-content { background: white; margin: 10% auto; padding: 30px; border-radius: 15px; width: 400px; box-shadow: 0 15px 50px rgba(0,0,0,0.2); }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="sidebar">
    <div class="sidebar-header">
        <i class="fas fa-shield-alt"></i>
        <h2>ADMIN PANEL</h2>
        <p>Rheaka Printing Management</p>
    </div>
    <ul class="nav-menu">
        <li class="nav-item"><a href="admin_dashboard.jsp" class="nav-link"><i class="fas fa-chart-line nav-icon"></i><span>Dashboard</span></a></li>
        <li class="nav-item"><a href="admin-orders.jsp" class="nav-link active"><i class="fas fa-box nav-icon"></i><span>Orders</span></a></li>
        <li class="nav-item"><a href="admin-products.jsp" class="nav-link"><i class="fas fa-tags nav-icon"></i><span>Products</span></a></li>
        <li class="nav-item"><a href="admin-users.jsp" class="nav-link"><i class="fas fa-users nav-icon"></i><span>Users</span></a></li>
        <li class="nav-item"><a href="admin-messages.jsp" class="nav-link"><i class="fas fa-envelope nav-icon"></i><span>Messages</span></a></li>
        <li class="nav-item"><a href="admin-settings.jsp" class="nav-link"><i class="fas fa-cog nav-icon"></i><span>Settings</span></a></li>
        <li class="nav-item" style="margin-top: 20px; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px;">
            <a href="logout.jsp" class="nav-link" style="color: #e74c3c;"><i class="fas fa-sign-out-alt nav-icon"></i><span>Logout</span></a>
        </li>
    </ul>
</div>

<div class="main-content">
    <div class="top-bar">
        <h1><i class="fas fa-shopping-bag"></i> Orders</h1>
        <div class="admin-info">
            <div class="admin-avatar">
                <%= (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A" %>
            </div>
            <strong><%= adminUser %></strong>
            <button onclick="window.print()" class="btn-action btn-view" style="width: auto; padding: 0 15px;"><i class="fas fa-print"></i></button>
        </div>
    </div>

    <%
        int pending = 0, processing = 0, completed = 0;
        for (Order o : allOrders) {
            // FIXED: Standardizing status check logic
            if ("pending".equalsIgnoreCase(o.getStatus())) pending++;
            else if ("processing".equalsIgnoreCase(o.getStatus())) processing++;
            else if ("completed".equalsIgnoreCase(o.getStatus())) completed++;
        }
    %>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon orange"><i class="fas fa-clock"></i></div>
            <div><h3><%= pending %></h3><p>Pending</p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon blue"><i class="fas fa-spinner"></i></div>
            <div><h3><%= processing %></h3><p>Processing</p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
            <div><h3><%= completed %></h3><p>Completed</p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon red"><i class="fas fa-file-invoice"></i></div>
            <div><h3><%= allOrders.size() %></h3><p>Total Orders</p></div>
        </div>
    </div>

    <div class="content-card">
        <div class="filter-bar">
            <input type="text" class="search-input" id="searchInput" placeholder="Search orders..." onkeyup="filterTable()">
            <select class="search-input" style="flex: 0.3;" id="statusFilter" onchange="filterTable()">
                <option value="">All Statuses</option>
                <option value="pending">Pending</option>
                <option value="processing">Processing</option>
                <option value="completed">Completed</option>
            </select>
        </div>

        <table id="ordersTable">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Date</th>
                <th>Total</th>
                <th>Status</th>
                <th style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Order order : allOrders) { %>
            <tr data-status="<%= order.getStatus() %>">
                <td><strong>#<%= order.getOrderId() %></strong></td>

                <td><%= order.getName() %></td>

                <td><%= order.getDate() %></td>

                <td><strong>RM <%= dcf.format(order.getPrice() * order.getQuantity()) %></strong></td>

                <td><span class="status-badge <%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span></td>

                <td style="text-align: right;">
                    <button class="btn-action btn-view" onclick="viewOrder(<%= order.getOrderId() %>)"><i class="fas fa-eye"></i></button>
                    <button class="btn-action btn-edit" onclick="openStatusModal(<%= order.getOrderId() %>, '<%= order.getStatus() %>', '<%= order.getOrderId() %>')"><i class="fas fa-edit"></i></button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<div id="statusModal" class="modal">
    <div class="modal-content">
        <h2 style="margin-bottom: 20px;">Update Status</h2>
        <form action="UpdateOrderStatusServlet" method="POST">
            <input type="hidden" id="modalOrderId" name="orderId">
            <div style="margin-bottom: 15px;">
                <label style="display: block; margin-bottom: 5px;">Order ID</label>
                <input type="text" id="modalOrderNumber" readonly style="width: 100%; padding: 10px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 5px;">
            </div>
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 5px;">New Status</label>
                <select name="newStatus" id="modalNewStatus" style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ddd;">
                    <option value="pending">Pending</option>
                    <option value="processing">Processing</option>
                    <option value="shipped">Shipped</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
            <div style="display: flex; justify-content: flex-end; gap: 10px;">
                <button type="button" onclick="closeModal()" style="padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">Cancel</button>
                <button type="submit" style="padding: 10px 20px; background: var(--accent); color: white; border: none; border-radius: 5px; cursor: pointer;">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    function filterTable() {
        const search = document.getElementById('searchInput').value.toLowerCase();
        const status = document.getElementById('statusFilter').value.toLowerCase();
        const rows = document.querySelectorAll('#ordersTable tbody tr');
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            const rowStatus = row.getAttribute('data-status').toLowerCase();
            row.style.display = (text.includes(search) && (status === '' || rowStatus === status)) ? '' : 'none';
        });
    }

    function openStatusModal(id, status, num) {
        document.getElementById('modalOrderId').value = id;
        document.getElementById('modalOrderNumber').value = '#' + num;
        document.getElementById('modalNewStatus').value = status.toLowerCase();
        document.getElementById('statusModal').style.display = 'block';
    }

    function closeModal() { document.getElementById('statusModal').style.display = 'none'; }
    window.onclick = function(e) { if (e.target == document.getElementById('statusModal')) closeModal(); }
    function viewOrder(id) { window.location.href = 'order-details.jsp?id=' + id; }
</script>

</body>
</html>