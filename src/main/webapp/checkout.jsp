<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    double total = 0.0;

    // RETRIEVE SHIPPING FROM DATABASE
    double shipping = 10.0; // default
    try {
        Connection conn = DbConnection.getConnection();
        String sql = "SELECT base_fee, free_threshold FROM shipping_settings WHERE id = 1";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            shipping = rs.getDouble("base_fee");
            double freeThreshold = rs.getDouble("free_threshold");

            // Calculate cart total
            if (cart_list != null) {
                for (Cart c : cart_list) {
                    total += c.getPrice() * c.getQuantity();
                }
            }

            // Apply free shipping if threshold met
            if (total >= freeThreshold) {
                shipping = 0.0;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    double grandTotal = total + shipping;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Checkout - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            /* Tema gradient biru Steel Blue */
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
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
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 700;
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
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #4682B4;
            box-shadow: 0 0 0 3px rgba(70, 130, 180, 0.1);
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

        /* --- GARISAN TOTAL WARNA BIRU --- */
        .summary-total {
            display: flex;
            justify-content: space-between;
            padding: 20px 0;
            font-size: 20px;
            font-weight: bold;
            border-top: 2px solid #4682B4;
            margin-top: 10px;
        }

        .summary-total span:last-child {
            color: #4682B4;
            font-size: 24px;
        }

        /* --- BUTANG PLACE ORDER (Blue Theme) --- */
        .place-order-btn {
            display: inline-block;
            width: 100%;
            padding: 15px;
            background: #4682B4;
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .place-order-btn:hover {
            background: #357ABD;
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        /* --- BACK TO CART LINK --- */
        .back-to-cart {
            display: inline-block;
            color: white;
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 600;
            transition: 0.3s;
        }

        .back-to-cart:hover {
            text-decoration: underline;
            color: #f0f0f0;
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

        .item-name { flex: 1; color: #333; }
        .item-price { font-weight: 600; }

        @media (max-width: 768px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="checkout-container">
    <a href="cart.jsp" class="back-to-cart">← Back to Cart</a>

    <%
        if (cart_list != null && !cart_list.isEmpty()) {
    %>

    <div class="checkout-grid">
        <div class="checkout-card">
            <h2>Billing Information</h2>
            <form action="payment.jsp" method="post" id="checkoutForm">
                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" placeholder="Enter recipient's name" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email" placeholder="recipient@example.com" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number *</label>
                    <input type="tel" id="phone" name="phone" placeholder="+60 12-345 6789" required>
                </div>

                <div class="form-group">
                    <label for="address">Street Address *</label>
                    <textarea id="address" name="address" placeholder="No. House, Street Name" required></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City *</label>
                        <input type="text" id="city" name="city" required>
                    </div>

                    <div class="form-group">
                        <label for="postcode">Postcode *</label>
                        <input type="text" id="postcode" name="postcode" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="state">State *</label>
                    <select id="state" name="state" required>
                        <option value="">Select State</option>
                        <option value="Johor">Johor</option>
                        <option value="Kedah">Kedah</option>
                        <option value="Kelantan">Kelantan</option>
                        <option value="Kuala Lumpur">Kuala Lumpur</option>
                        <option value="Labuan">Labuan</option>
                        <option value="Melaka">Melaka</option>
                        <option value="Negeri Sembilan">Negeri Sembilan</option>
                        <option value="Pahang">Pahang</option>
                        <option value="Penang">Penang</option>
                        <option value="Perak">Perak</option>
                        <option value="Perlis">Perlis</option>
                        <option value="Putrajaya">Putrajaya</option>
                        <option value="Sabah">Sabah</option>
                        <option value="Sarawak">Sarawak</option>
                        <option value="Selangor">Selangor</option>
                        <option value="Terengganu">Terengganu</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="notes">Order Notes (Optional)</label>
                    <textarea id="notes" name="notes" placeholder="Any special instructions for your order..."></textarea>
                </div>
            </form>
        </div>

        <div class="checkout-card order-summary">
            <h2>Order Summary</h2>

            <div class="cart-items-list">
                <%
                    for (Cart c : cart_list) {
                        double itemTotal = c.getPrice() * c.getQuantity();
                %>
                <div class="cart-item-row">
                    <span class="item-name"><%= c.getName() != null ? c.getName() : "Product #" + c.getId() %></span>
                    <span class="item-price">RM <%= dcf.format(itemTotal) %></span>
                    <span class="item-qty">x <%= c.getQuantity() %></span>
                </div>
                <%
                    }
                %>
            </div>

            <div class="summary-item">
                <span>Subtotal</span>
                <span>RM <%= dcf.format(total) %></span>
            </div>

            <div class="summary-item">
                <span>Shipping</span>
                <span>RM <%= dcf.format(shipping) %></span>
            </div>

            <div class="summary-total">
                <span>Total</span>
                <span>RM <%= dcf.format(grandTotal) %></span>
            </div>

            <button type="submit" form="checkoutForm" class="place-order-btn">Place Order</button>
        </div>
    </div>

    <%
    } else {
    %>

    <div class="checkout-card" style="text-align: center; padding: 80px 20px;">
        <h2>Your cart is empty!</h2>
        <p style="color: #666; margin: 20px 0;">Add some products to your cart before checking out.</p>
        <a href="products.jsp" class="place-order-btn" style="text-decoration:none;">Start Shopping</a>
    </div>

    <% } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>


