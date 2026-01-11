<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    double total = 0.0;

    ArrayList<Cart> session_cart = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cart_list = null;
    if (session_cart != null) {
        com.example.rheakaprinting.dao.ProductDao pDao = new com.example.rheakaprinting.dao.ProductDao(com.example.rheakaprinting.model.DbConnection.getConnection());
        // Sync session data with DB (price, image, and available stock)
        cart_list = pDao.getCartProducts(session_cart);
        total = pDao.getTotalCartPrice(session_cart);
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

            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif; margin: 0; padding: 0;
            min-height: 100vh;
        }

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

        /* Product image and name container */
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

        .empty-cart-msg {
            background: #fff;
            padding: 80px 30px;
            text-align: center;
            animation: fadeInLeft 0.8s ease;
        }

        .empty-icon-small {
            font-size: 100px;
            color: #4682B4;
            margin-bottom: 20px;
            opacity: 0.6;
        }

        .empty-cart-msg h3 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .empty-cart-msg p {
            color: #666;
            margin-bottom: 30px;
        }

        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type=number] {
            -moz-appearance: textfield;
        }

        .quantity-btn input {
            width: 50px;
            height: 35px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            margin: 0;
        }

        .btn-qty {
            background: #4682B4;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: none;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .btn-qty:hover {
            background: #357ABD;
            transform: scale(1.1);
        }

        .btn-disabled {
            background: #ccc !important;
            cursor: not-allowed !important;
        }
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

        <tr id="cart-row-<%= c.getId() %>">
            <td>
                <div class="cart-info">
                    <img src="assets/img/<%= c.getImage() != null ? c.getImage() : "default.jpg" %>"
                         alt="<%= c.getName() != null ? c.getName() : "Product" %>">
                    <div>
                        <p><%= c.getName() != null && !c.getName().isEmpty() ? c.getName() : "Product #" + c.getId() %></p>
                        <small>Product ID: <%= c.getId() %></small><br>
                        <small>Available stock: <%= c.getStock() %></small><br>
                        <a href="javascript:void(0)" onclick="removeFromCart('<%= c.getId() %>')">Remove</a>
                    </div>
                </div>
            </td>
            <td class="price-cell">RM <%= dcf.format(c.getPrice()) %></td>
            <td>
                <div class="quantity-btn">

                    <button type="button" class="btn-qty <%= c.getQuantity() <= 1 ? "btn-disabled" : "" %>"
                            onclick="changeQty('<%= c.getId() %>', -1)"
                            <%= c.getQuantity() <= 1 ? "title='Min 1 reached'" : "" %>>−</button>

                    <input type="number"
                           id="qty-input-<%= c.getId() %>"
                           value="<%= c.getQuantity() %>"
                           min="1"
                           max="<%= c.getStock() %>"
                           onchange="updateQuantity(this, '<%= c.getId() %>')">

                    <button type="button" class="btn-qty <%= c.getQuantity() >= c.getStock() ? "btn-disabled" : "" %>"
                            onclick="changeQty('<%= c.getId() %>', 1)"
                            <%= c.getQuantity() >= c.getStock() ? "title='Max Stock reached'" : "" %>>+</button>
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
        <div class="empty-icon-small">
            <i class="fas fa-shopping-bag"></i>
        </div>

        <h3>Your cart is empty!</h3>
        <p>Browse our products and add items to your cart.</p>

        <a href="products.jsp" class="btn-blue-style">Start Shopping</a>
    </div>
    <% } %>
    <% if (cart_list != null && !cart_list.isEmpty()) { %>
    <!-- Persistence Controls -->
    <div class="persistence-controls">
        <h4>Cart Persistence Controls</h4>
        <button onclick="saveCartToFile()" class="btn-persist">Save Cart</button>
        <button onclick="loadCartFromFile()" class="btn-persist load">Load Cart</button>
        <button onclick="clearCartFile()" class="btn-persist clear">Clear Saved Cart</button>
        <button onclick="checkCartFile()" class="btn-persist" style="background: #6c757d;">Check Status</button>

        <div id="persist-status" class="persist-status"></div>
    </div>
    <% } %>
</div>

<script>

    // 1. UPDATE QUANTITY
    function updateQuantity(input, id) {
        let newQty = parseInt(input.value);
        const maxStock = parseInt(input.getAttribute("max"));

        // Validate input
        if (isNaN(newQty) || newQty < 1) {
            newQty = 1;
            input.value = 1;
        } else if (newQty > maxStock) {
            newQty = maxStock;
            input.value = maxStock;
        }

        // Send AJAX request
        fetch('quantity-inc-dec?action=update&id=' + id + '&quantity=' + newQty, {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update subtotal untuk item ini
                    updateItemSubtotal(id, data.itemSubtotal);

                    // Update total keseluruhan cart
                    updateCartTotal(data.cartTotal);

                    // Update button states (enable/disable)
                    updateButtonStates(id, newQty, maxStock);
                }
            })
            .catch(err => console.error("Error updating cart:", err));
    }

    // 2. INCREASE/DECREASE QUANTITY
    function changeQty(id, delta) {
        const input = document.getElementById('qty-input-' + id);
        if (!input) return;

        let newVal = parseInt(input.value) + delta;
        const max = parseInt(input.getAttribute("max"));

        if (newVal >= 1 && newVal <= max) {
            input.value = newVal;
            updateQuantity(input, id);
        }
    }

    // 3. REMOVE ITEM FROM CART (NEW!)
    function removeFromCart(id) {
        // Confirm before removing
        if (!confirm('Remove this item from cart?')) {
            return;
        }

        // Send AJAX request
        fetch('remove-from-cart?id=' + id, {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Remove the row from table
                    const row = document.getElementById('cart-row-' + id);
                    if (row) {
                        // Add fade-out animation
                        row.style.transition = 'opacity 0.3s ease';
                        row.style.opacity = '0';

                        setTimeout(() => {
                            row.remove();

                            // Update total cart
                            updateCartTotal(data.cartTotal);

                            // Check if cart is empty
                            if (data.isEmpty) {
                                showEmptyCartMessage();
                            }
                        }, 300);
                    }
                }
            })
            .catch(err => console.error("Error removing item:", err));
    }

    // 4. SHOW EMPTY CART MESSAGE
    function showEmptyCartMessage() {
        const container = document.querySelector('.small-container');
        if (container) {
            container.innerHTML = `
            <div class="empty-cart-msg">
                <div class="empty-icon-small">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <h3>Your cart is empty!</h3>
                <p>Browse our products and add items to your cart.</p>
                <a href="products.jsp" class="btn-blue-style">Start Shopping</a>
            </div>
        `;
        }
    }

    function updateItemSubtotal(id, subtotal) {
        const row = document.getElementById('qty-input-' + id).closest('tr');
        const subtotalCell = row.querySelector('.subtotal-cell');
        if (subtotalCell) {
            subtotalCell.textContent = 'RM ' + subtotal;
        }
    }

    // Update total cart
    function updateCartTotal(total) {
        const totalCell = document.querySelector('.total-price td:last-child');
        if (totalCell) {
            totalCell.textContent = 'RM ' + total;
        }
    }

    // Enable/disable buttons based on quantity
    function updateButtonStates(id, currentQty, maxStock) {
        const row = document.getElementById('qty-input-' + id).closest('tr');
        const buttons = row.querySelectorAll('.btn-qty');

        // Button decrease (index 0)
        if (buttons[0]) {
            if (currentQty <= 1) {
                buttons[0].classList.add('btn-disabled');
                buttons[0].setAttribute('title', 'Min 1 reached');
                buttons[0].style.cursor = 'not-allowed';
            } else {
                buttons[0].classList.remove('btn-disabled');
                buttons[0].removeAttribute('title');
                buttons[0].style.cursor = 'pointer';
            }
        }

        // Button increase (index 1)
        if (buttons[1]) {
            if (currentQty >= maxStock) {
                buttons[1].classList.add('btn-disabled');
                buttons[1].setAttribute('title', 'Max Stock reached');
                buttons[1].style.cursor = 'not-allowed';
            } else {
                buttons[1].classList.remove('btn-disabled');
                buttons[1].removeAttribute('title');
                buttons[1].style.cursor = 'pointer';
            }
        }
    }
</script>

<%@ include file="footer.jsp" %>
</body>
</html>