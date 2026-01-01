<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.rheakaprinting.dao.OrderDao" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>

<%
    // 1. Check Login (Wajib Login baru boleh tengok order)
    User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;

    if (auth != null) {
        // 2. Tarik data dari database guna ID user
        OrderDao orderDao = new OrderDao(DbConnection.getConnection());
        orders = orderDao.userOrders(auth.getId());
    } else {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Orders | Rheaka Printing</title>
    <%@ include file="header.jsp" %>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">My Order History</h2>

    <table class="table table-bordered table-hover">
        <thead class="bg-light">
        <tr>
            <th>Date</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Status</th> <!-- Column Paling Penting -->
        </tr>
        </thead>
        <tbody>
        <% if(orders != null) {
            for(Order o : orders) { %>
        <tr>
            <td><%= o.getDate() %></td>
            <td><%= o.getName() %></td>
            <td><%= o.getQuantity() %></td>
            <td>RM <%= String.format("%.2f", o.getPrice()) %></td>
            <td>
                <!-- Logic Warna Status -->
                <%
                    String status = o.getStatus();
                    String badgeClass = "badge-secondary"; // Default kelabu

                    if("Pending".equals(status)) { badgeClass = "badge-warning"; } // Kuning
                    else if("Printing".equals(status)) { badgeClass = "badge-info"; } // Biru Muda
                    else if("Shipped".equals(status)) { badgeClass = "badge-primary"; } // Biru Pekat
                    else if("Delivered".equals(status)) { badgeClass = "badge-success"; } // Hijau
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
    <div class="text-center">
        <h4>No orders yet. <a href="index.jsp">Shop Now</a></h4>
    </div>
    <% } %>

</div>

<%@ include file="footer.jsp" %>
</body>
</html>
