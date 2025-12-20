<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rheaka Design Services</title>
    <link rel="stylesheet" href="css/style.css">
    <style>

        .logo-img {
            height: 50px;
            width: auto;
            vertical-align: middle;
            margin-right: 10px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: lightsteelblue;
        }

        .logo {
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            margin: 0;
        }

        /* Hero image adjustment */
        .hero-banner {
            width: 100%;
            max-width: 800px;
            margin: 20px auto;
            border-radius: 8px;
            display: block;
        }

        footer {
            background-color: lightsteelblue;
            color: black;
            text-align: center;
            padding: 20px 0;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<header class="navbar">
    <h1 class="logo">
        <img src="assets/img/logo_rheaka.png" alt="Logo" class="logo-img">
        Rheaka Design
    </h1>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Services</a>
        <a href="#">Contact</a>
        <a href="cart.jsp">
            <img src="images/cart.png" width="30px" height="30px" style="vertical-align: middle;">
        </a>
        <a href="#">Login/Signup</a>
    </nav>
</header>

<section class="hero" style="text-align: center; padding: 50px 20px;">
    <h2>Professional Printing & Custom Design Services</h2>
    <p>Upload your design, customize your order, and print with high quality.</p>

    <img src="assets/img/homepage.jpg" alt="Printing Banner" class="hero-banner">

    <div style="margin-top: 20px;">
        <a href="products.jsp" class="btn">Shop Now</a>
    </div>
</section>

<section class="featured" style="text-align: center;">
    <h3>Featured Services</h3>
    <div class="product-grid" style="display: flex; justify-content: center; gap: 20px; padding: 20px;">
        <div class="product-card">Business Cards</div>
        <div class="product-card">Stickers</div>
        <div class="product-card">Posters</div>
    </div>
</section>

<footer>
    <p>&copy; 2025 Rheaka Design Printing. All Rights Reserved.</p>
    <p>123 Arau, Perlis, Malaysia | 011-7078-7469</p>
</footer>
</body>
</html>
