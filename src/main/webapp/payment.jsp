<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.rheakaprinting.model.Cart" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>

<%
    // 1. capture data from the checkout
    request.setCharacterEncoding("UTF-8");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String postcode = request.getParameter("postcode");
    String state = request.getParameter("state");
    String orderNotes = request.getParameter("notes");

    String fullAddress = "";
    if(address != null) {
        fullAddress = address + ", " + postcode + " " + city + ", " + state;
    }

    // 2. CHECK CART
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list == null || cart_list.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    double total = 0.0;
    for (Cart c : cart_list) {
        total += c.getPrice() * c.getQuantity();
    }

    double shipping = 10.0; // Default base

    try {
        Connection conn = DbConnection.getConnection();
        String sql = "SELECT base_fee, free_threshold FROM shipping_settings WHERE id = 1";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            double dbBaseFee = rs.getDouble("base_fee");
            double freeThreshold = rs.getDouble("free_threshold");

            shipping = dbBaseFee;

            if (total >= freeThreshold) {
                shipping = 0.0;
            }
        }
        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    double grandTotal = total + shipping;
    DecimalFormat dcf = new DecimalFormat("#,##0.00");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Payment - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            /* Tema gradient biru Steel Blue */
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            margin: 0;
        }

        .payment-container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .payment-header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 20px;
        }

        .payment-header h3 { color: #333; font-weight: 700; }

        .total-amount {
            font-size: 36px;
            color: #4682B4;
            font-weight: bold;
            margin: 10px 0;
        }

        .summary-details {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 14px;
            color: #555;
            border: 1px solid #eee;
        }

        .payment-methods {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            margin-top: 15px;
        }

        .method-card {
            flex: 1;
            border: 2px solid #eee;
            border-radius: 12px;
            padding: 20px 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        /* Hide Radio Buttons */
        input[type="radio"] { display: none; }

        /* Style bila Radio dipilih */
        input[type="radio"]:checked + .method-card {
            border-color: #4682B4;
            background: rgba(70, 130, 180, 0.1);
            color: #4682B4;
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.2);
        }

        .method-icon { font-size: 28px; margin-bottom: 8px; display: block; }

        .form-input-simulasi {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: 0.3s;
        }

        .form-input-simulasi:focus {
            outline: none;
            border-color: #4682B4;
            box-shadow: 0 0 0 3px rgba(70, 130, 180, 0.1);
        }

        .btn-pay {
            width: 100%;
            background: #4682B4;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 25px;
            transition: all 0.3s ease;
        }

        .btn-pay:hover {
            background: #357ABD;
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        h4 { color: #333; font-weight: 600; margin-top: 0; }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="payment-container">
    <div class="payment-header">
        <h3>Complete Your Payment</h3>
        <div class="total-amount">RM <%= dcf.format(grandTotal) %></div>
        <p>Order for: <strong><%= fullName %></strong></p>
    </div>

    <form action="place-order" method="post">
        <!-- FIXED: Use same parameter names as PlaceOrderServlet expects -->
        <input type="hidden" name="fullName" value="<%= fullName %>">
        <input type="hidden" name="email" value="<%= email %>">
        <input type="hidden" name="phone" value="<%= phone %>">
        <input type="hidden" name="address" value="<%= fullAddress %>">
        <input type="hidden" name="notes" value="<%= orderNotes != null ? orderNotes : "" %>">

        <div class="summary-details">
            <p style="margin-bottom: 5px;"><strong>Shipping to:</strong></p>
            <p style="margin-top: 0;"><%= fullAddress %></p>
            <p>Shipping Fee included: RM <%= dcf.format(shipping) %></p>
        </div>

        <h4>Select Payment Method</h4>
        <div class="payment-methods">
            <label style="flex: 1;">
                <input type="radio" name="paymentMethod" value="Credit Card" checked>
                <div class="method-card">
                    <span class="method-icon">💳</span>
                    <span style="font-weight: 600;">Card</span>
                </div>
            </label>

            <label style="flex: 1;">
                <input type="radio" name="paymentMethod" value="Online Banking">
                <div class="method-card">
                    <span class="method-icon">🏛️</span>
                    <span style="font-weight: 600;">FPX</span>
                </div>
            </label>

            <label style="flex: 1;">
                <input type="radio" name="paymentMethod" value="E-Wallet">
                <div class="method-card">
                    <span class="method-icon">📱</span>
                    <span style="font-weight: 600;">E-Wallet</span>
                </div>
            </label>
        </div>

        <div id="card-details-area" style="margin-top: 20px;">
            <label style="font-weight: 600; color: #333; font-size: 14px;">Card Number (Simulation)</label>
            <input type="text" placeholder="0000 0000 0000 0000" class="form-input-simulasi">
        </div>

        <button type="submit" class="btn-pay">Pay RM <%= dcf.format(grandTotal) %></button>
    </form>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>