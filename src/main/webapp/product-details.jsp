<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%
    // Get product ID from URL parameter (e.g., product-details.jsp?id=1)
    String id = request.getParameter("id");

    // Default values if no ID is found
    String pName = "Printing Service";
    String pDesc = "High-quality custom printing solutions.";
    String pImage = "product_single_10.jpg";
    String pCategory = ""; // Kita tambah category untuk logic include file nanti

    // 2. DATABASE CONNECTION & QUERY
    if (id != null) {
        try {
            Connection conn = DbConnection.getConnection();
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                pName = rs.getString("name");
                pDesc = rs.getString("description");
                pImage = rs.getString("image");
                pCategory = rs.getString("category"); // Penting untuk tentukan file mana nak load
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // Product Mapping: Assign Title, Description, and Image based on ID
    if (id != null) {
        switch (id) {
            case "1":
                pName = "Acrylic Clear";
                pDesc = "Premium 3mm laser-cut acrylic.";
                pImage = "Arcylic-03-768x768.jpg"; // Filename matches your specific assets folder
                break;
            case "2":
                pName = "Apron Custom";
                pDesc = "Professional kitchen wear.";
                pImage = "apron.jpg";
                break;
            case "3":
                pName = "Industrial Signage";
                pDesc = "Composite and safety boards.";
                pImage = "page-industry-signs-construction.jpg";
                break;
            case "4":
                pName = "Business Card";
                pDesc = "Premium name cards.";
                pImage = "business_cards.jpg";
                break;
            case "5":
                pName = "Apparel Printing";
                pDesc = "Custom T-Shirts (XS - 7XL).";
                pImage = "Tshirt.jpg";
                break;
            case "6":
                pName = "Banner & Bunting";
                pDesc = "Large format event printing.";
                pImage = "Banner.jpg";
                break;
            case "7":
                pName = "Flags & Backdrop";
                pDesc = "Custom flags and backdrops.";
                pImage = "Beach_Flags.jpg";
                break;
            case "8":
                pName = "Stickers & Plaque";
                pDesc = "Vinyl stickers and trophies.";
                pImage = "Custom-Sheet-Stickers.jpg";
                break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rheaka Design - <%= pName %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Color Variables for Consistency */
        :root { --mongoose: #baa987; --steelblue: #b0c4de; }

        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Card and UI Styling */
        .card {
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: none;
        }

        .label-black {
            color: #000;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.8rem;
            margin-top: 15px;
            display: block;
        }

        /* Price display box */
        .price-box {
            font-size: 26px;
            font-weight: bold;
            color: #4682B4;
            margin: 20px 0;
            padding: 15px;
            background: #fff;
            border: 2px dashed #4682B4;
            text-align: center;
            border-radius: 10px;
        }

        .btn-add {
            background: #4682B4; /* Steel blue - matches View Details */
            color: white;
            border: none;
            width: 100%;
            padding: 15px;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-add:hover {
            background: #357ABD; /* Darker blue on hover */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        .product-img {
            max-width: 100%;
            height: auto;
            border-radius: 15px;
        }

        /* Force the custom dropdown to be visible over Bootstrap defaults */
        .dropdown:hover .dropdown-menu {
            display: block !important;
            opacity: 1 !important;
            visibility: visible !important;
            transform: translateY(0) !important;
        }

        /* Ensure the navbar remains the top-most element on this specific page */
        .navbar {
            z-index: 99999 !important;
        }

        .dropdown-menu {
            z-index: 100000 !important;
        }
    </style>
</head>

<body>
<%@ include file="header.jsp" %>

<section class="container py-5">
    <div class="row">
        <div class="col-lg-5">
            <div class="card p-3 text-center">
                <img src="assets/img/<%= pImage %>" class="product-img" alt="<%= pName %>">
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4">
                <h1 class="h2 text-dark"><%= pName %></h1>
                <p class="text-muted"><%= pDesc %></p>
                <hr>

                <form action="add-to-cart" method="post" id="addToCartForm" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="variation_name" id="hiddenVariationName" value="">
                    <input type="hidden" name="addon_name" id="hiddenAddonName" value="">
                    <input type="hidden" name="price" id="hiddenPrice" value="0.00">

                    <div class="options-panel">
                        <%
                            // Logic to determine which dynamic option file to load based on Product ID
                            String sectionFile = "default_options.jsp";

                            if (id != null) {
                                switch (id) {
                                    case "1":
                                        sectionFile = "acrylic.jsp";
                                        break;
                                    case "2":
                                        sectionFile = "apron.jsp";
                                        break;
                                    case "3":
                                        sectionFile = "signage.jsp";
                                        break;
                                    case "4":
                                        sectionFile = "business_card.jsp";
                                        break;
                                    case "5":
                                        sectionFile = "apparel.jsp";
                                        break;
                                    case "6":
                                        sectionFile = "banner.jsp";
                                        break;
                                    case "7":
                                        sectionFile = "flags.jsp";
                                        break;
                                    case "8":
                                        sectionFile = "stickers.jsp";
                                        break;
                                    default:
                                        // Kalau ID baru masuk (contoh ID 9), dia akan load default
                                        sectionFile = "default_options.jsp";
                                        break;
                                }
                            }
                        %>
                        <jsp:include page="<%= \"sections/\" + sectionFile %>" />

                        <hr>

                        <label class="label-black">Upload Design (Optional)</label>
                        <input type="file" class="form-control" id="design_file" name="design_image">

                        <div class="mt-3">
                            <label class="label-black">Quantity</label>
                            <input type="number" class="form-control" name="quantity" id="quantity" value="1" min="1">
                        </div>

                        <div class="price-box">
                            Total: RM <span id="totalPrice">0.00</span>
                        </div>
                        <input type="hidden" id="loginStatus" value="<%= session.getAttribute("currentUser") != null %>">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    // Fungsi ini akan jalan bila user tukar pilihan
    function updateHiddenInputs() {
        // 1. Dapatkan element dropdown
        var baseSelect = document.getElementById("base_item");
        var addonSelect = document.getElementById("addon_service");

        // 2. Dapatkan TEKS pilihan (Contoh: "Banner 2' x 1'")
        // Kalau tak buat ni, dia akan hantar harga (6.00) je
        if (baseSelect) {
            var textVariation = baseSelect.options[baseSelect.selectedIndex].text;
            // MASUKKAN KE DALAM HIDDEN INPUT (Ikut ID dalam screenshot awak)
            document.getElementById("hiddenVariationName").value = textVariation;
        }

        if (addonSelect) {
            var textAddon = addonSelect.options[addonSelect.selectedIndex].text;
            // MASUKKAN KE DALAM HIDDEN INPUT (Ikut ID dalam screenshot awak)
            document.getElementById("hiddenAddonName").value = textAddon;
        }
    }

    // Jalankan script ini bila dropdown berubah
    var drop1 = document.getElementById("base_item");
    var drop2 = document.getElementById("addon_service");

    if(drop1) drop1.addEventListener("change", updateHiddenInputs);
    if(drop2) drop2.addEventListener("change", updateHiddenInputs);

    // Jalankan sekali masa page baru load (supaya default value masuk)
    window.addEventListener("load", updateHiddenInputs);
</script>
<script src="js/priceCalculator.js"></script>

<%@ include file="footer.jsp" %>
<section class="container py-5">
</section>
</body>
</html>
