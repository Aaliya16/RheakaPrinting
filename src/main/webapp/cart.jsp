<%--
  Created by IntelliJ IDEA.
  User: MSI MODERN 15
  Date: 19/12/2025
  Time: 1:25 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.example.rheakaprinting.dao.ProductDao" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    /*User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }*/
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DbConnection.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        double total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rheaka Design Services</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .small-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 90%;
        }

        table {
            width: 100%;
            border-collapse: collapse;

        }

        th {
            text-align: center;
            padding: 10px;
            color: black;
            border-bottom: 2px solid #baa987;
            background: white;
            font-weight: normal;
            border-right: 2px solid rgba(255,255,255,0.3);
        }

        /* Centerkan Header Quantity & Price */
        th:nth-child(2), td:nth-child(2),
        th:nth-child(3), td:nth-child(3) {
            text-align: center;
        }

        /* Header Total (Kanan sikit tapi tak rapat dinding) */
        th:last-child, td:last-child {
            text-align: right;
            padding-right: 20px;
        }

        td {
            padding: 15px;
            vertical-align: middle;
            background: white;
            color: black;
        }

        /* Centerkan Isi Quantity & Price */
        td:nth-child(2), td:nth-child(3) {
            text-align: center;
        }

        /* Isi Total (Kanan) */
        td:last-child {
            text-align: right;
            padding-right: 20px;
            font-weight: bold;
        }

        td input {
            width: 40px;
            height: 30px;
            padding: 5px;
        }

        td img {
            width: 80px;
            height: 80px;
            margin-right: 10px;
            border-radius: 5px; /* Tambah bucu bulat sikit kat gambar */
        }

        /* --- CART INFO (GAMBAR & NAMA) --- */
        .cart-info {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .cart-info p {
            margin: 0;
            font-weight: bold;
        }

        .cart-info img {
            width: 60px; /* Kecilkan sikit gambar */
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        /* Link Remove */
        .cart-info a {
            color: #ff523b;
            font-size: 12px;
            text-decoration: none;
        }

        /* --- QUANTITY BUTTONS --- */
        .quantity-btn {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-btn a {
            background: #eee;
            color: #333;
            width: 25px;
            height: 25px;
            line-height: 25px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            border-radius: 3px;
            display: inline-block;
        }

        .quantity-btn a:hover {
            background: #ddd;
        }

        .quantity-btn input {
            width: 40px;
            text-align: center;
            border: none;
            font-weight: bold;
            margin: 0 5px;
        }

        /* --- TOTAL PRICE SECTION (BAWAH) --- */
        .total-price {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #baa987; /* Garis pemisah total */
        }

        .total-price table {
            width: auto; /* Supaya tak makan penuh */
            border: none;
        }

        .total-price td {
            border: none; /* Buang garis dlm total */
            padding: 5px 20px;
            font-size: 18px;
        }

        /* --- MESEJ EMPTY CART --- */
        .empty-cart-msg {
            text-align: center;
            padding: 50px;
        }

        .empty-cart-msg a {
            display: inline-block;
            margin-top: 10px;
            background: #baa987;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<!------- cart item details -------->
<div class="small-container">
    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
        </tr>
        </thead>
        <%
            if (cart_list != null && cartProduct != null && !cartProduct.isEmpty()) {
                for (Cart c : cartProduct) {
        %>
        <tbody>
        <tr>
            <td>
                <div class="cart-info">
                    <img src="images/<%= c.getImage() %>" alt="" width="80">
                    <div>
                        <p><%= c.getName() %></p>
                        <a href="remove-from-cart?id=<%= c.getId() %>">Remove</a>
                    </div>
                </div>
            </td>
            <td>
                RM <%= dcf.format(c.getPrice()) %>
            </td>
            <td>
                <form action="quantity-inc-dec" method="get" class="quantity-form">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <div class="quantity-btn">
                        <a href="quantity-inc-dec?action=dec&id=<%= c.getId() %>">-</a>
                        <input type="text" name="quantity" value="<%= c.getQuantity() %>" readonly>
                        <a href="quantity-inc-dec?action=inc&id=<%= c.getId() %>">+</a>
                    </div>
                </form>
            </td>
            <td>RM <%= dcf.format(c.getPrice())%></td>
            <td>RM <%= dcf.format(c.getPrice() * c.getQuantity()) %></td>
        </tr>
        <%
            }
        %>
        <tr class="total-row">
            <td colspan="2"></td> <td>Total</td>        <td>RM <%= (request.getAttribute("total") != null) ? dcf.format(request.getAttribute("total")) : "0.00" %></td> </tr>
        <%
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align:center; padding: 50px;">
                <h3>Your cart is empty!</h3>
                <a href="index.jsp" style="color:var(--mongoose)">Go Shop Now</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <div class="total-price">
        <table>
            <tr>
                <td>Total</td>
                <td>RM <%= (request.getAttribute("total") != null) ? dcf.format(request.getAttribute("total")) : "0.00" %></td>
            </tr>
        </table>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>