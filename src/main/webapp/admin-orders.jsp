<%-- admin-orders.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Logic kept exactly the same
    DecimalFormat dcf = new DecimalFormat("#.##");
    OrderDao orderAdminDao = new OrderDao(DbConnection.getConnection());
    List<Order> allOrders = orderAdminDao.getAllOrders();

    if (allOrders == null) {
        allOrders = new ArrayList<>();
    }

    int pending = 0, processing = 0, completed = 0;
    for (Order o : allOrders) {
        if ("pending".equalsIgnoreCase(o.getStatus())) pending++;
        else if ("processing".equalsIgnoreCase(o.getStatus())) processing++;
        else if ("completed".equalsIgnoreCase(o.getStatus())) completed++;
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
            --brand-color: #6c5ce7; /* Monochrome Purple Theme */
            --brand-light: rgba(108, 92, 231, 0.1);
            --bg-body: #f1f2f6;
            --text-main: #2d3436;
        }

        /* Updated to clean monochrome background */
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

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
            border-radius: 15px; display: flex; align-items: center; justify-content: center;
            color: white; font-size: 24px;
        }

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

        /* Stats Grid adjusted to monochrome */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 30px; }
        .stat-card {
            background: white; padding: 25px; border-radius: 20px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.04); transition: 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-val { font-size: 32px; font-weight: 800; color: var(--text-main); }
        .stat-label { font-size: 11px; color: #b2bec3; text-transform: uppercase; font-weight: 700; margin-top: 5px; }

        /* Icons changed to consistent brand-light purple */
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

        .filter-section { display: flex; gap: 15px; margin-bottom: 25px; }
        .filter-select { padding: 10px; border-radius: 10px; border: 1px solid #f1f2f6; background: #f1f2f6; font-size: 13px; outline: none; cursor: pointer; }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; color: #b2bec3; font-size: 11px; text-transform: uppercase; border-bottom: 2px solid #f1f1f1; }
        td { padding: 20px 15px; border-bottom: 1px solid #f1f2f6; font-size: 14px; }

        /* Badges kept functional but visually softened */
        .status-badge { padding: 6px 12px; border-radius: 6px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .status-badge.pending { background: #fff3cd; color: #856404; }
        .status-badge.processing { background: #cfe2ff; color: #084298; }
        .status-badge.completed { background: #d1e7dd; color: #0f5132; }

        .btn-action { width: 35px; height: 35px; border-radius: 8px; border: none; cursor: pointer; transition: 0.2s; display: inline-flex; align-items: center; justify-content: center; }
        .btn-view { background: var(--brand-light); color: var(--brand-color); }
        .btn-edit { background: #fff8e1; color: #ff8f00; margin-left: 5px; }
        .btn-action:hover { transform: scale(1.1); }

        /* Modal styling aligned with monochrome theme */
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); backdrop-filter: blur(4px); }
        .modal-content { background: white; margin: 10% auto; padding: 30px; border-radius: 20px; width: 400px; box-shadow: 0 15px 50px rgba(0,0,0,0.2); }

        /* Back Button container */
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
    <div class="top-bar">
        <div class="header-left">
            <div class="header-icon-box"><i class="fas fa-shopping-bag"></i></div>
            <h1>Orders<br><span style="font-weight: 400; font-size: 22px;">Management</span></h1>
        </div>

        <div class="search-container">
            <i class="fas fa-search" style="color: var(--brand-color);"></i>
            <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search orders...">
        </div>

        <div class="admin-profile">
            <strong style="font-size: 14px; margin-right: 10px;"><%= adminUser %></strong>
            <div class="avatar-circle"><%= (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A" %></div>
            <button onclick="window.print()" class="btn-action btn-view" style="width: auto; padding: 0 15px; margin-left:10px;"><i class="fas fa-print"></i></button>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= pending %></div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-clock"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= processing %></div>
                <div class="stat-label">Processing</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-spinner"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= completed %></div>
                <div class="stat-label">Completed</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-check-circle"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= allOrders.size() %></div>
                <div class="stat-label">Total Orders</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-file-invoice"></i></div>
        </div>
    </div>

    <div class="content-card">
        <div class="filter-section">
            <select class="filter-select" id="statusFilter" onchange="filterTable()">
                <option value="">All Status</option>
                <option value="pending">Pending</option>
                <option value="processing">Processing</option>
                <option value="completed">Completed</option>
            </select>
        </div>

        <table id="ordersTable">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer Details</th>
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
                <td><div style="font-weight: 700; color: var(--text-main);"><%= order.getName() %></div></td>
                <td><%= order.getDate() %></td>
                <td><strong>RM <%= dcf.format(order.getPrice() * order.getQuantity()) %></strong></td>
                <td><span class="status-badge <%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span></td>
                <td style="text-align: right;">
                    <button class="btn-action btn-view" title="View Details" onclick="viewOrder(<%= order.getOrderId() %>)"><i class="fas fa-eye"></i></button>
                    <button class="btn-action btn-edit" title="Update Status" onclick="openStatusModal(<%= order.getOrderId() %>, '<%= order.getStatus() %>', '<%= order.getOrderId() %>')"><i class="fas fa-edit"></i></button>
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

<div id="statusModal" class="modal">
    <div class="modal-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="color: var(--brand-color);">Update Status</h2>
            <span onclick="closeModal()" style="cursor: pointer; font-size: 24px; color: #b2bec3;">&times;</span>
        </div>
        <form action="UpdateOrderStatusServlet" method="POST">
            <input type="hidden" id="modalOrderId" name="orderId">
            <div style="margin-bottom: 15px;">
                <label style="display: block; margin-bottom: 8px; font-weight: 600; font-size: 13px;">Order ID</label>
                <input type="text" id="modalOrderNumber" readonly style="width: 100%; padding: 12px; background: #f1f2f6; border: 1px solid #f1f2f6; border-radius: 10px;">
            </div>
            <div style="margin-bottom: 25px;">
                <label style="display: block; margin-bottom: 8px; font-weight: 600; font-size: 13px;">New Status</label>
                <select name="newStatus" id="modalNewStatus" style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #f1f2f6; background: #f1f2f6;">
                    <option value="pending">Pending</option>
                    <option value="processing">Processing</option>
                    <option value="shipped">Shipped</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
            <div style="display: flex; gap: 10px;">
                <button type="submit" style="flex: 1; padding: 12px; background: var(--brand-color); color: white; border: none; border-radius: 10px; cursor: pointer; font-weight: 600;">Save Changes</button>
                <button type="button" onclick="closeModal()" style="flex: 1; padding: 12px; background: #f1f2f6; color: #636e72; border: none; border-radius: 10px; cursor: pointer;">Cancel</button>
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