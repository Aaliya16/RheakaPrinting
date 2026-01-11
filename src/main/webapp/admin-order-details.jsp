<<%-- admin-order-details.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.dao.*, com.example.rheakaprinting.model.*, com.example.rheakaprinting.model.DbConnection, java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%@ page import="com.example.rheakaprinting.model.OrderItem" %>
<%
    // 1. Get the Order ID from the URL
    String idParam = request.getParameter("id");
    int orderId = (idParam != null) ? Integer.parseInt(idParam) : 0;

    // 2. Fetch data using your synchronized OrderDao
    OrderDao dao = new OrderDao(DbConnection.getConnection());
    List<OrderItem> items = dao.getItemsByOrderId(orderId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order #<%= orderId %> Details - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --brand-color: #6c5ce7;
            --brand-light: rgba(108, 92, 231, 0.1);
            --text-main: #2d3436;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

        /* Natural entrance animation */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px); /* Locked width for smoothness */
            padding: 30px;
            opacity: 0;
            will-change: transform, opacity;
            animation: smoothSlideUp 0.7s cubic-bezier(0.22, 1, 0.36, 1) forwards;
        }

        @keyframes smoothSlideUp {
            from { opacity: 0; transform: translateY(25px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header-card {
            background: white; padding: 25px 35px; border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin-bottom: 30px;
            display: flex; justify-content: space-between; align-items: center;
        }

        .details-container {
            background: white; padding: 40px; border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
        }

        .item-card {
            display: flex; align-items: center; padding: 20px;
            border-bottom: 1px solid #f1f2f6; transition: 0.3s;
        }
        .item-card:hover { background: #f8fafc; }

        /* Design Image Preview */
        .design-img {
            width: 100px; height: 100px; border-radius: 15px;
            object-fit: cover; margin-right: 25px; border: 3px solid #f1f2f6;
        }

        .item-info h3 { font-size: 18px; margin-bottom: 8px; color: var(--text-main); }

        /* Badges for Variation and Addon */
        .attr-badge {
            display: inline-block; padding: 4px 12px; border-radius: 8px;
            font-size: 12px; font-weight: 700; background: var(--brand-light);
            color: var(--brand-color); margin-right: 8px; text-transform: uppercase;
        }

        .price-tag { text-align: right; min-width: 120px; }
        .price-val { font-size: 18px; font-weight: 800; color: var(--brand-color); }

        .btn-back {
            display: inline-flex; align-items: center; gap: 10px; margin-top: 30px;
            padding: 12px 25px; background: white; color: var(--brand-color);
            border: 2px solid var(--brand-color); border-radius: 12px;
            font-weight: 700; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { background: var(--brand-color); color: white; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="header-card">
        <div>
            <h1 style="font-size: 24px;">Order #<%= orderId %></h1>
            <p style="color: #b2bec3; font-size: 13px;">Detailed view of items and specifications</p>
        </div>
        <i class="fas fa-receipt" style="font-size: 30px; color: var(--brand-color);"></i>
    </div>

    <div class="details-container">
        <% if (items != null && !items.isEmpty()) {
            for (OrderItem item : items) { %>
        <div class="item-card">
            <%-- Image path matches your database 'design_image' column --%>
            <img src="uploads/<%= item.getDesignImage() %>" class="design-img"
                 onerror="this.src='assets/no-image.png'" alt="Design Preview">

            <div class="item-info" style="flex-grow: 1;">
                <h3>Product ID: <%= item.getProductId() %></h3>
                <div style="margin-top: 10px;">
                    <span class="attr-badge"><i class="fas fa-layer-group"></i> <%= item.getVariation() %></span>
                    <span class="attr-badge"><i class="fas fa-plus-circle"></i> <%= item.getAddon() %></span>
                </div>
            </div>

            <div class="price-tag">
                <div class="price-val">RM <%= String.format("%.2f", item.getPrice()) %></div>
                <div style="font-size: 12px; color: #b2bec3;">Qty: <%= item.getQuantity() %></div>
            </div>
        </div>
        <% } } else { %>
        <div style="text-align: center; padding: 50px;">
            <i class="fas fa-search" style="font-size: 40px; color: #f1f2f6; margin-bottom: 15px;"></i>
            <p style="color: #b2bec3;">No items found for this order.</p>
        </div>
        <% } %>

        <button onclick="window.location.href='admin-orders.jsp'" class="btn-back">
            <i class="fas fa-arrow-left"></i> Return to Orders
        </button>
    </div>
</div>

</body>
</html>