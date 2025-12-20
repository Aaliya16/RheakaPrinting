<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Rheaka Design - Professional Printing</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --mongoose: #baa987;
            --steelblue: #b0c4de;
            --deep-black: #000000;
        }

        body { background-color: var(--steelblue) !important; font-family: 'Roboto', sans-serif; }

        /* Navbar Styling */
        .navbar { background-color: white !important; }
        .navbar-brand, .text-success { color: var(--mongoose) !important; font-weight: 700; }
        .nav-link { color: var(--deep-black) !important; font-weight: 500; }

        /* Hero Section Styling */
        #template-mo-zay-hero-carousel { background-color: white !important; }
        .h1 { color: var(--deep-black) !important; font-weight: 800; }
        .btn-success {
            background-color: var(--mongoose) !important;
            border: none !important;
            padding: 12px 30px;
            font-weight: bold;
        }

        /* Categories Section */
        .rounded-circle { border: 5px solid white; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        h2.h5, h5 { color: var(--deep-black) !important; font-weight: 700; }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-light shadow">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand logo h1" href="index.jsp">Rheaka Design</a>
        <div class="collapse navbar-collapse justify-content-end" id="templatemo_main_nav">
            <ul class="nav navbar-nav">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="products.jsp">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Login</a></li>
            </ul>
        </div>
    </div>
</nav>

<div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="assets/img/homepage.jpg" alt="Printing Banner">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left align-self-center">
                            <h1 class="h1"><b>Rheaka</b> Printing</h1>
                            <h3 class="h2 text-dark">Professional Design & Custom Print</h3>
                            <p class="text-muted">
                                High-quality printing services for Business Cards, Stickers, Banners, and Corporate Apparel.
                                Upload your design and we handle the rest.
                            </p>
                            <a href="products.jsp" class="btn btn-success">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<section class="container py-5">
    <div class="row text-center pt-3">
        <div class="col-lg-6 m-auto">
            <h1 class="h1">Featured Services</h1>
            <p class="text-dark">Explore our top-selling printing categories this month.</p>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-4 p-5 mt-3 text-center">
            <a href="products.jsp?id=1"><img src="assets/img/Tshirt.jpg" class="rounded-circle img-fluid"></a>
            <h5 class="mt-3 mb-3">T-shirt Printing</h5>
            <p><a href="products.jsp?id=1" class="btn btn-success">View Details</a></p>
        </div>
        <div class="col-12 col-md-4 p-5 mt-3 text-center">
            <a href="products.jsp?id=2"><img src="assets/img/apron.jpg" class="rounded-circle img-fluid"></a>
            <h2 class="h5 mt-3 mb-3">Apron Printing</h2>
            <p><a href="products.jsp?id=2" class="btn btn-success">View Details</a></p>
        </div>
        <div class="col-12 col-md-4 p-5 mt-3 text-center">
            <a href="products.jsp?id=3"><img src="assets/img/flyers.jpg" class="rounded-circle img-fluid"></a>
            <h2 class="h5 mt-3 mb-3">Flyers</h2>
            <p><a href="products.jsp?id=3" class="btn btn-success">View Details</a></p>
        </div>
    </div>
</section>

<footer class="bg-dark pt-5" id="tempaltemo_footer">
    <div class="container text-light text-center pb-4">
        <h2 class="h2 border-bottom pb-3 border-light logo" style="color: var(--mongoose) !important;">Rheaka Design</h2>
        <p>123 Arau,Perlis, Malaysia| @rheakadesign | 011-7078-7469</p>
        <div class="w-100 my-3 border-top border-light"></div>
        <p>© 2025 Rheaka Printing </p>
    </div>
</footer>

<script src="js/jquery-1.11.0.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/templatemo.js"></script>
</body>
</html>