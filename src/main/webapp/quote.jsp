<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Get a Custom Quote - Rheaka Printing</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --mongoose: #baa987;
        }

        /* Steel Blue gradient background consistent with the site theme */
        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Container for the quote request form */
        .quote-container {
            padding-top: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        /* Header animations */
        .page-header {
            text-align: center;
            margin-bottom: 30px;
            animation: fadeInDown 0.8s ease;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-header h1 {
            font-size: 42px;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .page-header p {
            font-size: 18px;
            color: #2c3e50;
        }

        .quote-grid {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
            padding: 0 15px;
        }
        /* Central white card for form fields */
        .quote-box {
            width: 100%;
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            animation: fadeInLeft 0.8s ease;
        }

        @keyframes fadeInLeft {
            from { opacity: 0; transform: translateX(-30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .form-title {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .form-subtitle {
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .required {
            color: #e74c3c;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
            font-family: inherit;
            appearance: auto !important;
            -webkit-appearance: menulist !important;
        }

        .form-control:focus {
            outline: none;
            border-color: #4682B4;
            box-shadow: 0 0 0 3px rgba(70, 130, 180, 0.1);
        }
        /* Specialized styling for the drag-and-drop file upload area */
        .file-upload-area {
            border: 2px dashed #ccc;
            padding: 30px;
            text-align: center;
            border-radius: 10px;
            cursor: pointer;
            background: #f9f9f9;
            transition: 0.3s;
            display: block;
        }

        .file-upload-area:hover {
            background: #f0f0f0;
            border-color: #4682B4;
        }
        /* Primary action button styling */
        .btn-submit {
            display: inline-block;
            padding: 15px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: #357ABD;
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        @media (max-width: 768px) {
            .quote-box { padding: 20px; }
            .page-header h1 { font-size: 32px; }
        }
    </style>
</head>
<body>
<%@include file="header.jsp"%>

<div class="quote-container">
    <div class="page-header">
        <h1>Get a Custom Quote</h1>
        <p>Fill out the form below and we'll get back to you within 24 hours</p>
    </div>

    <div class="quote-grid">
        <div class="quote-box">
            <h2 class="form-title">Quote Information</h2>
            <p class="form-subtitle">Tell us about your project requirements</p>

            <form id="quote-form" action="submit-quote" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="quote-name">Name <span class="required">*</span></label>
                    <input type="text" id="quote-name" name="name" class="form-control" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label for="quote-email">Email Address</label>
                    <input type="email" id="quote-email" name="email" class="form-control" placeholder="your.email@example.com" required>
                </div>

                <div class="form-group">
                    <label for="quote-phone">Phone Number <span class="required">*</span></label>
                    <input type="tel" id="quote-phone" name="phone" placeholder="+60 12-345 6789" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="quote-product">Product Type <span class="required">*</span></label>
                    <select id="quote-product" name="product" class="form-control" required>
                        <option value="">-- Select a product type --</option>

                        <optgroup label="Apparel & Clothing">
                            <option value="T-Shirt Printing">T-Shirt Printing</option>
                            <option value="Jersey Printing">Jersey Printing</option>
                            <option value="Apron Printing">Apron Printing</option>
                        </optgroup>

                        <optgroup label="Corporate & Gifts">
                            <option value="Mug Sublimation">Mug Sublimation</option>
                            <option value="Trophy Engraving">Trophy Engraving</option>
                            <option value="Acrylic Products">Acrylic Products</option>
                            <option value="Nametag / Medal">Nametag / Medal</option>
                        </optgroup>

                        <optgroup label="Marketing Materials">
                            <option value="Banner / Bunting">Banner / Bunting</option>
                            <option value="Certificate Printing">Certificate Printing</option>
                            <option value="Business Card">Business Card</option>
                        </optgroup>

                        <optgroup label="Others">
                            <option value="Custom Design Service">Custom Design Service</option>
                            <option value="Other">Other (Please specify in notes)</option>
                        </optgroup>
                    </select>
                </div>

                <div class="form-group">
                    <label for="quote-quantity">Quantity <span class="required">*</span></label>
                    <input type="number" id="quote-quantity" name="quantity" min="1" placeholder="e.g., 50" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="quote-note">Note</label>
                    <textarea id="quote-note" name="note" rows="4" class="form-control" placeholder="Tell us about your project requirements..."></textarea>
                </div>

                <div class="form-group">
                    <label>Upload Design File (Optional)</label>
                    <label for="quote-file" class="file-upload-area">
                        <input type="file" id="quote-file" name="file" accept="image/*,.pdf" style="display:none;" onchange="showFileName()">
                        <p style="margin:0; font-weight:bold;">Click to upload or drag and drop</p>
                        <small style="color:#888;">Supports: JPG, PNG, PDF (Max 10MB)</small>
                        <p id="file-name-display" style="color: #4682B4; margin-top: 10px; font-weight: bold;"></p>
                    </label>
                </div>

                <button type="button" class="btn-submit" onclick="handleQuoteSubmit()">Submit Request</button>
            </form>
        </div>
    </div>
</div>

<script>
    function handleQuoteSubmit() {
        <%
            User auth = (User) session.getAttribute("auth");
            if (auth == null) auth = (User) session.getAttribute("currentUser");
        %>
        var isLoggedIn = <%= (auth != null) ? "true" : "false" %>;

        // 1. Check Login Dahulu
        if (!isLoggedIn) {
            alert("⚠️ MAAF! Sila LOGIN dahulu untuk meminta sebut harga (quote).");
            window.location.href = "login.jsp";
            return;
        }

        // 2. Jika sudah login, check validation borang secara manual
        var form = document.getElementById('quote-form');
        if (form.checkValidity()) {
            form.submit(); // Hantar borang jika semua field 'required' sudah diisi
        } else {
            form.reportValidity(); // Tunjuk amaran 'Please fill out this field' jika kosong
        }
    }
</script>

<script>
    function showFileName() {
        var input = document.getElementById('quote-file');
        var display = document.getElementById('file-name-display');
        if (input.files && input.files[0]) {
            display.innerText = "Selected: " + input.files[0].name;
        }
    }
</script>

<%@include file="footer.jsp"%>
</body>
</html>
