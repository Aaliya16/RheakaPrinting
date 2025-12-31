<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rheaka Design Services</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero {
            text-align: center;
            padding: 80px 20px;
            background: rgba(255, 255, 255, 0.9);;
        }

        .hero h2 {
            font-size: 32px;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: black;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .featured {
            padding: 50px;
            text-align: center;
            background-color: lightsteelblue;
        }

        .product-grid {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .product-card {
            padding: 30px;
            border: 1px solid #dddddd;
            width: 200px;
            border-radius: 8px;
            background: white;
        }
        /* Hero image adjustment */
        .hero-banner {
            width: 100%;
            max-width: 800px;
            margin: 20px auto;
            border-radius: 8px;
            display: block;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="hero" style="text-align: center; padding: 50px 20px;">
    <h2>Professional Printing & Custom Design Services</h2>
    <p>Upload your design, customize your order, and print with high quality.</p>

    <img src="assets/img/HOMEPAGE_RHEAKA.jpg" alt="Printing Banner" class="hero-banner">

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
<%@ include file="footer.jsp" %>
</body>
</html>
