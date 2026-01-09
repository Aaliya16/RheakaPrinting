<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rheakaprinting.model.User" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>

<%
    // 1. Setup Formatter
    DecimalFormat dcf = new DecimalFormat("#,##0.00");

    // 2. Prepare List to hold data
    List<Map<String, Object>> ordersList = new ArrayList<>();

    // 3. Database Logic
    User currentUser = (User) session.getAttribute("currentUser");
    Connection conn = DbConnection.getConnection();

    if (currentUser != null && conn != null) {
        try {
            String query = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, currentUser.getUserId());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();

                // MAPPING: Get from DB -> Put into Map
                // Ensure the string inside rs.get... match your actual DB column names
                row.put("orderNumber", rs.getInt("id"));
                row.put("date", rs.getTimestamp("order_date"));
                row.put("status", rs.getString("status"));
                row.put("customerName", currentUser.getName());
                row.put("email", currentUser.getEmail());
                row.put("total", rs.getDouble("total_amount"));

                // If you don't have a 'total_items' column in DB,
                // you might need to set a default or run a subquery.
                // For now, I'm setting it to 1 to prevent errors.
                // row.put("items", rs.getInt("total_items"));
                row.put("items", 1);

                ordersList.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error to console
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Orders - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --mongoose: #baa987;
        }

        body {
            background-color: #f5f5f5;
            font-family: 'Roboto', sans-serif;
        }

        .orders-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            width: 90%;
        }

        .page-header {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            color: #333;
            margin: 0;
            font-size: 28px;
        }

        .back-btn {
            background: var(--mongoose);
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #a49374;
        }

        .orders-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .order-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .order-header {
            background: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 2px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .order-number {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .order-date {
            color: #666;
            font-size: 14px;
        }

        .order-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-processing {
            background: #fff3cd;
            color: #856404;
        }

        .status-shipped {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-delivered {
            background: #d4edda;
            color: #155724;
        }

        .order-body {
            padding: 30px;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .detail-label {
            color: #666;
            font-size: 13px;
            text-transform: uppercase;
            font-weight: 600;
        }

        .detail-value {
            color: #333;
            font-size: 16px;
            font-weight: 600;
        }

        .order-total {
            color: var(--mongoose);
            font-size: 24px;
            font-weight: bold;
        }

        .order-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--mongoose);
            color: white;
        }

        .btn-primary:hover {
            background: #a49374;
        }

        .btn-secondary {
            background: white;
            color: var(--mongoose);
            border: 2px solid var(--mongoose);
        }

        .btn-secondary:hover {
            background: var(--mongoose);
            color: white;
        }

        .empty-orders {
            background: #fff;
            padding: 80px 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .empty-orders h3 {
            color: #666;
            margin-bottom: 15px;
            font-size: 24px;
        }

        .empty-orders p {
            color: #999;
            margin-bottom: 30px;
        }

        .empty-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 30px;
            opacity: 0.3;
        }

        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                text-align: center;
            }

            .order-header {
                flex-direction: column;
                text-align: center;
            }

            .order-details {
                grid-template-columns: 1fr;
            }

            .order-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="orders-container">
    <div class="page-header">
        <h1>My Orders</h1>
        <a href="index.jsp" class="back-btn">← Back to Home</a>
    </div>

    <%-- CHECK: If list is NOT empty --%>
    <% if (!ordersList.isEmpty()) { %>

    <div class="orders-list">
        <%
            // Loop through the list we created at the top
            for (Map<String, Object> order : ordersList) {

                // Status Logic
                String status = (String) order.get("status");
                String statusClass = "status-processing"; // Default

                if (status != null) {
                    if (status.equalsIgnoreCase("shipped")) statusClass = "status-shipped";
                    else if (status.equalsIgnoreCase("delivered")) statusClass = "status-delivered";
                    else if (status.equalsIgnoreCase("cancelled")) statusClass = "status-cancelled";
                }
        %>

        <div class="order-card">
            <div class="order-header">
                <div>
                    <div class="order-number">Order #<%= order.get("orderNumber") %></div>
                    <div class="order-date">
                        Placed on <%= String.format("%1$tB %1$te, %1$tY", order.get("date")) %>
                    </div>
                </div>
                <span class="order-status <%= statusClass %>"><%= status %></span>
            </div>

            <div class="order-body">
                <div class="order-details">
                    <div class="detail-item">
                        <span class="detail-label">Customer Name</span>
                        <span class="detail-value"><%= order.get("customerName") %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Email</span>
                        <span class="detail-value"><%= order.get("email") %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Items</span>
                        <span class="detail-value"><%= order.get("items") %> item(s)</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Total Amount</span>
                        <span class="order-total">RM <%= dcf.format(order.get("total")) %></span>
                    </div>
                </div>

                <div class="order-actions">
                    <a href="order-details.jsp?id=<%= order.get("orderNumber") %>" class="btn btn-primary">View Details</a>
                    <button class="btn btn-secondary" onclick="window.print()">Print Invoice</button>
                </div>
            </div>
        </div>

        <% } // End For Loop %>
    </div>

    <%-- ELSE: If list IS empty --%>
    <% } else { %>

    <div class="empty-orders">
        <svg class="empty-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <circle cx="9" cy="21" r="1"></circle>
            <circle cx="20" cy="21" r="1"></circle>
            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
        </svg>
        <h3>No Orders Yet</h3>
        <p>You haven't placed any orders yet. Start shopping to see your orders here!</p>
        <a href="index.jsp" class="btn btn-primary">Start Shopping</a>
    </div>

    <% } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
