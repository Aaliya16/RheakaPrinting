<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.rheakaprinting.model.Cart" %>

<%
    // 1. Check Cart
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list == null || cart_list.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    // 2. Kira Total
    double total = 0.0;
    for (Cart c : cart_list) {
        total += c.getPrice() * c.getQuantity();
    }
    DecimalFormat dcf = new DecimalFormat("#,##0.00");

    // 3. Tangkap data dari Checkout form tadi
    request.setCharacterEncoding("UTF-8");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String postcode = request.getParameter("postcode");
    String state = request.getParameter("state");

    // Gabung alamat penuh untuk disimpan ke DB nanti
    String fullAddress = address + ", " + postcode + " " + city + ", " + state;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { background: #f5f5f5; font-family: 'Roboto', sans-serif; }
        .payment-container { max-width: 600px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .payment-header { text-align: center; margin-bottom: 30px; border-bottom: 1px solid #eee; padding-bottom: 20px; }
        .total-amount { font-size: 32px; color: #baa987; font-weight: bold; margin: 10px 0; }

        /* Payment Options Styling */
        .payment-methods { display: flex; gap: 15px; margin-bottom: 20px; }
        .method-card { flex: 1; border: 2px solid #eee; border-radius: 8px; padding: 15px; text-align: center; cursor: pointer; transition: all 0.3s; }
        .method-card:hover, .method-card.active { border-color: #baa987; background: #faf8f5; }
        .method-icon { font-size: 24px; margin-bottom: 5px; display: block; }

        /* Hide Radio Buttons */
        input[type="radio"] { display: none; }
        input[type="radio"]:checked + .method-card { border-color: #baa987; background: #baa987; color: white; }

        .btn-pay { width: 100%; background: #baa987; color: white; border: none; padding: 15px; border-radius: 5px; font-size: 18px; font-weight: bold; cursor: pointer; margin-top: 20px; }
        .btn-pay:hover { background: #a49374; }

        .summary-details { background: #f9f9f9; padding: 15px; border-radius: 5px; margin-bottom: 20px; font-size: 14px; color: #555; }
    </style>
</head>
<body>
<div class="payment-container">
    <div class="payment-header">
        <h3>Complete Your Payment</h3>
        <div class="total-amount">RM <%= dcf.format(total) %></div>
        <p>Order for: <%= fullName %></p>
    </div>

    <form action="place-order" method="post">

        <input type="hidden" name="fullName" value="<%= fullName %>">
        <input type="hidden" name="email" value="<%= email %>">
        <input type="hidden" name="phone" value="<%= phone %>">
        <input type="hidden" name="address" value="<%= fullAddress %>">

        <div class="summary-details">
            <p><strong>Shipping to:</strong><br> <%= fullAddress %></p>
        </div>

        <h4>Select Payment Method</h4>
        <div class="payment-methods">
            <label>
                <input type="radio" name="paymentMethod" value="Credit Card" checked>
                <div class="method-card">
                    <span class="method-icon">💳</span>
                    <span>Card</span>
                </div>
            </label>

            <label>
                <input type="radio" name="paymentMethod" value="Online Banking">
                <div class="method-card">
                    <span class="method-icon">🏛️</span>
                    <span>FPX</span>
                </div>
            </label>

            <label>
                <input type="radio" name="paymentMethod" value="E-Wallet">
                <div class="method-card">
                    <span class="method-icon">📱</span>
                    <span>E-Wallet</span>
                </div>
            </label>
        </div>

        <div id="card-details" style="margin-top: 15px;">
            <label>Card Number (Simulasi)</label>
            <input type="text" placeholder="0000 0000 0000 0000" style="width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ddd; border-radius: 5px;">
        </div>

        <button type="submit" class="btn-pay">Pay RM <%= dcf.format(total) %></button>
    </form>
</div>

<script>
    // Script simple untuk highlight selection
    const cards = document.querySelectorAll('.method-card');
    cards.forEach(card => {
        card.addEventListener('click', function() {
            cards.forEach(c => {
                c.style.background = '';
                c.style.color = '';
            });
        });
    });
</script>
</body>
</html>
