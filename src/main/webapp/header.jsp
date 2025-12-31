<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object userLoggedIn = session.getAttribute("currentUser");
%>

<style>
    /* Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    /* Navigation Bar */
    .navbar {
        background-color: #ffffff;
        padding: 15px 50px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    /* Logo Section */
    .logo {
        display: flex;
        align-items: center;
        gap: 15px;
        font-size: 24px;
        font-weight: bold;
        color: #000;
        margin: 0;
        text-decoration: none;
    }

    .logo-img {
        height: 50px;
        width: auto;
    }

    /* Navigation Links Container */
    .navbar > div {
        display: flex;
        align-items: center;
        gap: 35px;
    }

    /* Navigation Links */
    .navbar a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        font-size: 16px;
        transition: all 0.3s ease;
        position: relative;
    }

    .navbar a:hover {
        color: #000;
    }

    /* Underline animation on hover */
    .navbar a::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -5px;
        left: 0;
        background-color: #000;
        transition: width 0.3s ease;
    }

    .navbar a:hover::after {
        width: 100%;
    }

    /* Cart Icon */
    .navbar a img {
        transition: transform 0.3s ease;
    }

    .navbar a:hover img {
        transform: scale(1.1);
    }

    /* Logout Button Special Styling */
    .logout-link {
        color: #ff4d4d !important;
        font-weight: bold !important;
    }

    .logout-link:hover {
        color: #cc0000 !important;
    }

    /* Responsive Design */
    @media (max-width: 992px) {
        .navbar {
            padding: 15px 30px;
        }

        .navbar > div {
            gap: 20px;
        }

        .navbar a {
            font-size: 14px;
        }
    }

    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
            padding: 15px 20px;
            gap: 15px;
        }

        .navbar > div {
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        .logo {
            font-size: 20px;
        }

        .logo-img {
            height: 40px;
        }
    }
</style>

<nav class="navbar">
    <!-- Logo Section -->
    <h1 class="logo">
        <img src="assets/img/logo_rheaka.png" alt="Logo" class="logo-img">
        Rheaka Design
    </h1>

    <!-- Navigation Links -->
    <div>
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Services</a>
        <a href="quote.jsp">Get A Quote</a>
        <a href="contact.jsp">Contact</a>

        <!-- Cart Icon -->
        <a href="cart.jsp">
            <img src="images/cart.png" width="30px" height="30px" alt="Cart" style="vertical-align: middle;">
        </a>

        <!-- Login/Logout Logic -->
        <% if (userLoggedIn == null) { %>
        <a href="login.jsp">Login/Signup</a>
        <% } else { %>
        <a href="LogoutServlet" class="logout-link">Logout</a>
        <% } %>
    </div>
</nav>