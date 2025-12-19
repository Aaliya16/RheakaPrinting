<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Our Services - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>

        :root { --mongoose: #baa987; }

        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 40px;
        }

        .product-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .product-card:hover { transform: translateY(-5px); }

        .product-card h3 { color: var(--mongoose); margin: 10px 0; }

        .btn-view {
            background: var(--mongoose);
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 25px;
            display: inline-block;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div style="text-align: center; padding: 20px;">
    <h2>Our Printing Services</h2>
    <p>Select a service to see dynamic pricing</p>
</div>

<div class="product-container">
    <div class="product-card">
        <i class="fas fa-address-card fa-3x"></i>
        <h3>Business Card</h3>
        <p>Premium name cards</p>
        <a href="product-details.jsp?id=1" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-sticky-note fa-3x"></i>
        <h3>Stickers</h3>
        <p>Custom shape & sizes</p>
        <a href="product-details.jsp?id=2" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-tshirt fa-3x"></i>
        <h3>T-Shirt Printing</h3>
        <p>Custom design apparel</p>
        <a href="product-details.jsp?id=3" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-scroll fa-3x"></i>
        <h3>Banner</h3>
        <p>Large format printing</p>
        <a href="product-details.jsp?id=4" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-stamp fa-3x"></i>
        <h3>Rubber Stamp</h3>
        <p>Self-inking stamps</p>
        <a href="product-details.jsp?id=5" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-id-badge fa-3x"></i>
        <h3>Name Tag</h3>
        <p>Engraved or printed</p>
        <a href="product-details.jsp?id=6" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-flag fa-3x"></i>
        <h3>Banner Bunting</h3>
        <p>Events & promotion</p>
        <a href="product-details.jsp?id=7" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-user-tie fa-3x"></i>
        <h3>Corporate T-Shirt</h3>
        <p>Formal staff uniform</p>
        <a href="product-details.jsp?id=8" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-envelope-open-text fa-3x"></i>
        <h3>Sampul Raya</h3>
        <p>Exclusive festive packets</p>
        <a href="product-details.jsp?id=9" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-book-open fa-3x"></i>
        <h3>Brochure</h3>
        <p>Informative marketing materials</p>
        <a href="product-details.jsp?id=10" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-certificate fa-3x"></i>
        <h3>Certificate Printing</h3>
        <p>High grade paper finish</p>
        <a href="product-details.jsp?id=11" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-award fa-3x"></i>
        <h3>Plaque Sticker</h3>
        <p>Metallic & clear stickers</p>
        <a href="product-details.jsp?id=12" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-utensils fa-3x"></i>
        <h3>Menu</h3>
        <p>Restaurant menu books</p>
        <a href="product-details.jsp?id=13" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-shirt fa-3x"></i>
        <h3>Apron</h3>
        <p>Custom kitchen wear</p>
        <a href="product-details.jsp?id=14" class="btn-view">View Details</a>
    </div>
</div>
</div>

</body>
</html>