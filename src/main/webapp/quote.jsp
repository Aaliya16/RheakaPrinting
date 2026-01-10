<%--
  Created by IntelliJ IDEA.
  User: MSI MODERN 15
  Date: 19/12/2025
  Time: 8:01 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rheaka Design Services</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            /* Gradient biru yang Mia mahu */
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);

            /* Pastikan gradient memenuhi seluruh skrin */
            min-height: 100vh;
            margin: 0;
            font-family: 'Roboto', sans-serif;
        }

        /* Ini kotak putih untuk form (Sama style macam Cart) */
        .quote-box {
            background-color: white;
            width: 90%;
            max-width: 600px;           /* Form tak perlu lebar sangat, 600px dah cantik */
            margin: 50px auto;          /* Duduk tengah (Center) */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .quote-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .quote-title h2 { margin: 0; font-size: 28px; }
        .quote-title p { color: #666; margin-top: 5px; }

        /* Style untuk setiap row input */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #444;
        }

        /* Style untuk Input, Select, Textarea */
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box; /* Supaya padding tak kacau width */
            font-family: inherit;
        }

        .form-control:focus {
            border-color: #baa987; /* Warna tema bila user klik */
            outline: none;
        }

        /* Custom File Upload Area (Kotak Putus-Putus) */
        .file-upload-area {
            border: 2px dashed #ccc;
            padding: 30px;
            text-align: center;
            border-radius: 8px;
            cursor: pointer;
            background: #f9f9f9;
            transition: 0.3s;
        }

        .file-upload-area:hover {
            background: #f0f0f0;
            border-color: #baa987;
        }

        /* Butang Submit */
        .btn-submit {
            background-color: #baa987; /* Warna Mongoose */
            color: white;
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 30px; /* Butang bulat sikit */
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background-color: #a49374;
        }
    </style>
</head>
<body>
<%@include file="header.jsp"%>

<div class="quote-box">

    <div class="quote-title">
        <h2>Get a Custom Quote</h2>
        <p>Fill out the form below and we'll get back to you within 24 hours</p>
    </div>

    <form id="quote-form" action="submit-quote" method="post" enctype="multipart/form-data">

        <div class="form-group">
            <label for="quote-name">Name</label>
            <input type="text" id="quote-name" name="name" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="quote-email">Email</label>
            <input type="email" id="quote-email" name="email" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="quote-phone">Phone Number</label>
            <input type="tel" id="quote-phone" name="phone" placeholder="+60 12-345 6789" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="quote-product">Product Type</label>
            <select id="quote-product" name="product" class="form-control" required>
                <option value="">Select a product type</option>
                <option value="T-Shirt Printing">T-Shirt Printing</option>
                <option value="Apron Printing">Apron Printing</option>
                <option value="Mug Sublimation">Mug Sublimation</option>
                <option value="Trophy Engraving">Trophy Engraving</option>
                <option value="Certificate Printing">Certificate Printing</option>
                <option value="Banner Printing">Banner Printing</option>
                <option value="Custom Design Service">Custom Design Service</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div class="form-group">
            <label for="quote-quantity">Quantity</label>
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
                <p id="file-name-display" style="color: #baa987; margin-top: 10px; font-weight: bold;"></p>
            </label>
        </div>

        <button type="submit" class="btn-submit">Submit Request</button>
    </form>
</div>

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
