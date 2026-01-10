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
        :root {
            --mongoose: #baa987;
            --steelblue: #b0c4de;
            --deep-black: #000000;
        }

        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .header-section {
            text-align: center;
            padding: 50px 20px;
            background: rgba(255, 255, 255, 0.9);
            margin-bottom: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .header-section h2 {
            color: var(--deep-black) !important;
            font-size: 2.8rem;
            margin: 0;
            font-weight: 800;
        }

        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding: 0 40px 60px 40px;
            max-width: 1300px;
            margin: auto;
        }

        .product-card {
            background: white;
            border-radius: 20px;
            padding: 40px 20px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .product-card:hover {
            transform: translateY(-10px);
        }

        .product-card i {
            color: var(--deep-black) !important;
            margin-bottom: 20px;
        }

        .product-card h3 {
            color: var(--mongoose);
            margin: 15px 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .product-card p {
            color: #555;
            font-size: 0.95rem;
            min-height: 50px;
            margin-bottom: 20px;
        }

        .btn-view {
            background: var(--mongoose);
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 12px;
            display: inline-block;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-view:hover { background: #a39375; }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="header-section">
    <h2>Rheaka Printing Services</h2>
    <p style="color: #333; font-weight: 500;">Official Inventory - Premium Printing Solutions</p>
</div>

<div class="product-container">

    <!-- 1. Acrylic Clear -->
    <div class="product-card">
        <i class="fas fa-gem fa-4x"></i>
        <h3>Acrylic Clear</h3>
        <p>Premium 3mm laser-cut acrylic and high-impact boards.</p>
        <a href="product-details.jsp?id=1" class="btn-view">View Details</a>
    </div>

    <!-- 2. Apron Custom -->
    <div class="product-card">
        <i class="fas fa-utensils fa-4x"></i>
        <h3>Apron Custom</h3>
        <p>Professional kitchen wear with customization options.</p>
        <a href="product-details.jsp?id=2" class="btn-view">View Details</a>
    </div>

    <!-- 3. Industrial Signage -->
    <div class="product-card">
        <i class="fas fa-industry fa-4x"></i>
        <h3>Industrial Signage</h3>
        <p>Composite and high-impact boards with installation service.</p>
        <a href="product-details.jsp?id=3" class="btn-view">View Details</a>
    </div>

    <!-- 4. Business Card -->
    <div class="product-card">
        <i class="fas fa-address-card fa-4x"></i>
        <h3>Business Card</h3>
        <p>Premium matte or glossy laminated name cards.</p>
        <a href="product-details.jsp?id=4" class="btn-view">View Details</a>
    </div>

    <!-- 5. Apparel Printing -->
    <div class="product-card">
        <i class="fas fa-tshirt fa-4x"></i>
        <h3>Apparel Printing</h3>
        <p>Custom T-Shirts from XS to 7XL with optional add-ons.</p>
        <a href="product-details.jsp?id=5" class="btn-view">View Details</a>
    </div>

    <!-- 6. Banner & Bunting -->
    <div class="product-card">
        <i class="fas fa-scroll fa-4x"></i>
        <h3>Banner & Bunting</h3>
        <p>High-quality event banners and roll-up buntings in all sizes.</p>
        <a href="product-details.jsp?id=6" class="btn-view">View Details</a>
    </div>

    <!-- 7. Flags & Backdrop -->
    <div class="product-card">
        <i class="fas fa-flag fa-4x"></i>
        <h3>Flags & Backdrop</h3>
        <p>Beach flags, custom flags and photo backdrops.</p>
        <a href="product-details.jsp?id=7" class="btn-view">View Details</a>
    </div>

    <!-- 8. Stickers & Plaque -->
    <div class="product-card">
        <i class="fas fa-award fa-4x"></i>
        <h3>Stickers & Plaque</h3>
        <p>Vinyl stickers, Trophies and Medals</p>
        <a href="product-details.jsp?id=8" class="btn-view">View Details</a>
    </div>

</div>
<%@ include file="footer.jsp" %>
</body>
</html>