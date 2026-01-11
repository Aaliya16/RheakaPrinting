<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    // 1. Setup Formatter
    DecimalFormat dcf = new DecimalFormat("#,##0.00");

    String orderName = (String) session.getAttribute("order_name");
    Integer orderId = (Integer) session.getAttribute("order_id");
    Double orderTotal = (Double) session.getAttribute("order_total");
    Integer orderItems = (Integer) session.getAttribute("order_items");
    String orderAddress = (String) session.getAttribute("order_address");
    String orderPayment = (String) session.getAttribute("order_payment");

    String displayId = (orderId != null) ? String.valueOf(orderId) : "---";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Order Confirmation - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            margin: 0;
        }

        .confirmation-container {
            max-width: 700px;
            margin: 80px auto;
            padding: 20px;
            width: 90%;
        }
        .confirmation-card {
            background: #fff;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            text-align: center;
        }
        .success-icon {
            width: 80px; height: 80px; background: #4CAF50;
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; margin: 0 auto 30px;
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }
        .success-icon svg {
            width: 50px; height: 50px; stroke: white; stroke-width: 3; fill: none;
        }
        h1 { color: #333; margin-bottom: 10px; font-size: 32px; font-weight: 700; }
        .subtitle { color: #666; font-size: 16px; margin-bottom: 40px; }

        .order-number-box {
            background: #4682B4;
            color: white;
            padding: 15px 30px;
            border-radius: 25px;
            display: inline-block;
            margin: 20px 0;
            font-weight: bold;
            font-size: 18px;
            box-shadow: 0 4px 10px rgba(70, 130, 180, 0.3);
        }

        .order-details {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            margin: 30px 0;
            text-align: left;
            border: 1px solid #eee;
        }
        .order-detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #ddd;
        }
        .order-detail-row span:first-child { color: #666; font-weight: 500; }
        .order-detail-row span:last-child { color: #333; font-weight: 600; text-align: right; max-width: 60%; }

        .order-detail-row:last-child {
            border-bottom: none;
            padding-top: 20px;
            margin-top: 10px;
            border-top: 2px solid #4682B4;
            font-weight: bold;
            font-size: 18px;
        }
        .order-detail-row:last-child span:last-child {
            color: #4682B4;
            font-size: 22px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }

        .btn-blue {
            display: inline-block;
            padding: 12px 30px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            font-size: 16px;
        }
        .btn-blue:hover {
            background: #357ABD;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
            color: white;
        }

        .btn-outline-blue {
            display: inline-block;
            padding: 12px 30px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid #4682B4;
            font-size: 16px;
        }
        .btn-outline-blue:hover {
            background: #4682B4;
            color: white;
        }

        @media (max-width: 768px) {
            .action-buttons { flex-direction: column; }
            .btn-blue, .btn-outline-blue { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="confirmation-container">
    <div class="confirmation-card">
        <div class="success-icon">
            <svg viewBox="0 0 24 24">
                <polyline points="20 6 9 17 4 12"></polyline>
            </svg>
        </div>

        <h1>Order Confirmed!</h1>
        <p class="subtitle">Thank you for your order, <%= orderName != null ? orderName : "Customer" %>!</p>

        <div class="order-number-box">
            Order #<%= displayId %>
        </div>

        <div class="order-details">
            <div class="order-detail-row">
                <span>Order Number</span>
                <span>#<%= displayId %></span>
            </div>

            <div class="order-detail-row">
                <span>Date</span>
                <span><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></span>
            </div>

            <div class="order-detail-row">
                <span>Payment Method</span>
                <span><%= orderPayment != null ? orderPayment : "Cash / COD" %></span>
            </div>

            <div class="order-detail-row">
                <span>Shipping Address</span>
                <span><%= orderAddress != null ? orderAddress : "-" %></span>
            </div>

            <div class="order-detail-row">
                <span>Items Ordered</span>
                <span><%= orderItems != null ? orderItems : 0 %> item(s)</span>
            </div>

            <div class="order-detail-row">
                <span>Order Total</span>
                <span>RM <%= orderTotal != null ? dcf.format(orderTotal) : "0.00" %></span>
            </div>
        </div>

        <div class="action-buttons">
            <a href="products.jsp" class="btn-blue">Continue Shopping</a>
            <a href="orders.jsp" class="btn-outline-blue">View My Orders</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>