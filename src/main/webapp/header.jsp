<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Maintain Java logic to check session
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

    /* Navigation Links Container (Desktop) */
    .navbar .nav-links {
        display: flex;
        align-items: center;
        gap: 35px;
    }

    .navbar .nav-links a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        font-size: 16px;
        transition: all 0.3s ease;
        position: relative;
    }

    .navbar .nav-links a:hover {
        color: #000;
    }

    /* Underline on hover */
    .navbar .nav-links a::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -5px;
        left: 0;
        background-color: #000;
        transition: width 0.3s ease;
    }

    .navbar .nav-links a:hover::after {
        width: 100%;
    }

    /* Cart Icon - No more inline style needed */
    .navbar .cart-link {
        display: inline-flex;
        align-items: center;
    }

    .navbar .cart-icon {
        width: 24px;
        height: 24px;
        vertical-align: middle;
        transition: transform 0.3s ease;
    }

    .navbar .cart-link:hover .cart-icon {
        transform: scale(1.1);
    }

    /* Login/Signup Link Styling */
    .navbar .login-link {
        font-weight: bold;
        color: #333;
    }

    .navbar .login-link:hover {
        color: #000;
    }

    /* My Orders Link Styling */
    .navbar .order-link {
        color: #333;
        font-weight: 500;
    }

    .navbar .order-link:hover {
        color: #000;
    }

    /* Logout Button Special Styling */
    .navbar .logout-link {
        color: #ff4d4d;
        font-weight: bold;
    }

    .navbar .logout-link:hover {
        color: #cc0000;
    }

    /* HAMBURGER MENU (Default Hidden on Desktop) */
    .hamburger {
        display: none;
        flex-direction: column;
        cursor: pointer;
        gap: 5px;
    }

    .hamburger div {
        width: 25px;
        height: 3px;
        background-color: #333;
        transition: all 0.3s ease;
    }

    /* RESPONSIVE: TABLET & MOBILE */
    @media (max-width: 992px) {
        .navbar {
            padding: 15px 30px;
        }
        .nav-links {
            gap: 20px;
        }
    }

    @media (max-width: 768px) {
        .navbar {
            padding: 15px 20px;
            /* Keep logo and hamburger in the same row */
            flex-direction: row;
            flex-wrap: wrap;
        }

        /* Show Hamburger on Mobile */
        .hamburger {
            display: flex;
        }

        /* Hide Menu by default on Mobile */
        .nav-links {
            display: none; /* Hidden */
            width: 100%;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
            background-color: white;
            border-top: 1px solid #eee;
        }

        /* This class will be added by JavaScript when user clicks hamburger */
        .nav-links.active {
            display: flex; /* Visible */
        }

        /* Animate Hamburger into 'X' when active */
        .hamburger.active .bar1 {
            transform: rotate(-45deg) translate(-5px, 6px);
        }
        .hamburger.active .bar2 {
            opacity: 0;
        }
        .hamburger.active .bar3 {
            transform: rotate(45deg) translate(-5px, -6px);
        }
    }
</style>

<nav class="navbar">
    <a href="index.jsp" class="logo">
        <img src="assets/img/logo_rheaka.png" alt="Logo" class="logo-img">
        Rheaka Design
    </a>

    <div class="hamburger" id="hamburger-btn">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
    </div>

    <div class="nav-links" id="nav-menu">
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Services</a>
        <a href="quote.jsp">Get A Quote</a>
        <a href="contact.jsp">Contact Us</a>

        <a href="cart.jsp" class="cart-link">
            <img src="images/cart.png" alt="Cart" class="cart-icon">
        </a>

        <% if (userLoggedIn == null) { %>
        <a href="login.jsp" class="login-link">Login/Signup</a>
        <% } else { %>
        <a href="orders.jsp" class="order-link">My Orders</a>
        <a href="LogoutServlet" class="logout-link">Logout</a>
        <% } %>
    </div>
</nav>

<script>
    const hamburger = document.getElementById('hamburger-btn');
    const navMenu = document.getElementById('nav-menu');

    hamburger.addEventListener('click', () => {
        // Toggle 'active' class on menu and button
        navMenu.classList.toggle('active');
        hamburger.classList.toggle('active');
    });
</script>