<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // 1. Check Login
    User authUser = (User) session.getAttribute("currentUser");
    if (authUser == null) {
        response.sendRedirect("login.jsp?msg=notLoggedIn");
        return;
    }

    // 2. Get Order ID from URL
    String orderIdParam = request.getParameter("id");
    if (orderIdParam == null) {
        response.sendRedirect("my-orders.jsp");
        return;
    }

    int userId = authUser.getUserId();
    int orderId = Integer.parseInt(orderIdParam);

    DecimalFormat dcf = new DecimalFormat("#,##0.00");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

    Connection conn = DbConnection.getConnection();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Rheaka Printing</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --mongoose: #baa987;
        }

        body {
            background: #f5f6fa;
            font-family: 'Segoe UI', sans-serif;
            padding: 20px 0;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .order-detail-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .order-header {
            background: linear-gradient(135deg, var(--mongoose) 0%, #8e7c5e 100%);
            color: white;
            padding: 30px;
        }

        .order-header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .order-header p {
            opacity: 0.9;
            margin: 5px 0;
        }

        .status-badges {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .badge-status {
            background: rgba(255,255,255,0.3);
            border: 1px solid rgba(255,255,255,0.5);
        }

        .order-body {
            padding: 30px;
        }

        .section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .info-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .info-item label {
            display: block;
            font-size: 12px;
            color: #7f8c8d;
            margin-bottom: 5px;
            text-transform: uppercase;
        }

        .info-item .value {
            font-size: 15px;
            color: #2c3e50;
            font-weight: 600;
        }

        .item-list {
            margin-top: 20px;
        }

        .item {
            display: flex;
            gap: 15px;
            padding: 15px;
            border: 2px solid #f0f0f0;
            border-radius: 10px;
            margin-bottom: 15px;
            align-items: center;
        }

        .item img {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            background: #eee;
        }

        .item-info {
            flex: 1;
        }

        .item-info h4 {
            font-size: 16px;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .item-price {
            text-align: right;
        }

        .item-price .price {
            font-size: 18px;
            font-weight: 700;
            color: var(--mongoose);
        }

        .item-price .qty {
            font-size: 13px;
            color: #7f8c8d;
        }

        .order-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
        }

        .summary-row.total {
            border-top: 2px solid #dee2e6;
            margin-top: 10px;
            padding-top: 15px;
            font-size: 20px;
            font-weight: 700;
        }

        .summary-row.total .amount {
            color: var(--mongoose);
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-outline {
            background: white;
            color: var(--mongoose);
            border: 2px solid var(--mongoose);
        }

        .btn-outline:hover {
            background: var(--mongoose);
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
            .item {
                flex-direction: column;
                text-align: center;
            }
            .item-price {
                text-align: center;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container" style="margin-top: 100px;"> <%
    try {
        // 3. Query Orders Table (Guna column ID, address, phone_number yang betul)
        String queryOrder = "SELECT * FROM orders WHERE id = ? AND user_id = ?";
        PreparedStatement ps = conn.prepareStatement(queryOrder);
        ps.setInt(1, orderId);
        ps.setInt(2, userId);
        ResultSet rs = ps.executeQuery();

        if (!rs.next()) {
%>
    <div class="order-detail-card" style="padding: 50px; text-align: center;">
        <h3>Order Not Found ❌</h3>
        <p>This order does not exist or does not belong to you.</p>
        <a href="orders.jsp" class="btn btn-outline">Back to My Orders</a>
    </div>
    <%
            return;
        }

        // Extract Data Order
        int dbOrderId = rs.getInt("id");
        Timestamp orderDate = rs.getTimestamp("order_date");
        double totalAmount = rs.getDouble("total_amount");
        String status = rs.getString("status");
        String address = rs.getString("address");
        String phone = rs.getString("phone_number");

        // Note: Kalau DB takde column payment_method, kita hardcode atau assume
        String paymentMethod = "Online Banking / Cash";
    %>

    <div class="order-detail-card">
        <div class="order-header">
            <h1>Order #<%= dbOrderId %></h1>
            <p>📅 Placed on <%= sdf.format(orderDate) %></p>

            <div class="status-badges">
                <span class="badge badge-status">Status: <%= status %></span>
            </div>
        </div>

        <div class="order-body">
            <div class="section">
                <h3 class="section-title">📋 Order Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Order ID</label>
                        <div class="value">#<%= dbOrderId %></div>
                    </div>
                    <div class="info-item">
                        <label>Date</label>
                        <div class="value"><%= sdf.format(orderDate) %></div>
                    </div>
                    <div class="info-item">
                        <label>Payment Method</label>
                        <div class="value"><%= paymentMethod %></div>
                    </div>
                    <div class="info-item">
                        <label>Phone Number</label>
                        <div class="value"><%= phone %></div>
                    </div>
                </div>
            </div>

            <div class="section">
                <h3 class="section-title">🚚 Shipping Address</h3>
                <div class="info-item">
                    <div class="value" style="white-space: pre-line;"><%= address %></div>
                </div>
            </div>

            <div class="section">
                <h3 class="section-title">🛍️ Ordered Items</h3>
                <div class="item-list">
                    <%
                        // 4. Query Order Details + JOIN Products (PENTING!)
                        // Kita perlu JOIN sebab order_details cuma simpan product_id
                        String queryItems = "SELECT d.quantity, d.price, p.name, p.image " +
                                "FROM order_details d " +
                                "JOIN products p ON d.product_id = p.id " +
                                "WHERE d.order_id = ?";

                        PreparedStatement psItems = conn.prepareStatement(queryItems);
                        psItems.setInt(1, orderId);
                        ResultSet rsItems = psItems.executeQuery();

                        while (rsItems.next()) {
                            String pName = rsItems.getString("name");
                            String pImage = rsItems.getString("image");
                            int qty = rsItems.getInt("quantity");
                            double price = rsItems.getDouble("price");
                            double subtotal = price * qty;
                    %>
                    <div class="item">
                        <img src="product-images/<%= pImage %>"
                             alt="<%= pName %>"
                             onerror="this.src='images/default-product.png'"> <div class="item-info">
                        <h4><%= pName %></h4>
                    </div>

                        <div class="item-price">
                            <div class="price">RM <%= dcf.format(subtotal) %></div>
                            <div class="qty"><%= qty %> x RM <%= dcf.format(price) %></div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>

                <div class="order-summary">
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span>RM <%= dcf.format(totalAmount) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>Free</span>
                    </div>
                    <div class="summary-row total">
                        <span>Grand Total</span>
                        <span class="amount">RM <%= dcf.format(totalAmount) %></span>
                    </div>
                </div>
            </div>

            <div class="action-buttons">
                <a href="my-orders.jsp" class="btn btn-outline">← Back to My Orders</a>
                <button onclick="window.print()" class="btn btn-outline" style="background: #f8f9fa;">🖨️ Print Invoice</button>
            </div>
        </div>
    </div>

    <%
    } catch (SQLException e) {
        e.printStackTrace();
    %>
    <div class="container" style="padding: 50px; text-align: center;">
        <h3 style="color:red">Error Loading Order</h3>
        <p><%= e.getMessage() %></p>
        <a href="my-orders.jsp" class="btn btn-outline">Go Back</a>
    </div>
    <%
        }
    %>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>