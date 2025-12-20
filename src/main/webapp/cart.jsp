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
            <td>RM <%= dcf.format(c.getPrice() * c.getQuantity()) %></td>
        </tr>
        </tbody>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align:center; padding: 50px;">
                <h3>Your cart is empty!</h3>
                <a href="index.jsp" style="color:var(--mongoose)">Go Shop Now</a>
            </td>
        </tr>
        <% } %>
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