<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Our Services - Rheaka Printing</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --mongoose: #baa987;
            --steelblue: #b0c4de; /* Warna latar belakang SteelBlue */
            --deep-black: #000000; /* Warna hitam pekat untuk tulisan & ikon */
        }

        body {
            background-color: var(--steelblue) !important;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Bahagian atas website (Header) */
        .header-section {
            text-align: center;
            padding: 50px 20px;
            background: rgba(255, 255, 255, 0.9); /* Latar belakang putih lutsinar */
            margin-bottom: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .header-section h2 {
            color: var(--deep-black) !important; /* Rheaka & Printing Services dalam HITAM */
            font-size: 2.8rem;
            margin: 0;
            font-weight: 800;
        }

        /* Container untuk semua kad produk */
        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding: 0 40px 60px 40px;
            max-width: 1300px;
            margin: auto;
        }

        /* Rekaan kad produk */
        .product-card {
            background: white;
            border-radius: 20px;
            padding: 40px 20px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-10px);
        }

        /* Warna Simbol/Ikon ditukar kepada HITAM */
        .product-card i {
            color: var(--deep-black) !important;
            margin-bottom: 20px;
        }

        .product-card h3 {
            color: var(--mongoose); /* Kekalkan Mongoose untuk Nama Produk */
            margin: 15px 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .product-card p {
            color: #555;
            font-size: 0.95rem;
            height: 40px;
            margin-bottom: 20px;
        }

        /* Butang View Details */
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

<div class="header-section">
    <h2>Rheaka Printing Services</h2>
    <p style="color: #333; font-weight: 500;">Official Rheaka Inventory - Select a service for details</p>
</div>

<div class="product-container">

    <div class="product-card">
        <i class="fas fa-box-open fa-4x"></i>
        <h3>Acrylic Clear</h3>
        <p>Premium 3mm laser-cut acrylic for high-impact displays.</p>
        <a href="product-details.jsp?id=15" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-tshirt fa-4x"></i>
        <h3>Apron Custom</h3>
        <p>Denim, Cotton & 2-Tone professional kitchen wear.</p>
        <a href="product-details.jsp?id=14" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-sign fa-4x"></i>
        <h3>Industrial Signage</h3>
        <p>Composite & High Impact boards for office or safety use.</p>
        <a href="product-details.jsp?id=16" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-address-card fa-4x"></i>
        <h3>Business Card</h3>
        <p>Premium name cards with matte or glossy lamination.</p>
        <a href="product-details.jsp?id=1" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-shirt fa-4x"></i>
        <h3>Apparel Printing</h3>
        <p>Sublimation, Sulam (Embroidery) & Silkscreen services.</p>
        <a href="product-details.jsp?id=3" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-scroll fa-4x"></i>
        <h3>Banner & Bunting</h3>
        <p>Roll-Up, X-Stand & Tripod stands for events.</p>
        <a href="product-details.jsp?id=4" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-flag fa-4x"></i>
        <h3>Flags & Backdrop</h3>
        <p>Beach Flags, Custom Bendera & Photo Backdrops.</p>
        <a href="product-details.jsp?id=17" class="btn-view">View Details</a>
    </div>

    <div class="product-card">
        <i class="fas fa-sticky-note fa-4x"></i>
        <h3>Stickers & Plaque</h3>
        <p>Waterproof Mirrorcoat & metallic plaque stickers.</p>
        <a href="product-details.jsp?id=2" class="btn-view">View Details</a>
    </div>

</div>

</body>
</html>