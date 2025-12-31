<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object userLoggedIn = session.getAttribute("currentUser");
%>
<nav class="navbar">
    <h1 class="logo">
        <img src="assets/img/logo_rheaka.png" alt="Logo" class="logo-img">
        Rheaka Design
    </h1>
    <div>
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Services</a>
        <a href="quote.jsp">Get A Quote</a>
        <a href="#">Contact</a>
        <a href="cart.jsp">
            <img src="images/cart.png" width="30px" height="30px" style="vertical-align: middle;">
        </a>

        <% if (userLoggedIn == null) { %>
        <a href="login.jsp">Login/Signup</a>
        <% } else { %>
        <a href="LogoutServlet" style="color: #ff4d4d; font-weight: bold;">Logout</a>
        <% } %>
    </div>
</nav>