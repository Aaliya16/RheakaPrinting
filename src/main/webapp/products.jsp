<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Our Services - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Magenta colour */
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
        <i class="fas fa-address-card fa-3x" style="color: #555;"></i>
        <h3>Business Card</h3>
        <p>High quality name cards</p>
        <p><strong>Starts from RM 10.00</strong></p>
        <a href="product-details.jsp?id=1" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-sticky-note fa-3x" style="color: #555;"></i>
        <h3>Stickers</h3>
        <p>Custom shape cutting</p>
        <p><strong>Starts from RM 5.00</strong></p>
        <a href="product-details.jsp?id=2" class="btn-view">View Details</a>
    </div>

        <div class="product-card">
            <i class="fas fa-address-card fa-3x" style="color: #555;"></i>
            <h3>T-shirt Printing</h3>
            <p>High quality Tshirt</p>
            <p><strong>Starts from RM 30.00</strong></p>
            <a href="product-details.jsp?id=1" class="btn-view">View Details</a>
        </div>
</div>

</body>
</html>