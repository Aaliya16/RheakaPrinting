<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    // 1. Setup Formatter (Guna "0.00" supaya nampak macam duit)
    DecimalFormat dcf = new DecimalFormat("#,##0.00");

    // 2. Ambil data dari Session (yang diset oleh PlaceOrderServlet)
    String orderName = (String) session.getAttribute("order_name");

    // Guna Integer untuk ID (sebab dalam Servlet kita set int)
    Integer orderId = (Integer) session.getAttribute("order_id");

    Double orderTotal = (Double) session.getAttribute("order_total");
    Integer orderItems = (Integer) session.getAttribute("order_items");

    // Data Baru (Address & Payment)
    String orderAddress = (String) session.getAttribute("order_address");
    String orderPayment = (String) session.getAttribute("order_payment");

    // Fallback kalau null (elak error kalau user refresh page lepas session clear)
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
        :root { --mongoose: #baa987; }
        body { background-color: #f5f5f5; font-family: 'Roboto', sans-serif; }

        .confirmation-container {
            max-width: 700px;
            margin: 80px auto;
            padding: 20px;
            width: 90%;
        }
        .confirmation-card {
            background: #fff;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        .success-icon {
            width: 80px; height: 80px; background: #4CAF50;
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; margin: 0 auto 30px;
        }
        .success-icon svg {
            width: 50px; height: 50px; stroke: white; stroke-width: 3; fill: none;
        }
        h1 { color: #333; margin-bottom: 10px; font-size: 32px; }
        .subtitle { color: #666; font-size: 16px; margin-bottom: 40px; }

        .order-number {
            background: var(--mongoose); color: white;
            padding: 15px 25px; border-radius: 5px;
            display: inline-block; margin: 20px 0;
            font-weight: bold; font-size: 18px;
        }

        .order-details {
            background: #f8f9fa; padding: 30px;
            border-radius: 8px; margin: 30px 0; text-align: left;
        }
        .order-detail-row {
            display: flex; justify-content: space-between;
            padding: 12px 0; border-bottom: 1px solid #ddd;
        }
        .order-detail-row span:first-child { color: #666; font-weight: 500; }
        .order-detail-row span:last-child { color: #333; font-weight: 600; text-align: right; max-width: 60%; }

        .order-detail-row:last-child {
            border-bottom: none; padding-top: 20px; margin-top: 10px;
            border-top: 2px solid var(--mongoose);
            font-weight: bold; font-size: 18px;
        }
        .order-detail-row:last-child span:last-child {
            color: var(--mongoose); font-size: 20px;
        }

        .action-buttons {
            display: flex; gap: 15px; justify-content: center; margin-top: 40px;
        }
        .btn {
            padding: 12px 30px; border-radius: 5px; text-decoration: none;
            font-weight: 600; font-size: 16px; transition: all 0.3s; display: inline-block;
        }
        .btn-primary { background: var(--mongoose); color: white; border: none; }
        .btn-primary:hover { background: #a49374; }
        .btn-secondary { background: white; color: var(--mongoose); border: 2px solid var(--mongoose); }
        .btn-secondary:hover { background: var(--mongoose); color: white; }

        @media (max-width: 768px) {
            .action-buttons { flex-direction: column; }
            .btn { width: 100%; }
        }
    </style>
</head>
<body style="background-color: lightsteelblue !important;">

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

        <div class="order-number">
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
                <span><%= orderPayment != null ? orderPayment : "Cash" %></span>
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
            <a href="products.jsp" class="btn btn-primary">Continue Shopping</a>
            <a href="orders.jsp" class="btn btn-secondary">View My Orders</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>