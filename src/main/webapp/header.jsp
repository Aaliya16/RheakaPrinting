<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Kekalkan logic Java untuk check session
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
    .nav-links {
        display: flex;
        align-items: center;
        gap: 35px;
    }

    .nav-links a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        font-size: 16px;
        transition: all 0.3s ease;
        position: relative;
    }

    .nav-links a:hover {
        color: #000;
    }

    /* Garis bawah bila hover */
    .nav-links a::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -5px;
        left: 0;
        background-color: #000;
        transition: width 0.3s ease;
    }

    .nav-links a:hover::after {
        width: 100%;
    }

    /* Cart Icon */
    .nav-links a img {
        transition: transform 0.3s ease;
    }

    .nav-links a:hover img {
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
            /* Pastikan logo dan hamburger duduk sebaris */
            flex-direction: row;
            flex-wrap: wrap;
        }

        /* Tunjuk Hamburger di Mobile */
        .hamburger {
            display: flex;
        }

        /* Sembunyikan Menu secara default di Mobile */
        .nav-links {
            display: none; /* Hilang */
            width: 100%;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
            background-color: white;
            border-top: 1px solid #eee;
        }

        /* Class ini akan ditambah oleh JavaScript bila user klik hamburger */
        .nav-links.active {
            display: flex; /* Muncul */
        }

        /* Animasi Hamburger jadi 'X' bila aktif */
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

        <a href="cart.jsp">
            <img src="images/cart.png" width="24px" height="24px" alt="Cart" style="vertical-align: middle;">
        </a>

        <% if (userLoggedIn == null) { %>
        <a href="login.jsp" style="font-weight: bold;">Login/Signup</a>
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
        // Toggle class 'active' pada menu dan butang
        navMenu.classList.toggle('active');
        hamburger.classList.toggle('active');
    });
</script>