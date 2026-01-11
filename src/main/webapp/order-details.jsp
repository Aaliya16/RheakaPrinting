<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    session = request.getSession();

    User authUser = (User) session.getAttribute("currentUser");

    if (authUser == null) {
        response.sendRedirect("login.jsp?msg=notLoggedIn");
    }

    // 2. Get Order ID from URL
    String orderIdParam = request.getParameter("id");
    if (orderIdParam == null) {
        response.sendRedirect("orders.jsp");
        return;
    }

    // RETRIEVE SHIPPING FROM DATABASE
    double shipping = 10.0; // default
    try {
        Connection connShip = DbConnection.getConnection();
        String sqlShip = "SELECT base_fee FROM shipping_settings WHERE id = 1";
        PreparedStatement psShip = connShip.prepareStatement(sqlShip);
        ResultSet rsShip = psShip.executeQuery();
        if (rsShip.next()) {
            shipping = rsShip.getDouble("base_fee");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

    int userId = authUser.getUserId();
    int orderId = Integer.parseInt(orderIdParam);
%>

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
        body {
            /* Tema gradient biru Steel Blue */
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Segoe UI', sans-serif;
            padding: 20px 0;
            min-height: 100vh;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .order-detail-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            overflow: hidden;
            margin-bottom: 20px;
        }

        /* --- HEADER (Tukar ke Steel Blue) --- */
        .order-header {
            background: #4682B4;
            color: white;
            padding: 30px;
        }

        .order-header h1 {
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 700;
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
            background: rgba(255,255,255,0.25);
            border: 1px solid rgba(255,255,255,0.5);
        }

        .order-body {
            padding: 30px;
        }

        .section {
            margin-bottom: 30px;
        }

        /* --- TAJUK SEKSYEN (Guna Steel Blue) --- */
        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #4682B4;
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
            border: 1px solid #eee;
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
            border: 1px solid #eee;
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

        /* --- HARGA ITEM (Steel Blue) --- */
        .item-price .price {
            font-size: 18px;
            font-weight: 700;
            color: #4682B4;
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
            border: 1px solid #eee;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
        }

        .summary-row.total {
            border-top: 2px solid #4682B4;
            margin-top: 10px;
            padding-top: 15px;
            font-size: 20px;
            font-weight: 700;
        }

        .summary-row.total .amount {
            color: #4682B4;
        }

        /* --- BUTANG-BUTANG (Tema Blue & Outline) --- */
        .btn-blue {
            display: inline-block;
            padding: 12px 24px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-blue:hover {
            background: #357ABD;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
            color: white;
        }

        .btn-outline-blue {
            display: inline-block;
            padding: 12px 24px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid #4682B4;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-outline-blue:hover {
            background: #4682B4;
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .info-grid { grid-template-columns: 1fr; }
            .item { flex-direction: column; text-align: center; }
            .item-price { text-align: center; }
            .action-buttons { flex-direction: column; }
            .btn-blue, .btn-outline-blue { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container" style="margin-top: 100px;"> <%

    try {

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

        int dbOrderId = rs.getInt("id");
        Timestamp orderDate = rs.getTimestamp("order_date");
        double totalAmount = rs.getDouble("total_amount");
        String status = rs.getString("status");
        String address = rs.getString("address");
        String phone = rs.getString("phone_number");
        String paymentMethod = "Online Banking / Cash";

    %>

    <div class="order-detail-card">

        <div class="order-header">

            <h1>Order #<%= dbOrderId %></h1>

            <p>Placed on <%= sdf.format(orderDate) %></p>

            <div class="status-badges">
                <span class="badge badge-status">Status: <%= status %></span>
            </div>
        </div>

        <div class="order-body">

            <div class="section">

                <h3 class="section-title">Order Information</h3>
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
                <h3 class="section-title">Shipping Address</h3>
                <div class="info-item">
                    <div class="value" style="white-space: pre-line;"><%= address %></div>
                </div>
            </div>

            <div class="section">

                <h3 class="section-title">Ordered Items</h3>
                <div class="item-list">

                    <%

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
                        <img src="assets/img/<%= pImage != null ? pImage : "default.jpg" %>" alt="<%= pName %>">

                        <div class="item-info">
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
                    <%
                        double grandTotal = totalAmount + shipping;
                    %>
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span>RM <%= dcf.format(totalAmount) %></span>
                    </div>

                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>RM <%= dcf.format(shipping) %></span>
                    </div>

                    <div class="summary-row total">
                        <span>Grand Total</span>
                        <span class="amount">RM <%= dcf.format(grandTotal) %></span>
                    </div>
                </div>
            </div>

            <div class="action-buttons">
                <a href="orders.jsp" class="btn-blue">← Back to My Orders</a>
                <button onclick="window.print()" class="btn-outline-blue" style="background: #f8f9fa;">Print Invoice</button>
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
        <a href="orders.jsp" class="btn btn-outline">Go Back</a>
    </div>

    <%
        }
    %>

</div>
<%@ include file="footer.jsp" %>

</body>
</html>
