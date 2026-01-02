<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.rheakaprinting.dao.OrderDao" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;

    if (auth != null) {
        OrderDao orderDao = new OrderDao(DbConnection.getConnection());
        orders = orderDao.userOrders(auth.getUserId());
    } else {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Orders | Rheaka Printing</title>
    <%@ include file="header.jsp" %>
    <style>
        /* 2. (Optional) Set container jadi putih supaya table nampak kemas & 'pop-up' */
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px; /* Bucu curve sikit */
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Bayang sikit */
            margin-top: 50px !important; /* Jarak dari atas */
            margin-bottom: 50px; /* Jarak dari bawah */
        }
    </style>
</head>
<body style="background-color: lightsteelblue !important;">

<div class="container"> <h2 class="text-center mb-4">My Order History</h2>

    <table class="table table-bordered table-hover">
        <thead class="bg-light">
        <tr>
            <th>Date</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <% if(orders != null) {
            for(Order o : orders) { %>
        <tr>
            <td><%= o.getDate() %></td>
            <td><%= o.getName() %></td>
            <td><%= o.getQuantity() %></td>
            <td>RM <%= String.format("%.2f", o.getPrice()) %></td> <td>
            <%
                String status = o.getStatus();
                String badgeClass = "badge-secondary";

                if("Pending".equals(status)) { badgeClass = "badge-warning"; }
                else if("Printing".equals(status)) { badgeClass = "badge-info"; }
                else if("Shipped".equals(status)) { badgeClass = "badge-primary"; }
                else if("Delivered".equals(status)) { badgeClass = "badge-success"; }
            %>
            <span class="badge <%= badgeClass %> p-2" style="font-size: 14px;">
                        <%= status %>
                    </span>
        </td>
        </tr>
        <% } } %>
        </tbody>
    </table>

    <% if(orders == null || orders.isEmpty()) { %>
    <div class="text-center py-4">
        <h4>No orders yet. <a href="index.jsp">Shop Now</a></h4>
    </div>
    <% } %>

</div>

<%@ include file="footer.jsp" %>
</body>
</html>