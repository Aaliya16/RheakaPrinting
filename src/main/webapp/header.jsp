<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Maintain Java logic to check session
    Object userLoggedIn = session.getAttribute("currentUser");
%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    /* Navbar Styling */
    .navbar {
        background-color: #ffffff;
        padding: 15px 50px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 2000; /* Ditingkatkan supaya sentiasa di atas */
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .logo-section {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .logo-section img {
        height: 50px;
        width: auto;
    }

    .logo-section h1 {
        font-size: 24px;
        font-weight: 700;
        color: #333;
        margin: 0;
    }

    /* Navigation Links  */
    .nav-links {
        display: flex;
        align-items: center;
        gap: 35px;
        list-style: none;
    }

    .nav-links a {
        text-decoration: none;
        color: #333;
        font-weight: 700;
        font-size: 16px;
        transition: color 0.3s ease;
        position: relative;
    }

    .nav-links a:hover {
        color: #000;
    }

    /* Dropdown Styling */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-toggle {
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 700;
        text-decoration: none;
        color: #333;
    }

    /* ✅ FIX: PADAM ARROW KECIL BOLD (CARET) BOOTSTRAP */
    .dropdown-toggle::after {
        display: none !important;
        content: none !important;
    }

    .dropdown-toggle i {
        font-size: 14px;
        transition: transform 0.3s ease;
    }

    .dropdown:hover .dropdown-toggle i {
        transform: rotate(180deg);
    }

    /* Dropdown Menu */
    .dropdown-menu {
        position: absolute;
        top: 100%;
        left: 0;
        background: white;
        min-width: 280px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        border-radius: 8px;
        padding: 15px 0;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.3s ease;
        z-index: 3000; /* Sangat penting supaya tidak "slack" di belakang produk */
        margin-top: 10px;
    }

    .dropdown:hover .dropdown-menu {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown-menu a {
        display: block;
        padding: 12px 25px;
        color: #333;
        font-weight: 500;
        font-size: 15px;
    }

    .dropdown-menu a:hover {
        background: #f5f7fa;
        color: #000;
    }

    /* Cart & Auth Links */
    .cart-icon {
        width: 24px;
        height: 24px;
        vertical-align: middle;
    }

    .login-link, .order-link {
        font-weight: 700 !important;
    }

    .logout-link {
        color: #ff4d4d !important;
        font-weight: 700 !important;
    }
</style>

<nav class="navbar">
    <div class="logo-section">
        <img src="${pageContext.request.contextPath}/assets/img/logo_rheaka.png" alt="Rheaka Design Logo">
        <h1>Rheaka Design</h1>
    </div>

    <div class="nav-links" id="nav-menu">
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>

        <div class="dropdown">
            <a class="dropdown-toggle">
                Services
                <i class="fas fa-chevron-down"></i> </a>
            <div class="dropdown-menu">
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=1">Acrylic Clear</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=2">Apron Custom</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=3">Industrial Signage</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=4">Business Card</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=5">Apparel Printing</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=6">Banner & Bunting</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=7">Flags & Backdrop</a>
                <a href="${pageContext.request.contextPath}/product-details.jsp?id=8">Stickers & Plaque</a>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/quote.jsp">Get A Quote</a>
        <a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a>

        <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-link">
            <img src="${pageContext.request.contextPath}/assets/img/cart.png" alt="Cart" class="cart-icon">
        </a>

        <% if (userLoggedIn == null) { %>
        <a href="${pageContext.request.contextPath}/login.jsp" class="login-link">Login/Signup</a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/orders.jsp" class="order-link">My Orders</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Logout</a>
        <% } %>
    </div>
</nav>