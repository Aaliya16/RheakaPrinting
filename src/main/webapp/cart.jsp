<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    double total = 0.0;

    // ✅ GET CART DIRECTLY FROM SESSION - NO DATABASE NEEDED
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

    System.out.println("=== CART.JSP DEBUG (NO DATABASE) ===");
    System.out.println("Cart from session: " + cart_list);

    if (cart_list != null && !cart_list.isEmpty()) {
        System.out.println("Cart size: " + cart_list.size());

        // Calculate total
        for (Cart c : cart_list) {
            System.out.println("Item - ID: " + c.getId() +
                    ", Name: " + c.getName() +
                    ", Price: " + c.getPrice() +
                    ", Qty: " + c.getQuantity());
            total += c.getPrice() * c.getQuantity();
        }

        System.out.println("Total: RM " + total);
        request.setAttribute("total", total);
    } else {
        System.out.println("Cart is empty or null");
    }
    System.out.println("=====================================");
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
        body { background-color: #b0c4de !important; font-family: 'Roboto', sans-serif; margin: 0; padding: 0; }

        .small-container {
            max-width: 1200px; margin: 50px auto; padding: 20px;
            background: #fff; border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 90%;
        }

        h2 {
            color: #333; margin-bottom: 30px; text-align: center;
            font-size: 28px; font-weight: 700;
        }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }

        th {
            text-align: left; padding: 15px 10px; color: #333;
            border-bottom: 2px solid var(--mongoose); background: #f8f9fa;
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

        .cart-info small {
            color: #666; font-size: 12px;
        }

        .cart-info a {
            color: #ff523b; font-size: 13px;
            text-decoration: none; font-weight: 500;
        }

        .cart-info a:hover { text-decoration: underline; }

        .quantity-btn {
            display: flex; align-items: center;
            justify-content: center; gap: 5px;
        }

        .quantity-btn a {
            background: var(--mongoose); color: white;
            width: 30px; height: 30px; line-height: 30px;
            text-align: center; text-decoration: none;
            font-weight: bold; border-radius: 5px;
            display: inline-block; transition: background 0.3s;
        }

        .quantity-btn a:hover {
            background: #a49374; transform: scale(1.05);
        }

        .quantity-btn input {
            width: 50px; text-align: center; border: 1px solid #ddd;
            font-weight: 600; margin: 0; background: #f8f9fa;
            padding: 5px; border-radius: 5px; font-size: 14px;
        }

        .price-cell {
            font-weight: 600; color: #333; font-size: 16px;
        }

        .subtotal-cell {
            font-weight: bold; color: var(--mongoose); font-size: 18px;
        }

        .total-price {
            display: flex; justify-content: flex-end;
            margin-top: 30px; padding-top: 20px;
            border-top: 2px solid var(--mongoose);
        }

        .total-price table { width: auto; border: none; }

        .total-price td {
            border: none; padding: 10px 20px;
            font-size: 20px; font-weight: bold;
        }

        .total-price td:first-child { color: #333; }
        .total-price td:last-child { color: var(--mongoose); font-size: 24px; }

        .cart-actions {
            margin-top: 30px; display: flex;
            justify-content: space-between; align-items: center;
            padding: 20px 0;
        }

        .continue-shopping {
            color: var(--mongoose); text-decoration: none;
            font-weight: 600; font-size: 16px;
        }

        .continue-shopping:hover { text-decoration: underline; }

        .checkout-btn {
            background: var(--mongoose); color: white; border: none;
            padding: 12px 30px; border-radius: 5px; cursor: pointer;
            font-weight: bold; text-decoration: none;
            display: inline-block; font-size: 16px;
            transition: background 0.3s;
        }

        .checkout-btn:hover {
            background: #a49374; transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .empty-cart-msg {
            text-align: center; padding: 80px 20px;
        }

        .empty-cart-msg h3 {
            color: #666; margin-bottom: 20px; font-size: 24px;
        }

        .empty-cart-msg p { color: #999; margin-bottom: 30px; }

        .empty-cart-msg a {
            display: inline-block; background: var(--mongoose);
            color: white; padding: 12px 30px; text-decoration: none;
            border-radius: 5px; font-weight: 600;
            transition: background 0.3s;
        }

        .empty-cart-msg a:hover { background: #a49374; }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="small-container">
    <h2>Shopping Cart</h2>

    <%
        // ✅ CHECK: Ada item dalam cart?
        if (cart_list != null && !cart_list.isEmpty()) {
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
                        <small>Product ID: <%= c.getId() %></small>
                        <a href="remove-from-cart?id=<%= c.getId() %>&variation=<%= c.getVariation() %>">🗑️ Remove</a>
                    </div>
                </div>
            </td>
            <td class="price-cell">
                RM <%= dcf.format(c.getPrice()) %>
            </td>
            <td>
                <div class="quantity-btn">
                    <a href="quantity-inc-dec?action=dec&id=<%= c.getId() %>&variation=<%= c.getVariation() %>" title="Decrease">−</a>
                    <input type="text" name="quantity" value="<%= c.getQuantity() %>" readonly>
                    <a href="quantity-inc-dec?action=inc&id=<%= c.getId() %>&variation=<%= c.getVariation() %>" title="Increase">+</a>
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
        <a href="products.jsp" class="continue-shopping">← Continue Shopping</a>
        <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout →</a>
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
</html>>