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

    /* Navbar Styling */
    .navbar {
        background-color: #ffffff;
        padding: 15px 50px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    /* Logo Section */
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

    /* Navigation Links */
    .nav-links {
        display: flex;
        align-items: center;
        gap: 35px;
        list-style: none;
    }

    .nav-links a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        font-size: 16px;
        transition: color 0.3s ease;
        position: relative;
    }

    /* Underline on hover */
    .nav-links a::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 0;
        height: 2px;
        background-color: #333;
        transition: width 0.3s ease;
    }

    .nav-links a:hover::after {
        width: 100%;
    }

    .nav-links a:hover {
        color: #000;
    }

    /* Dropdown Container */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-toggle {
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .dropdown-toggle i {
        font-size: 12px;
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
        z-index: 1000;
        margin-top: 15px;
    }

    .dropdown:hover .dropdown-menu {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown-menu a {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 12px 25px;
        color: #333;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 15px;
    }

    .dropdown-menu a i {
        font-size: 20px;
        color: #baa987;
        width: 25px;
    }

    .dropdown-menu a:hover {
        background: #f5f7fa;
        color: #000;
        padding-left: 30px;
    }

    .dropdown-menu a::after {
        display: none;
    }

    /* Cart Icon */
    .cart-link {
        position: relative;
    }

    .cart-icon {
        width: 24px;
        height: 24px;
        vertical-align: middle;
        transition: transform 0.3s ease;
    }

    .cart-link:hover .cart-icon {
        transform: scale(1.1);
    }

    /* Login/Logout Links */
    .login-link {
        font-weight: bold;
        color: #333;
    }

    .order-link {
        color: #333;
        font-weight: 500;
    }

    .logout-link {
        color: #ff4d4d;
        font-weight: bold;
    }

    /* Mobile Hamburger Menu */
    .hamburger {
        display: none;
        flex-direction: column;
        cursor: pointer;
        gap: 5px;
    }

    .hamburger span {
        width: 25px;
        height: 3px;
        background-color: #333;
        transition: all 0.3s ease;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .navbar {
            padding: 15px 20px;
        }

        .logo-section h1 {
            font-size: 18px;
        }

        .logo-section img {
            height: 40px;
        }

        .hamburger {
            display: flex;
        }

        .nav-links {
            position: fixed;
            top: 70px;
            right: -100%;
            width: 100%;
            max-width: 300px;
            background-color: #ffffff;
            flex-direction: column;
            align-items: flex-start;
            padding: 30px 20px;
            gap: 20px;
            box-shadow: -5px 0 15px rgba(0,0,0,0.1);
            transition: right 0.3s ease;
            height: calc(100vh - 70px);
            overflow-y: auto;
        }

        .nav-links.active {
            right: 0;
        }

        .nav-links a::after {
            display: none;
        }

        /* Mobile Dropdown */
        .dropdown-menu {
            position: static;
            box-shadow: none;
            border-radius: 0;
            padding: 10px 0 10px 20px;
            margin-top: 10px;
            background: #f5f7fa;
        }

        .dropdown:hover .dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: none;
        }

        .dropdown-menu a {
            padding: 10px 15px;
        }

        .dropdown-menu a:hover {
            padding-left: 15px;
            background: #e8ebef;
        }

        /* Hamburger Animation */
        .hamburger.active span:nth-child(1) {
            transform: rotate(45deg) translate(8px, 8px);
        }

        .hamburger.active span:nth-child(2) {
            opacity: 0;
        }

        .hamburger.active span:nth-child(3) {
            transform: rotate(-45deg) translate(7px, -7px);
        }
    }
</style>

<nav class="navbar">
    <!-- Logo Section -->
    <div class="logo-section">
        <img src="assets/img/logo_rheaka.png" alt="Rheaka Design Logo">
        <h1>Rheaka Design</h1>
    </div>

    <!-- Hamburger Menu (Mobile) -->
    <div class="hamburger" id="hamburger">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <!-- Navigation Links -->
    <div class="nav-links" id="nav-menu">
        <a href="index.jsp">Home</a>

        <!-- Services Dropdown -->
        <div class="dropdown">
            <a class="dropdown-toggle">
                Services
                <i class="fas fa-chevron-down"></i>
            </a>
            <div class="dropdown-menu">
                <a href="product-details.jsp?id=1">
                    Acrylic Clear
                </a>
                <a href="product-details.jsp?id=2">
                    Apron Custom
                </a>
                <a href="product-details.jsp?id=3">
                    Industrial Signage
                </a>
                <a href="product-details.jsp?id=4">
                    Business Card
                </a>
                <a href="product-details.jsp?id=5">
                    Apparel Printing
                </a>
                <a href="product-details.jsp?id=6">
                    Banner & Bunting
                </a>
                <a href="product-details.jsp?id=7">
                    Flags & Backdrop
                </a>
                <a href="product-details.jsp?id=8">
                    Stickers & Plaque
                </a>
            </div>
        </div>

        <a href="quote.jsp">Get A Quote</a>
        <a href="contact.jsp">Contact Us</a>

        <a href="cart.jsp" class="cart-link">
            <img src="assets/img/cart.png" alt="Cart" class="cart-icon">
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
    // Toggle mobile menu
    const hamburger = document.getElementById('hamburger');
    const navMenu = document.getElementById('nav-menu');

    hamburger.addEventListener('click', () => {
        navMenu.classList.toggle('active');
        hamburger.classList.toggle('active');
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
            navMenu.classList.remove('active');
            hamburger.classList.remove('active');
        }
    });

    // Mobile dropdown toggle
    if (window.innerWidth <= 768) {
        const dropdownToggle = document.querySelector('.dropdown-toggle');
        const dropdownMenu = document.querySelector('.dropdown-menu');

        dropdownToggle.addEventListener('click', (e) => {
            e.preventDefault();
            dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
        });
    }
</script>
