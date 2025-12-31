<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rheaka Design Services</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            background-color: #b0c4de;
        }

        .hero {
            text-align: center;
            padding: 50px 20px 30px 20px;
            background: rgba(255, 255, 255, 0.9);
        }

        .hero h2 {
            font-size: 32px;
            margin-bottom: 10px;
            color: #000;
        }

        .hero p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }

        /* Centered banner container */
        .banner-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 20px;
            background: rgba(255, 255, 255, 0.9);
        }

        .hero-banner {
            width: 100%;
            max-width: 1200px;
            height: auto;
            border-radius: 15px;
            display: block;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .btn-container {
            text-align: center;
            padding: 30px 20px;
            background: rgba(255, 255, 255, 0.9);
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 15px 50px;
            background: black;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 18px;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background: #333;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        /* Featured Services Section */
        .featured {
            padding: 60px 20px;
            text-align: center;
            background-color: #b0c4de;
        }

        .featured h3 {
            font-size: 32px;
            margin-bottom: 50px;
            color: #000;
            font-weight: bold;
        }

        /* Product Grid - 4 columns */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Product Card */
        .product-card {
            background: white;
            padding: 40px 20px;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .product-card i {
            font-size: 60px;
            color: #000;
            margin-bottom: 20px;
        }

        .product-card h4 {
            font-size: 22px;
            color: #baa987;
            margin: 15px 0 10px 0;
            font-weight: 700;
        }

        .product-card p {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 0;
            min-height: 60px;
        }

        /* Removed - No button needed */

        /* Responsive design */
        @media (max-width: 1200px) {
            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 900px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .hero h2 {
                font-size: 24px;
            }

            .hero p {
                font-size: 16px;
            }

            .hero-banner {
                border-radius: 10px;
            }

            .btn {
                padding: 12px 40px;
                font-size: 16px;
            }

            .featured h3 {
                font-size: 26px;
            }

            .product-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<!-- Hero Section - Text Only -->
<section class="hero">
    <h2>Professional Printing & Custom Design Services</h2>
    <p>Upload your design, customize your order, and print with high quality.</p>
</section>

<!-- Banner Section - Centered Horizontally -->
<div class="banner-wrapper">
    <img src="assets/img/HOMEPAGE_RHEAKA.jpg" alt="Printing Banner" class="hero-banner">
</div>

<!-- Button Section -->
<div class="btn-container">
    <a href="products.jsp" class="btn">Shop Now</a>
</div>

<!-- Featured Services Section - All 8 Services -->
<section class="featured">
    <h3>Featured Services</h3>
    <div class="product-grid">

        <!-- 1. Acrylic Clear -->
        <div class="product-card">
            <i class="fas fa-gem"></i>
            <h4>Acrylic Clear</h4>
            <p>Premium 3mm laser-cut acrylic and high-impact boards.</p>
        </div>

        <!-- 2. Apron Custom -->
        <div class="product-card">
            <i class="fas fa-utensils"></i>
            <h4>Apron Custom</h4>
            <p>Professional kitchen wear with customization options.</p>
        </div>

        <!-- 3. Industrial Signage -->
        <div class="product-card">
            <i class="fas fa-industry"></i>
            <h4>Industrial Signage</h4>
            <p>Composite and high-impact boards with installation service.</p>
        </div>

        <!-- 4. Business Card -->
        <div class="product-card">
            <i class="fas fa-address-card"></i>
            <h4>Business Card</h4>
            <p>Premium matte or glossy laminated name cards.</p>
        </div>

        <!-- 5. Apparel Printing -->
        <div class="product-card">
            <i class="fas fa-tshirt"></i>
            <h4>Apparel Printing</h4>
            <p>Custom T-Shirts from XS to 7XL with optional add-ons.</p>
        </div>

        <!-- 6. Banner & Bunting -->
        <div class="product-card">
            <i class="fas fa-scroll"></i>
            <h4>Banner & Bunting</h4>
            <p>High-quality event banners and roll-up buntings in all sizes.</p>
        </div>

        <!-- 7. Flags & Backdrop -->
        <div class="product-card">
            <i class="fas fa-flag"></i>
            <h4>Flags & Backdrop</h4>
            <p>Beach flags, custom flags and photo backdrops.</p>
        </div>

        <!-- 8. Stickers & Plaque -->
        <div class="product-card">
            <i class="fas fa-award"></i>
            <h4>Stickers & Plaque</h4>
            <p>Vinyl stickers, Trophies, Medals, and Epoxy Nametags.</p>
        </div>

    </div>
</section>

<%@ include file="footer.jsp" %>
</body>
</html>