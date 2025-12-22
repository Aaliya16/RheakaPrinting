<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.example.rheakaprinting.dao.ProductDao" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    double total = 0.0;

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;

    if (cart_list != null && !cart_list.isEmpty()) {
        try {
            ProductDao pDao = new ProductDao(DbConnection.getConnection());
            cartProduct = pDao.getCartProducts(cart_list);
            total = pDao.getTotalCartPrice(cart_list);
        } catch (Exception e) {
            // If ProductDao fails, use cart_list directly
            cartProduct = cart_list;
            for (Cart c : cart_list) {
                total += c.getPrice() * c.getQuantity();
            }
        }
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shopping Cart - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --mongoose: #baa987;
        }

        body {
            background-color: #f5f5f5;
            font-family: 'Roboto', sans-serif;
        }

        .small-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 90%;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 15px 10px;
            color: #333;
            border-bottom: 2px solid var(--mongoose);
            background: #f8f9fa;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
        }

        /* Center align Price, Quantity, and Subtotal headers */
        th:nth-child(2),
        th:nth-child(3),
        th:nth-child(4) {
            text-align: center;
        }

        td {
            padding: 20px 10px;
            vertical-align: middle;
            border-bottom: 1px solid #eee;
        }

        /* Center align Price, Quantity, and Subtotal data */
        td:nth-child(2),
        td:nth-child(3),
        td:nth-child(4) {
            text-align: center;
        }

        td input {
            width: 50px;
            height: 30px;
            padding: 5px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-weight: 600;
            background: #f8f9fa;
        }

        /* --- CART INFO (PRODUCT COLUMN) --- */
        .cart-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .cart-info img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eee;
        }

        .cart-info div {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .cart-info p {
            margin: 0;
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }

        .cart-info a {
            color: #ff523b;
            font-size: 13px;
            text-decoration: none;
            font-weight: 500;
        }

        .cart-info a:hover {
            text-decoration: underline;
        }

        /* --- QUANTITY BUTTONS --- */
        .quantity-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .quantity-btn a {
            background: var(--mongoose);
            color: white;
            width: 30px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            display: inline-block;
            transition: background 0.3s;
        }

        .quantity-btn a:hover {
            background: #a49374;
        }

        .quantity-btn input {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            font-weight: 600;
            margin: 0;
            background: #f8f9fa;
        }

        /* Price column styling */
        .price-cell {
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }

        /* Subtotal column styling */
        .subtotal-cell {
            font-weight: bold;
            color: var(--mongoose);
            font-size: 18px;
        }

        /* --- TOTAL PRICE SECTION --- */
        .total-price {
            display: flex;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid var(--mongoose);
        }

        .total-price table {
            width: auto;
            border: none;
        }

        .total-price td {
            border: none;
            padding: 10px 20px;
            font-size: 20px;
            font-weight: bold;
        }

        .total-price td:first-child {
            color: #333;
        }

        .total-price td:last-child {
            color: var(--mongoose);
            font-size: 24px;
        }

        /* --- CART ACTIONS --- */
        .cart-actions {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
        }

        .continue-shopping {
            color: var(--mongoose);
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
        }

        .continue-shopping:hover {
            text-decoration: underline;
        }

        .checkout-btn {
            background: var(--mongoose);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            transition: background 0.3s;
        }

        .checkout-btn:hover {
            background: #a49374;
        }

        /* --- EMPTY CART MESSAGE --- */
        .empty-cart-msg {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-cart-msg h3 {
            color: #666;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .empty-cart-msg p {
            color: #999;
            margin-bottom: 30px;
        }

        .empty-cart-msg a {
            display: inline-block;
            background: var(--mongoose);
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            transition: background 0.3s;
        }

        .empty-cart-msg a:hover {
            background: #a49374;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<!------- cart item details -------->
<div class="small-container">
    <h2>Shopping Cart</h2>

    <%
        if (cart_list != null && cartProduct != null && !cartProduct.isEmpty()) {
    %>

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
            for (Cart c : cartProduct) {
                double itemSubtotal = c.getPrice() * c.getQuantity();
        %>
        <tr>
            <td>
                <div class="cart-info">
                    <img src="images/<%= c.getImage() != null ? c.getImage() : "default.jpg" %>"
                         alt="<%= c.getName() != null ? c.getName() : "Product" %>">
                    <div>
                        <p><%= c.getName() != null ? c.getName() : "Product #" + c.getId() %></p>
                        <a href="remove-from-cart?id=<%= c.getId() %>">Remove</a>
                    </div>
                </div>
            </td>
            <td class="price-cell">
                RM <%= dcf.format(c.getPrice()) %>
            </td>
            <td>
                <div class="quantity-btn">
                    <a href="quantity-inc-dec?action=dec&id=<%= c.getId() %>">−</a>
                    <input type="text" value="<%= c.getQuantity() %>" readonly>
                    <a href="quantity-inc-dec?action=inc&id=<%= c.getId() %>">+</a>
                </div>
            </td>
            <td class="subtotal-cell">
                RM <%= dcf.format(itemSubtotal) %>
            </td>
        </tr>
        <%
            }
        %>
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
        <a href="index.jsp" class="continue-shopping">← Continue Shopping</a>
        <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
    </div>

    <%
    } else {
    %>

    <div class="empty-cart-msg">
        <h3>Your cart is empty!</h3>
        <p>Browse our products and add items to your cart.</p>
        <a href="products.jsp">Start Shopping</a>
    </div>

    <% } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>