<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rheakaprinting.model.User" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>

<%
    DecimalFormat dcf = new DecimalFormat("#,##0.00");
    List<Map<String, Object>> ordersList = new ArrayList<>();

    User currentUser = (User) session.getAttribute("auth");
    if (currentUser == null) {
        currentUser = (User) session.getAttribute("currentUser");
    }

    if (currentUser == null) {
        response.sendRedirect("login.jsp?msg=notLoggedIn");
        return;
    }

    Connection conn = DbConnection.getConnection();
    if (conn != null) {
        try {
            String query = "SELECT o.*, COUNT(oi.id) as item_count " +
                    "FROM orders o " +
                    "LEFT JOIN order_details oi ON o.id = oi.order_id " +
                    "WHERE o.user_id = ? " +
                    "GROUP BY o.id " +
                    "ORDER BY o.order_date DESC";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, currentUser.getUserId());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                int orderId = rs.getInt("id");
                row.put("orderId", orderId);
                row.put("orderNumber", String.valueOf(orderId));
                row.put("date", rs.getTimestamp("order_date"));
                row.put("status", rs.getString("status"));
                row.put("total", rs.getDouble("total_amount"));
                row.put("items", rs.getInt("item_count"));

                String dbName = rs.getString("recipient_name");
                String dbEmail = rs.getString("recipient_email");

                if (dbName != null && !dbName.isEmpty()) {
                    row.put("customerName", dbName);
                    row.put("email", dbEmail);
                } else {
                    row.put("customerName", currentUser.getName());
                    row.put("email", currentUser.getEmail());
                }
                ordersList.add(row);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
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
        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
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

        .page-header h1 { color: #333; margin: 0; font-size: 28px; }

        /* --- BUTANG BACK TO HOME (Style Blue) --- */
        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
        }

        .back-btn:hover {
            background: #357ABD;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
            color: white;
        }

        .orders-list { display: flex; flex-direction: column; gap: 20px; }

        .order-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .order-card:hover { transform: translateY(-5px); }

        .order-header {
            background: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 2px solid #4682B4; /* Tukar border ke Biru */
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        /* Status colors */
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cfe2ff; color: #084298; }
        .status-shipped { background: #d1ecf1; color: #0c5460; }
        .status-completed { background: #d4edda; color: #155724; }

        .order-body {
            padding: 30px;
            padding-bottom: 40px;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .detail-item { display: flex; flex-direction: column; gap: 5px; }
        .detail-label { color: #666; font-size: 13px; text-transform: uppercase; font-weight: 600; }
        .detail-value { color: #333; font-size: 16px; font-weight: 600; word-break: break-word; }

        /* --- TOTAL AMOUNT COLOR --- */
        .order-total {
            color: #4682B4;
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

        /* --- STYLE BUTANG VIEW & PRINT (Blue Theme) --- */
        .btn-blue {
            display: inline-block;
            padding: 10px 25px;
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

        /* Butang Secondary (Border Blue) */
        .btn-outline-blue {
            display: inline-block;
            padding: 10px 25px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid #4682B4;
            cursor: pointer;
            font-size: 14px;
            position: relative;
            z-index: 10;
        }

        .btn-outline-blue:hover {
            background: #4682B4;
            color: white;
        }

        .empty-orders {
            background: #fff;
            padding: 80px 30px;
            border-radius: 10px;
            text-align: center;
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

    <% if (!ordersList.isEmpty()) { %>
    <div class="orders-list">
        <%
            for (Map<String, Object> order : ordersList) {
                String status = (String) order.get("status");
                String statusClass = "status-pending";
                if (status != null) {
                    status = status.toLowerCase();
                    if (status.equals("processing")) statusClass = "status-processing";
                    else if (status.equals("shipped")) statusClass = "status-shipped";
                    else if (status.equals("completed")) statusClass = "status-completed";
                }
                String displayOrderNumber = order.get("orderNumber") != null ? (String) order.get("orderNumber") : "ORD-" + order.get("orderId");
        %>
        <div class="order-card">
            <div class="order-header">
                <div>
                    <div class="order-number">Order #<%= displayOrderNumber %></div>
                    <div class="order-date">Placed on <%= String.format("%1$tB %1$te, %1$tY at %1$tI:%1$tM %1$Tp", order.get("date")) %></div>
                </div>
                <span class="order-status <%= statusClass %>"><%= status != null ? status.toUpperCase() : "PENDING" %></span>
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
                    <a href="order-details.jsp?id=<%= order.get("orderId") %>" class="btn-blue">View Details</a>
                    <button onclick="window.print()" class="btn-outline-blue" style="background: #f8f9fa;">Print Invoice</button>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="empty-orders">
        <svg class="empty-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
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
