<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Maintain Java logic to check session
    Object userLoggedIn = session.getAttribute("currentUser");
%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* Reset */
    * {
        //global layout reset
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
        z-index: 99999;
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
        position: relative;
        overflow: visible;
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
        overflow: visible;
        padding-bottom: 10px; /* Memberi ruang extra di bawah butang Services */
        margin-bottom: -10px; /* Meneutralkan padding supaya layout tidak lari */
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

    /* Dropdown Menu - Updated */
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
        transition: all 0.3s ease, transform 0.3s ease, visibility 0s linear 0.1s;
        /* Increased z-index and added !important to override Bootstrap */
        z-index: 100000 !important;
        margin-top: 0;
        display: none; /* Add this to prevent accidental clicks when hidden */
        padding-top: 15px;
    }

    .dropdown:hover .dropdown-menu {
        display: block !important; /* Overrides Bootstrap .dropdown-menu { display: none; } */
        opacity: 1 !important;
        visibility: visible !important;
        transform: translateY(0) !important;
        transition-delay: 0s;
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
            /* Keep logo and hamburger in same row */
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

        /* This class added by JavaScript when user clicks hamburger */
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
    <div class="logo-section">
        <img src="${pageContext.request.contextPath}/assets/img/logo_rheaka.png" alt="Rheaka Design Logo">
        <h1>Rheaka Design</h1>
    </div>

    <div class="hamburger" id="hamburger-btn">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
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

<script>
    const hamburger = document.getElementById('hamburger-btn');
    const navMenu = document.getElementById('nav-menu');

    hamburger.addEventListener('click', () => {
        // Toggle 'active' class on menu and button
        navMenu.classList.toggle('active');
        hamburger.classList.toggle('active');
    });
</script>