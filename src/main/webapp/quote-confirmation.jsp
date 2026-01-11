<%--
    File: quote-confirmation.jsp
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve submitted data from the session to display in the summary
    String quoteName = (String) session.getAttribute("quote_name");
    String quoteEmail = (String) session.getAttribute("quote_email");
    String quoteProduct = (String) session.getAttribute("quote_product");
    Integer quoteQuantity = (Integer) session.getAttribute("quote_quantity");

    // Generate a unique reference number using the current timestamp
    String referenceNumber = "QT" + System.currentTimeMillis();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quote Submitted - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>

        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            margin: 0;
        }

        .confirmation-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            width: 90%;
        }

        .confirmation-card {
            background: #fff;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            text-align: center;
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: #4CAF50;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: scaleIn 0.5s ease-out;
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }

        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }

        .success-icon svg {
            width: 50px;
            height: 50px;
            stroke: white;
            stroke-width: 3;
            fill: none;
        }

        h1 {
            color: #333;
            margin-bottom: 15px;
            font-size: 32px;
            font-weight: 700;
        }

        .subtitle {
            color: #666;
            font-size: 16px;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .reference-box {
            background: #4682B4;
            color: white;
            padding: 15px 30px;
            border-radius: 25px;
            display: inline-block;
            margin: 20px 0;
            font-weight: bold;
            font-size: 18px;
            box-shadow: 0 4px 10px rgba(70, 130, 180, 0.3);
        }

        .quote-details {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 12px;
            margin: 30px 0;
            text-align: left;
            border: 1px solid #eee;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #666;
            font-weight: 500;
        }

        .detail-value {
            color: #333;
            font-weight: 600;
        }

        .info-box {
            background: #e3f2fd;
            border-left: 5px solid #4682B4;
            padding: 20px;
            margin: 30px 0;
            border-radius: 8px;
            text-align: left;
        }

        .info-box h3 {
            color: #1976D2;
            margin: 0 0 10px 0;
            font-size: 18px;
        }

        .info-box p {
            margin: 0;
            color: #1976D2;
            line-height: 1.6;
        }

        .timeline {
            margin: 40px 0;
            text-align: left;
        }

        .timeline h3 {
            color: #333;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 700;
        }

        .timeline-step {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            border: 1px solid #eee;
        }

        .step-number {
            width: 35px;
            height: 35px;
            background: #4682B4;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .step-content h4 {
            margin: 0 0 3px 0;
            color: #333;
            font-size: 16px;
        }

        .step-content p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }

        .btn-blue {
            display: inline-block;
            padding: 12px 30px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            font-size: 16px;
        }

        .btn-blue:hover {
            background: #357ABD;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
            color: white;
        }

        .btn-outline-blue {
            display: inline-block;
            padding: 12px 30px;
            background: white;
            color: #4682B4;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid #4682B4;
            font-size: 16px;
        }

        .btn-outline-blue:hover {
            background: #4682B4;
            color: white;
        }

        @media (max-width: 768px) {
            .action-buttons { flex-direction: column; }
            .btn-blue, .btn-outline-blue { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="confirmation-container">
    <div class="confirmation-card">
        <div class="success-icon">
            <svg viewBox="0 0 24 24">
                <polyline points="20 6 9 17 4 12"></polyline>
            </svg>
        </div>

        <h1>Quote Request Submitted!</h1>
        <p class="subtitle">Thank you for your interest, <%= quoteName != null ? quoteName : "Customer" %>! We've received your quote request and will get back to you shortly.</p>

        <div class="reference-box">
            Reference: <%= referenceNumber %>
        </div>

        <div class="quote-details">
            <div class="detail-row">
                <span class="detail-label">Name</span>
                <span class="detail-value"><%= quoteName != null ? quoteName : "N/A" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Email</span>
                <span class="detail-value"><%= quoteEmail != null ? quoteEmail : "N/A" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Product Type</span>
                <span class="detail-value"><%= quoteProduct != null ? quoteProduct : "N/A" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Quantity</span>
                <span class="detail-value"><%= quoteQuantity != null ? quoteQuantity + " units" : "N/A" %></span>
            </div>
        </div>

        <div class="info-box">
            <h3>📧 What Happens Next?</h3>
            <p>Our team will review your requirements and send you a detailed quote to <strong><%= quoteEmail != null ? quoteEmail : "your email" %></strong> within 24 hours.</p>
        </div>

        <div class="timeline">
            <h3>Quote Process Timeline</h3>

            <div class="timeline-step">
                <div class="step-number">1</div>
                <div class="step-content">
                    <h4>Request Received</h4>
                    <p>Your request is now in our system</p>
                </div>
            </div>

            <div class="timeline-step">
                <div class="step-number">2</div>
                <div class="step-content">
                    <h4>Review & Analysis</h4>
                    <p>Our team calculates the best pricing for you</p>
                </div>
            </div>

            <div class="timeline-step">
                <div class="step-number">3</div>
                <div class="step-content">
                    <h4>Quote Sent</h4>
                    <p>You receive the final quotation via email</p>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <a href="index.jsp" class="btn-blue">Back to Home</a>
            <a href="quote.jsp" class="btn-outline-blue">Submit Another Quote</a>
        </div>

        <p style="margin-top: 30px; color: #777; font-size: 14px;">
            Need urgent assistance? <br>
            Contact us at <a href="tel:+6011-7078-7469" style="color: #4682B4; font-weight: 600; text-decoration:none;">+6011-7078-7469</a>
        </p>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>