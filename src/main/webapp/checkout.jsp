<%--
  Created by IntelliJ IDEA.
  User: MSI MODERN 15
  Date: 25/12/2025
  Time: 12:34 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    double total = 0.0;

    if (cart_list != null) {
        for (Cart c : cart_list) {
            total += c.getPrice() * c.getQuantity();
        }
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Checkout - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --mongoose: #baa987;
        }

        body {
            background-color: #f5f5f5;
            font-family: 'Roboto', sans-serif;
        }

        .checkout-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            width: 90%;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
        }

        .checkout-card {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        /* Order Summary */
        .order-summary {
            position: sticky;
            top: 20px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .summary-item span:first-child {
            color: #666;
        }

        .summary-item span:last-child {
            font-weight: 600;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            padding: 20px 0;
            font-size: 20px;
            font-weight: bold;
            border-top: 2px solid var(--mongoose);
            margin-top: 10px;
        }

        .summary-total span:last-child {
            color: var(--mongoose);
            font-size: 24px;
        }

        .place-order-btn {
            width: 100%;
            background: var(--mongoose);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 20px;
        }

        .place-order-btn:hover {
            background: #a49374;
        }

        .back-to-cart {
            display: inline-block;
            color: var(--mongoose);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .back-to-cart:hover {
            text-decoration: underline;
        }

        .cart-items-list {
            margin-bottom: 20px;
        }

        .cart-item-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .item-name {
            flex: 1;
            color: #333;
        }

        .item-qty {
            color: #666;
            margin: 0 10px;
        }

        .item-price {
            font-weight: 600;
            color: #333;
        }

        @media (max-width: 768px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }

            .order-summary {
                position: static;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

</body>
</html>
