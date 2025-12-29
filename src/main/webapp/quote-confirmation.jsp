<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String quoteName = (String) session.getAttribute("quote_name");
    String quoteEmail = (String) session.getAttribute("quote_email");
    String quoteProduct = (String) session.getAttribute("quote_product");
    Integer quoteQuantity = (Integer) session.getAttribute("quote_quantity");

    // Generate reference number
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
        :root {
            --mongoose: #baa987;
        }

        body {
            background-color: #f5f5f5;
            font-family: 'Roboto', sans-serif;
        }

        .confirmation-container {
            max-width: 700px;
            margin: 80px auto;
            padding: 20px;
            width: 90%;
        }

        .confirmation-card {
            background: #fff;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
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
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
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
        }

        .subtitle {
            color: #666;
            font-size: 16px;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .reference-box {
            background: var(--mongoose);
            color: white;
            padding: 20px 30px;
            border-radius: 10px;
            display: inline-block;
            margin: 30px 0;
            font-weight: bold;
            font-size: 18px;
        }

        .quote-details {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            margin: 30px 0;
            text-align: left;
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
            border-left: 4px solid #2196F3;
            padding: 20px;
            margin: 30px 0;
            border-radius: 5px;
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

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }

        .btn {
            padding: 15px 35px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-primary {
            background: var(--mongoose);
            color: white;
        }

        .btn-primary:hover {
            background: #a49374;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: white;
            color: var(--mongoose);
            border: 2px solid var(--mongoose);
        }

        .btn-secondary:hover {
            background: var(--mongoose);
            color: white;
        }

        .timeline {
            margin: 40px 0;
            text-align: left;
        }

        .timeline h3 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .timeline-step {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .step-number {
            width: 40px;
            height: 40px;
            background: var(--mongoose);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 15px;
        }

        .step-content h4 {
            margin: 0 0 5px 0;
            color: #333;
            font-size: 16px;
        }

        .step-content p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .confirmation-card {
                padding: 30px 20px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
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
            <p>A confirmation email has been sent to <%= quoteEmail != null ? quoteEmail : "your email address" %>. Our team will review your requirements and send you a detailed quote within 24 hours.</p>
        </div>

        <div class="timeline">
            <h3>Quote Process Timeline</h3>

            <div class="timeline-step">
                <div class="step-number">1</div>
                <div class="step-content">
                    <h4>Request Received</h4>
                    <p>Your quote request has been submitted successfully</p>
                </div>
            </div>

            <div class="timeline-step">
                <div class="step-number">2</div>
                <div class="step-content">
                    <h4>Review & Analysis</h4>
                    <p>Our team reviews your requirements (1-2 hours)</p>
                </div>
            </div>

            <div class="timeline-step">
                <div class="step-number">3</div>
                <div class="step-content">
                    <h4>Quote Preparation</h4>
                    <p>We prepare a detailed quotation (12-24 hours)</p>
                </div>
            </div>

            <div class="timeline-step">
                <div class="step-number">4</div>
                <div class="step-content">
                    <h4>Quote Sent</h4>
                    <p>You receive the quote via email</p>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <a href="index.jsp" class="btn btn-primary">Back to Home</a>
            <a href="quote.jsp" class="btn btn-secondary">Submit Another Quote</a>
        </div>

        <p style="margin-top: 30px; color: #999; font-size: 14px;">
            Need urgent assistance? Contact us at <a href="tel:+60123456789" style="color: var(--mongoose); font-weight: 600;">+60 12-345 6789</a>
        </p>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>