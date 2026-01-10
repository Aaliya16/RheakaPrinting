<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    double total = 0.0;

    // ✅ AMBIL CART DARI SESSION
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

    if (cart_list != null && !cart_list.isEmpty()) {
        for (Cart c : cart_list) {
            total += c.getPrice() * c.getQuantity();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shopping Cart - Rheaka Design</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root { --mongoose: #baa987; }

        body {
            /* Latar belakang biru gradien sepadan dengan contact.jsp */
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif; margin: 0; padding: 0;
            min-height: 100vh;
        }

        /* Bagian Header (Gaya Kanan / Contact.jsp) */
        .page-header {
            text-align: center;
            padding-top: 30px;
            margin-bottom: 20px;
            animation: fadeInDown 0.8s ease;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-header h1 {
            font-size: 42px;
            color: #2c3e50;
            font-weight: 700;
        }

        .page-header p {
            font-size: 18px;
            color: #2c3e50;
        }

        /* Kotak Putih Utama (Gaya Kanan / contact-form-card) */
        .small-container {
            max-width: 1200px; margin: 0 auto 50px auto; padding: 40px;
            background: #fff; border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1); width: 90%;
            animation: fadeInLeft 0.8s ease;
        }

        @keyframes fadeInLeft {
            from { opacity: 0; transform: translateX(-30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }

        th {
            text-align: left; padding: 15px 10px; color: #333;
            border-bottom: 2px solid #4682B4;
            background: #f8f9fa;
            font-weight: 600; font-size: 14px; text-transform: uppercase;
        }

        th:nth-child(2), th:nth-child(3), th:nth-child(4) { text-align: center; }

        td {
            padding: 20px 10px; vertical-align: middle;
            border-bottom: 1px solid #eee;
        }

        td:nth-child(2), td:nth-child(3), td:nth-child(4) { text-align: center; }

        .cart-info {
            display: flex; align-items: center; gap: 15px;
        }

        .cart-info img {
            width: 80px; height: 80px; object-fit: cover;
            border-radius: 8px; border: 1px solid #eee;
            background: #f0f0f0;
        }

        .cart-info div {
            display: flex; flex-direction: column; gap: 5px;
        }

        .cart-info p {
            margin: 0; font-weight: 600; color: #333; font-size: 16px;
        }

        .cart-info small { color: #666; font-size: 12px; }

        .cart-info a {
            color: #ff523b; font-size: 13px;
            text-decoration: none; font-weight: 500;
        }
        .cart-info a:hover { text-decoration: underline; }

        /* Style Butang Kuantiti ASAL (Bulat Biru) */
        .quantity-btn {
            display: flex; align-items: center;
            justify-content: center; gap: 5px;
        }

        .quantity-btn a {
            background: #4682B4;
            color: white;
            width: 30px; height: 30px; line-height: 30px;
            text-align: center; text-decoration: none;
            font-weight: bold; border-radius: 50%;
            display: inline-block; transition: all 0.3s ease;
        }

        .quantity-btn a:hover {
            background: #357ABD;
            transform: scale(1.1);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .quantity-btn input {
            width: 50px; text-align: center; border: 1px solid #ddd;
            font-weight: 600; margin: 0; background: #f8f9fa;
            padding: 5px; border-radius: 5px; font-size: 14px;
        }

        .price-cell { font-weight: 600; color: #333; font-size: 16px; }

        .subtotal-cell {
            font-weight: bold; color: #4682B4;
            font-size: 18px;
        }

        .total-price {
            display: flex; justify-content: flex-end;
            margin-top: 30px; padding-top: 20px;
            border-top: 2px solid #4682B4;
        }

        .total-price table { width: auto; border: none; }

        .total-price td {
            border: none; padding: 10px 20px;
            font-size: 20px; font-weight: bold;
        }

        .total-price td:last-child { color: #4682B4; font-size: 24px; }

        .cart-actions {
            margin-top: 30px; display: flex;
            justify-content: space-between; align-items: center;
            padding: 20px 0;
        }

        .continue-shopping {
            color: #4682B4; text-decoration: none;
            font-weight: 600; font-size: 16px;
        }

        .btn-blue-style {
            display: inline-block; padding: 12px 35px; background: #4682B4;
            color: white; text-decoration: none; border-radius: 25px;
            font-weight: 600; transition: all 0.3s ease; font-size: 16px;
        }

        .btn-blue-style:hover {
            background: #357ABD;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        .empty-cart-msg { text-align: center; padding: 80px 20px; }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="page-header">
    <h1>Shopping Cart</h1>
    <p>Review your selected items before proceeding to checkout</p>
</div>

<div class="small-container">
    <% if (cart_list != null && !cart_list.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Cart c : cart_list) {
                double itemSubtotal = c.getPrice() * c.getQuantity();
        %>
        <tr>
            <td>
                <div class="cart-info">
                    <img src="assets/img/<%= c.getImage() != null ? c.getImage() : "default.jpg" %>"
                         alt="<%= c.getName() != null ? c.getName() : "Product" %>">
                    <div>
                        <p><%= c.getName() != null && !c.getName().isEmpty() ? c.getName() : "Product #" + c.getId() %></p>
                        <small>Product ID: <%= c.getId() %></small><br>
                        <small>Available stock: <%= c.getStock() %></small><br>
                        <a href="remove-from-cart?id=<%= c.getId() %>&variation=<%= c.getVariation() %>">Remove</a>
                    </div>
                </div>
            </td>
            <td class="price-cell">RM <%= dcf.format(c.getPrice()) %></td>
            <td>
                <div class="quantity-btn">
                    <%-- LOGIK GAYA KIRI (MINIMUM 1) --%>
                    <% if (c.getQuantity() > 1) { %>
                    <a href="quantity-inc-dec?action=dec&id=<%= c.getId() %>&variation=<%= c.getVariation() %>">−</a>
                    <% } else { %>
                    <a href="javascript:void(0)" style="background: #ccc; cursor: not-allowed;" title="Min 1 reached">−</a>
                    <% } %>

                    <input type="text" name="quantity" value="<%= c.getQuantity() %>" readonly>

                    <%-- LOGIK GAYA KIRI (MAKSIMUM STOK) --%>
                    <% if (c.getQuantity() < c.getStock()) { %>
                    <a href="quantity-inc-dec?action=inc&id=<%= c.getId() %>&variation=<%= c.getVariation() %>">+</a>
                    <% } else { %>
                    <a href="javascript:void(0)" style="background: #ccc; cursor: not-allowed;" title="Max Stock reached">max</a>
                    <% } %>
                </div>
            </td>
            <td class="subtotal-cell">RM <%= dcf.format(itemSubtotal) %></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <div class="total-price">
        <table>
            <tr>
                <td>Total:</td>
                <td>RM <%= dcf.format(total) %></td>
            </tr>
        </table>
    </div>

    <div class="cart-actions">
        <a href="products.jsp" class="continue-shopping">← Continue Shopping</a>
        <a href="checkout.jsp" class="btn-blue-style">Proceed to Checkout →</a>
    </div>

    <% } else { %>
    <div class="empty-cart-msg">
        <h3>Your cart is empty!</h3>
        <p>Browse our products and add items to your cart.</p>
        <a href="products.jsp" class="btn-blue-style">Start Shopping</a>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>