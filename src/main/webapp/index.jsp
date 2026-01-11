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
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #b0c4de;
            overflow-x: hidden;
        }

        /* Hero Section - Lightsteelblue Gradient */
        .hero-section {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            color: white;
            text-align: center;
            padding: 80px 20px;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.1" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            background-position: bottom;
            opacity: 0.3;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 900px;
            margin: 0 auto;
        }

        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            animation: fadeInUp 0.8s ease;
        }

        .hero-section p {
            font-size: 1.4rem;
            margin-bottom: 40px;
            opacity: 0.95;
            animation: fadeInUp 0.8s ease 0.2s backwards;
        }

        .hero-btn {
            display: inline-block;
            padding: 18px 50px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            animation: fadeInUp 0.8s ease 0.4s backwards;
        }

        .hero-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            background: #f8f9fa;
        }

        /* Banner Image Section */
        .banner-section {
            padding: 40px 20px;
            background: white;
        }

        .banner-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        }

        .banner-wrapper img {
            width: 100%;
            height: auto;
            display: block;
        }

        /* Carousel Section - UPDATED */
        .carousel-section {
            padding: 80px 20px;
            background: linear-gradient(135deg, #b0c4de 0%, #87CEEB 100%);
        }

        .section-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-header h2 {
            font-size: 3rem;
            color: white;
            margin-bottom: 15px;
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .section-header p {
            font-size: 1.3rem;
            color: rgba(255,255,255,0.9);
        }

        .carousel-container {
            max-width: 1300px;
            margin: 0 auto;
            position: relative;
            padding: 0 20px;
        }

        .carousel-wrapper {
            overflow: hidden;
            border-radius: 20px;
        }

        .carousel-track {
            display: flex;
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            gap: 25px;
        }

        .category-card {
            min-width: calc(25% - 18.75px); /* Exactly 4 cards visible */
            background: white;
            border-radius: 20px;
            padding: 40px 25px;
            text-align: center;
            cursor: pointer;
            transition: all 0.4s ease;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            flex-shrink: 0;
        }

        .category-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
        }

        .category-card .image-wrapper {
            width: 100px;
            height: 100px;
            margin: 0 auto 25px;
            background: linear-gradient(135deg, #4682B4 0%, #87CEEB 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(70, 130, 180, 0.3);
            transition: all 0.4s ease;
        }

        .category-card:hover .image-wrapper {
            transform: scale(1.1);
            box-shadow: 0 12px 30px rgba(70, 130, 180, 0.5);
        }

        .category-card .image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .category-card i {
            font-size: 4rem;
            color: #4682B4;
            margin-bottom: 25px;
            transition: all 0.3s ease;
        }

        .category-card:hover i {
            transform: rotateY(360deg) scale(1.1);
        }

        .category-card h3 {
            font-size: 1.5rem;
            margin-bottom: 12px;
            color: #333;
            font-weight: 700;
        }

        .category-card p {
            font-size: 0.95rem;
            color: #666;
            line-height: 1.6;
        }

        .carousel-btn {
            display: none;
        }

        .carousel-btn:hover {
            background: #4682B4;
            color: white;
            transform: translateY(-50%) scale(1.15);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .carousel-btn i {
            font-size: 1.5rem;
        }

        .carousel-btn.prev {
            left: 0;
        }

        .carousel-btn.next {
            right: 0;
        }

        /* Carousel Dots Navigation */
        .carousel-dots {
            display: none;
        }

        .see-all-btn {
            display: inline-block;
            margin: 40px auto 0;
            padding: 15px 50px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
        }

        .see-all-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.25);
            background: #f8f9fa;
        }

        .see-all-container {
            text-align: center;
            margin-top: 50px;
        }

        /* Featured Services */
        .featured-section {
            padding: 80px 20px;
            background: white;
        }

        .featured-section .section-header h2 {
            color: #333;
            text-shadow: none;
        }

        .featured-section .section-header p {
            color: #666;
        }

        .services-grid {
            max-width: 1300px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 35px;
        }

        .service-card {
            background: linear-gradient(135deg, #f8f9fa 0%, white 100%);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            transition: all 0.4s ease;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 2px solid transparent;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
            border-color: #4682B4;
        }

        .service-icon {
            width: 90px;
            height: 90px;
            margin: 0 auto 25px;
            background: linear-gradient(135deg, #4682B4 0%, #87CEEB 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            transition: all 0.4s ease;
            overflow: hidden;
        }

        .service-icon img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .service-card:hover .service-icon {
            transform: rotateY(360deg) scale(1.1);
        }

        .service-card h3 {
            font-size: 1.6rem;
            color: #333;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .service-card p {
            font-size: 1rem;
            color: #666;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .view-btn {
            display: inline-block;
            padding: 12px 35px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .view-btn:hover {
            background: #357ABD;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        /* How It Works */
        .how-it-works {
            padding: 80px 20px;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            color: white;
        }

        .steps-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 40px;
        }

        .step-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 45px 35px;
            text-align: center;
            border: 2px solid rgba(255,255,255,0.3);
            transition: all 0.4s ease;
        }

        .step-card:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .step-number {
            width: 70px;
            height: 70px;
            background: white;
            color: #4682B4;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 800;
            margin: 0 auto 25px;
        }

        .step-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
        }

        .step-card h3 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .step-card p {
            font-size: 1.05rem;
            line-height: 1.7;
            opacity: 0.95;
        }

        /* Why Choose Us */
        .why-choose-us {
            padding: 80px 20px;
            background: white;
        }

        .why-choose-us .section-header h2 {
            color: #333;
            text-shadow: none;
        }

        .why-choose-us .section-header p {
            color: #666;
        }

        .benefits-grid {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 35px;
        }

        .benefit-card {
            display: flex;
            align-items: flex-start;
            gap: 25px;
            padding: 35px;
            background: #f8f9fa;
            border-radius: 20px;
            transition: all 0.4s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .benefit-card:hover {
            background: linear-gradient(135deg, #4682B4 0%, #87CEEB 100%);
            color: white;
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(70, 130, 180, 0.3);
        }

        .benefit-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #4682B4 0%, #87CEEB 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            flex-shrink: 0;
            transition: all 0.3s ease;
        }

        .benefit-card:hover .benefit-icon {
            background: white;
            color: #4682B4;
            transform: rotateY(360deg);
        }

        .benefit-content h3 {
            font-size: 1.4rem;
            margin-bottom: 12px;
            color: #333;
            font-weight: 700;
        }

        .benefit-card:hover .benefit-content h3 {
            color: white;
        }

        .benefit-content p {
            font-size: 1rem;
            color: #666;
            line-height: 1.7;
        }

        .benefit-card:hover .benefit-content p {
            color: rgba(255,255,255,0.95);
        }

        /* CTA Section */
        .cta-section {
            padding: 80px 20px;
            background: linear-gradient(135deg, #b0c4de 0%, #4682B4 100%);
            text-align: center;
            color: white;
        }

        .cta-section h2 {
            font-size: 3rem;
            margin-bottom: 20px;
            font-weight: 800;
        }

        .cta-section p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            opacity: 0.95;
        }

        .cta-btn {
            display: inline-block;
            padding: 18px 55px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .cta-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .category-card {
                min-width: calc(33.333% - 16.67px);
            }
        }

        @media (max-width: 900px) {
            .category-card {
                min-width: calc(50% - 12.5px);
            }
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.2rem;
            }

            .section-header h2 {
                font-size: 2rem;
            }

            .carousel-container {
                padding: 0 50px;
            }

            .category-card {
                min-width: 100%;
            }

            .services-grid,
            .steps-container,
            .benefits-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<!-- Hero Section -->
<section class="hero-section">
    <div class="hero-content">
        <h1>Professional Printing & Custom Design Services</h1>
        <p>Transform your ideas into reality with our premium printing solutions. Fast, reliable, and affordable.</p>
        <a href="products.jsp" class="hero-btn">Get Started Today</a>
    </div>
</section>

<!-- Banner Image -->
<section class="banner-section">
    <div class="banner-wrapper">
        <img src="assets/img/HOMEPAGE_RHEAKA.jpg" alt="Rheaka Design Banner">
    </div>
</section>

<!-- Carousel Section -->
<section class="carousel-section">
    <div class="section-header">
        <h2>Explore Our Services</h2>
        <p>Browse through our wide range of printing solutions</p>
    </div>

    <div class="carousel-container">
        <button class="carousel-btn prev" onclick="moveCarousel(-1)">
            <i class="fas fa-chevron-left"></i>
        </button>

        <div class="carousel-wrapper">
            <div class="carousel-track" id="carouselTrack">
                <!-- Product 1: Acrylic Clear -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=1'">
                    <div class="image-wrapper">
                        <img src="assets/img/acrylic-sticker.jpg" alt="Acrylic Clear">
                    </div>
                    <h3>Acrylic Clear</h3>
                    <p>Premium quality acrylic printing</p>
                </div>

                <!-- Product 2: Apron Custom -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=2'">
                    <div class="image-wrapper">
                        <img src="assets/img/apron-sticker.png" alt="Apron Custom">
                    </div>
                    <h3>Apron Custom</h3>
                    <p>Personalized aprons for business</p>
                </div>

                <!-- Product 3: Industrial Signage -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=3'">
                    <div class="image-wrapper">
                        <img src="assets/img/signage.jpg" alt="Industrial Signage">
                    </div>
                    <h3>Industrial Signage</h3>
                    <p>Durable signs for your company</p>
                </div>

                <!-- Product 4: Business Card -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=4'">
                    <div class="image-wrapper">
                        <img src="assets/img/business-sticker.jpg" alt="Business Card">
                    </div>
                    <h3>Business Card</h3>
                    <p>Professional business cards</p>
                </div>

                <!-- Product 5: Apparel Printing -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=5'">
                    <div class="image-wrapper">
                        <img src="assets/img/apparel.jpg" alt="Apparel Printing">
                    </div>
                    <h3>Apparel Printing</h3>
                    <p>Custom t-shirts and clothing</p>
                </div>

                <!-- Product 6: Banner & Bunting -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=6'">
                    <div class="image-wrapper">
                        <img src="assets/img/banner-sticker.jpg" alt="Banner & Bunting">
                    </div>
                    <h3>Banner & Bunting</h3>
                    <p>Eye-catching banners for events</p>
                </div>

                <!-- Product 7: Flags & Backdrop -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=7'">
                    <div class="image-wrapper">
                        <img src="assets/img/flag-printing.jpg" alt="Flags & Backdrop">
                    </div>
                    <h3>Flags & Backdrop</h3>
                    <p>Custom flags and backdrops</p>
                </div>

                <!-- Product 8: Stickers & Plaque -->
                <div class="category-card" onclick="window.location.href='product-details.jsp?id=8'">
                    <div class="image-wrapper">
                        <img src="assets/img/plaque.jpg" alt="Stickers & Plaque">
                    </div>
                    <h3>Stickers & Plaque</h3>
                    <p>High-quality stickers and plaques</p>
                </div>
            </div>
        </div>

        <button class="carousel-btn next" onclick="moveCarousel(1)">
            <i class="fas fa-chevron-right"></i>
        </button>
    </div>

    <!-- See All Services Button -->
    <div class="see-all-container">
        <a href="products.jsp" class="see-all-btn">See All Services</a>
    </div>
</section>

<!-- Featured Services -->
<section class="featured-section">
    <div class="section-header">
        <h2>Our Featured Services</h2>
        <p>Professional printing solutions tailored to your needs</p>
    </div>

    <div class="services-grid">
        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/acrylic-sticker.jpg" alt="Acrylic Clear">
            </div>
            <h3>Acrylic Clear</h3>
            <p>Crystal-clear acrylic prints perfect for displaying photos, signage, and artwork.</p>
            <a href="product-details.jsp?id=1" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/apron-sticker.png" alt="Apron Custom">
            </div>
            <h3>Apron Custom</h3>
            <p>Customized aprons for restaurants, cafes, and businesses with vibrant printing.</p>
            <a href="product-details.jsp?id=2" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/signage.jpg" alt="Industrial Signage">
            </div>
            <h3>Industrial Signage</h3>
            <p>Weather-resistant signage built to last in harsh industrial conditions.</p>
            <a href="product-details.jsp?id=3" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/business-sticker.jpg" alt="Business Card">
            </div>
            <h3>Business Card</h3>
            <p>Make a lasting impression with premium business cards in multiple finishes.</p>
            <a href="product-details.jsp?id=4" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/apparel.jpg" alt="Apparel Printing">
            </div>
            <h3>Apparel Printing</h3>
            <p>Custom t-shirt printing for teams, events, and businesses with DTG technology.</p>
            <a href="product-details.jsp?id=5" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/banner-sticker.jpg" alt="Banner & Bunting">
            </div>
            <h3>Banner & Bunting</h3>
            <p>Large-format banners perfect for events, promotions, and grand openings.</p>
            <a href="product-details.jsp?id=6" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/flag-printing.jpg" alt="Flags & Backdrop">
            </div>
            <h3>Flags & Backdrop</h3>
            <p>Custom flags and backdrops for exhibitions and special events.</p>
            <a href="product-details.jsp?id=7" class="view-btn">View Details</a>
        </div>

        <div class="service-card">
            <div class="service-icon">
                <img src="assets/img/plaque.jpg" alt="Stickers & Plaque">
            </div>
            <h3>Stickers & Plaque</h3>
            <p>High-quality stickers and commemorative plaques for branding and awards.</p>
            <a href="product-details.jsp?id=8" class="view-btn">View Details</a>
        </div>
    </div>
</section>

<!-- How It Works -->
<section class="how-it-works">
    <div class="section-header">
        <h2>How It Works</h2>
        <p>Simple process from design to delivery</p>
    </div>

    <div class="steps-container">
        <div class="step-card">
            <div class="step-number">1</div>
            <i class="fas fa-cloud-upload-alt step-icon"></i>
            <h3>Upload Your Design</h3>
            <p>Upload your artwork or choose from our templates. Our design team is here to help.</p>
        </div>

        <div class="step-card">
            <div class="step-number">2</div>
            <i class="fas fa-sliders-h step-icon"></i>
            <h3>Customize Options</h3>
            <p>Select your preferred size, material, quantity, and finishing options.</p>
        </div>

        <div class="step-card">
            <div class="step-number">3</div>
            <i class="fas fa-truck step-icon"></i>
            <h3>We Print & Deliver</h3>
            <p>We'll print your order with precision and deliver it right to your doorstep.</p>
        </div>
    </div>
</section>

<!-- Why Choose Us -->
<section class="why-choose-us">
    <div class="section-header">
        <h2>Why Choose Rheaka Design?</h2>
        <p>We're committed to delivering excellence in every project</p>
    </div>

    <div class="benefits-grid">
        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fas fa-clock"></i>
            </div>
            <div class="benefit-content">
                <h3>Fast Turnaround</h3>
                <p>Quick production times without compromising quality. Most orders ready within 3-5 business days.</p>
            </div>
        </div>

        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fas fa-palette"></i>
            </div>
            <div class="benefit-content">
                <h3>Expert Design Team</h3>
                <p>Professional designers ready to bring your vision to life with creative solutions.</p>
            </div>
        </div>

        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fas fa-certificate"></i>
            </div>
            <div class="benefit-content">
                <h3>Premium Quality</h3>
                <p>We use only the best materials and latest printing technology for exceptional results.</p>
            </div>
        </div>

        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fas fa-headset"></i>
            </div>
            <div class="benefit-content">
                <h3>24/7 Support</h3>
                <p>Our customer service team is always available to answer questions and provide assistance.</p>
            </div>
        </div>

        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fas fa-money-bill-wave"></i>
            </div>
            <div class="benefit-content">
                <h3>Competitive Pricing</h3>
                <p>Affordable rates without hidden fees. Bulk discounts available for larger orders.</p>
            </div>
        </div>

        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fas fa-shield-alt"></i>
            </div>
            <div class="benefit-content">
                <h3>Satisfaction Guaranteed</h3>
                <p>100% satisfaction guarantee. If you're not happy, we'll make it right.</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <h2>Ready to Bring Your Ideas to Life?</h2>
    <p>Get a free personalized quote for your printing project today!</p>
    <a href="quote.jsp" class="cta-btn">Get Your Free Quote</a>
</section>

<%@ include file="footer.jsp" %>

<script>
    let currentIndex = 0;
    const track = document.getElementById('carouselTrack');
    const cards = document.querySelectorAll('.category-card');
    const totalCards = cards.length;
    const dotsContainer = document.getElementById('carouselDots');

    // Get number of cards to show based on screen size
    function getCardsToShow() {
        if (window.innerWidth >= 1200) return 4;
        if (window.innerWidth >= 900) return 3;
        if (window.innerWidth >= 600) return 2;
        return 1;
    }

    // Calculate number of pages
    function getNumPages() {
        const cardsToShow = getCardsToShow();
        return Math.ceil(totalCards / cardsToShow);
    }

    // Create dots for navigation
    function createDots() {
        const numPages = getNumPages();
        dotsContainer.innerHTML = '';

        for (let i = 0; i < numPages; i++) {
            const dot = document.createElement('div');
            dot.className = 'dot';
            if (i === 0) dot.classList.add('active');
            dot.onclick = () => goToPage(i);
            dotsContainer.appendChild(dot);
        }
    }

    // Update active dot
    function updateDots() {
        const dots = document.querySelectorAll('.dot');
        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === currentIndex);
        });
    }

    // Go to specific page
    function goToPage(pageIndex) {
        currentIndex = pageIndex;
        updateCarouselPosition();
        updateDots();
    }

    // Move carousel by one page
    function moveCarousel(direction) {
        const numPages = getNumPages();

        // Move by ONE PAGE (not one card)
        currentIndex += direction;

        // Loop around
        if (currentIndex < 0) {
            currentIndex = numPages - 1;
        } else if (currentIndex >= numPages) {
            currentIndex = 0;
        }

        updateCarouselPosition();
        updateDots();
    }

    // Update carousel position
    function updateCarouselPosition() {
        const cardsToShow = getCardsToShow();
        const cardWidth = cards[0].offsetWidth;
        const gap = 25;

        // Move by FULL PAGE (cardsToShow * card width)
        const offset = currentIndex * cardsToShow * (cardWidth + gap);

        track.style.transform = `translateX(-${offset}px)`;
    }

    // Auto-play carousel
    let autoPlayInterval = setInterval(() => {
        moveCarousel(1);
    }, 5000);

    // Pause auto-play on hover
    const carouselContainer = document.querySelector('.carousel-container');
    carouselContainer.addEventListener('mouseenter', () => {
        clearInterval(autoPlayInterval);
    });

    carouselContainer.addEventListener('mouseleave', () => {
        autoPlayInterval = setInterval(() => {
            moveCarousel(1);
        }, 5000);
    });

    // Handle window resize
    let resizeTimeout;
    window.addEventListener('resize', () => {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(() => {
            currentIndex = 0;
            track.style.transform = 'translateX(0)';
            createDots();
            updateDots();
        }, 250);
    });

    // Initialize dots
    createDots();
    updateDots();
</script>

</body>
</html>


