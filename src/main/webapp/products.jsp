<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our Services - Rheaka Printing</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* CSS Variables for consistent branding */
        :root {
            --mongoose: #baa987;
            --steelblue: #b0c4de;
            --deep-black: #000000;
            --accent-gold: #d4af37;
        }

        * {
            box-sizing: border-box;
        }

        /* Gradient background for a premium look */
        body {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 50%, #7e8ba3 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 20% 50%, rgba(186, 169, 135, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 80%, rgba(176, 196, 222, 0.1) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
        }

        /* Page Header Styling */
        .header-section {
            text-align: center;
            padding: 80px 20px 60px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.85) 100%);
            margin-bottom: 50px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
            border-bottom: 3px solid var(--mongoose);
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--mongoose), var(--accent-gold), var(--mongoose));
        }

        .header-section h2 {
            color: var(--deep-black) !important;
            font-size: 3.2rem;
            margin: 0 0 15px 0;
            font-weight: 800;
            letter-spacing: -1px;
            text-transform: uppercase;
            background: linear-gradient(135deg, #000 0%, #333 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-section p {
            color: #444;
            font-weight: 600;
            font-size: 1.1rem;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        /* Product Grid Configuration */
        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 35px;
            padding: 0 50px 80px 50px;
            max-width: 1400px;
            margin: auto;
            position: relative;
            z-index: 1;
        }

        /* Service Card Styling */
        .product-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 24px;
            padding: 45px 25px;
            text-align: center;
            box-shadow:
                    0 10px 40px rgba(0,0,0,0.12),
                    0 0 0 1px rgba(255,255,255,0.5) inset;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--mongoose), var(--accent-gold));
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .product-card:hover::before {
            transform: scaleX(1);
        }

        .product-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow:
                    0 20px 60px rgba(0,0,0,0.2),
                    0 0 0 1px rgba(186, 169, 135, 0.3) inset;
        }

        /* Circular Image Wrapper for Products */
        .icon-wrapper {
            width: 100px;
            height: 100px;
            margin: 0 auto 25px;
            background: linear-gradient(135deg, var(--mongoose) 0%, var(--accent-gold) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(186, 169, 135, 0.3);
            transition: all 0.4s ease;
            overflow: hidden;
            padding: 0;
        }

        .product-card:hover .icon-wrapper {
            transform: rotateY(360deg) scale(1.1);
            box-shadow: 0 12px 30px rgba(186, 169, 135, 0.5);
        }

        .icon-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .product-card i {
            color: white !important;
            font-size: 2.5rem;
        }

        .product-card h3 {
            color: var(--deep-black);
            margin: 15px 0;
            font-size: 1.6rem;
            font-weight: 700;
            letter-spacing: -0.5px;
            transition: color 0.3s ease;
        }

        .product-card:hover h3 {
            color: var(--mongoose);
        }

        .product-card p {
            color: #666;
            font-size: 1rem;
            line-height: 1.6;
            min-height: 50px;
            margin-bottom: 25px;
        }

        /* Action Button Styling */
        .btn-view {
            background: linear-gradient(135deg, var(--mongoose) 0%, var(--accent-gold) 100%);
            color: white;
            padding: 14px 35px;
            text-decoration: none;
            border-radius: 50px;
            display: inline-block;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(186, 169, 135, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-view::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-view:hover::before {
            left: 100%;
        }

        .btn-view:hover {
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--mongoose) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(186, 169, 135, 0.5);
        }

        @media (max-width: 768px) {
            .header-section h2 {
                font-size: 2.2rem;
            }

            .product-container {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 25px;
                padding: 0 20px 50px 20px;
            }

            .product-card {
                padding: 35px 20px;
            }

            .icon-wrapper {
                width: 80px;
                height: 80px;
            }

            .product-card i {
                font-size: 2rem;
            }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .product-card:nth-child(odd) .icon-wrapper {
            animation: float 3s ease-in-out infinite;
        }

        .product-card:nth-child(even) .icon-wrapper {
            animation: float 3s ease-in-out infinite;
            animation-delay: 1.5s;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="header-section">
    <h2>Rheaka Design Service</h2>
    <p>Official Inventory - Premium Printing Solutions</p>
</div>

<div class="product-container">

    <!-- 1. Acrylic Clear -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/acrylic-sticker.jpg" alt="Acrylic Clear">
        </div>
        <h3>Acrylic Clear</h3>
        <p>Premium 3mm laser-cut acrylic and high-impact boards.</p>
        <a href="product-details.jsp?id=1" class="btn-view">View Details</a>
    </div>

    <!-- 2. Apron Custom -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/apron-sticker.png" alt="Apron Custom">
        </div>
        <h3>Apron Custom</h3>
        <p>Professional kitchen wear with customization options.</p>
        <a href="product-details.jsp?id=2" class="btn-view">View Details</a>
    </div>

    <!-- 3. Industrial Signage -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/signage.jpg" alt="Industrial Signage">
        </div>
        <h3>Industrial Signage</h3>
        <p>Composite and high-impact boards with installation service.</p>
        <a href="product-details.jsp?id=3" class="btn-view">View Details</a>
    </div>

    <!-- 4. Business Card -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/business-sticker.jpg" alt="Business Card">
        </div>
        <h3>Business Card</h3>
        <p>Premium matte or glossy laminated name cards.</p>
        <a href="product-details.jsp?id=4" class="btn-view">View Details</a>
    </div>

    <!-- 5. Apparel Printing -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/apparel.jpg" alt="Apparel Printing">
        </div>
        <h3>Apparel Printing</h3>
        <p>Custom T-Shirts from XS to 7XL with optional add-ons.</p>
        <a href="product-details.jsp?id=5" class="btn-view">View Details</a>
    </div>

    <!-- 6. Banner & Bunting -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/banner-sticker.jpg" alt="Banner & Bunting">
        </div>
        <h3>Banner & Bunting</h3>
        <p>High-quality event banners and roll-up buntings in all sizes.</p>
        <a href="product-details.jsp?id=6" class="btn-view">View Details</a>
    </div>

    <!-- 7. Flags & Backdrop -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/flag-printing.jpg" alt="Flags & Backdrop">
        </div>
        <h3>Flags & Backdrop</h3>
        <p>Beach flags, custom flags and photo backdrops.</p>
        <a href="product-details.jsp?id=7" class="btn-view">View Details</a>
    </div>

    <!-- 8. Stickers & Plaque -->
    <div class="product-card">
        <div class="icon-wrapper">
            <img src="assets/img/plaque.jpg" alt="Stickers & Plaque">
        </div>
        <h3>Stickers & Plaque</h3>
        <p>Vinyl stickers, Trophies and Medals</p>
        <a href="product-details.jsp?id=8" class="btn-view">View Details</a>
    </div>

</div>
<%@ include file="footer.jsp" %>
</body>
</html>