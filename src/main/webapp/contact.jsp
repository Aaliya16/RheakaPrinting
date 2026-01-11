<%@ page import="com.example.rheakaprinting.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Rheaka Printing</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --mongoose: #baa987;
            --steelblue: #b0c4de;
        }

        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .contact-container {
            padding-top: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
            animation: fadeInDown 0.8s ease;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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

        .contact-grid {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
            padding: 0 15px;
        }

        @media (max-width: 768px) {
            .contact-grid {
                grid-template-columns: 1fr;
            }
        }

        .contact-form-card {
            width: 100%;
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            animation: fadeInLeft 0.8s ease;
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
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

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 15px;
            animation: shake 0.5s;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
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

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        select,
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
            font-family: inherit;
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #4682B4; /* Tukar border focus jadi biru */
            box-shadow: 0 0 0 3px rgba(70, 130, 180, 0.1);
        }

        textarea {
            min-height: 150px;
            resize: vertical;
        }

        .btn-submit {
            display: inline-block;
            padding: 12px 35px;
            background: #4682B4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;

            width: 100%;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: #357ABD;
            transform: scale(1.02); /* Scale sikit je supaya tak terkeluar */
            box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
        }

        .btn-submit:active {
            transform: scale(0.98);
        }

        @media (max-width: 768px) {
            .contact-form-card {
                padding: 20px;
            }

            .page-header h1 {
                font-size: 32px;
            }
        }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="contact-container">
    <div class="page-header">
        <h1>Get In Touch</h1>
        <p>We'd love to hear from you. Send us a message!</p>
    </div>

    <div class="contact-grid">
        <div class="contact-form-card">
            <h2 class="form-title">Send Us a Message</h2>
            <p class="form-subtitle">Fill out the form below and we'll get back to you soon</p>

            <%-- Success/Error Messages --%>
            <%
                String msg = request.getParameter("msg");
                if (msg != null) {
                    if (msg.equals("success")) { %>
            <div class="alert alert-success">
                ✅ Thank you! Your message has been sent successfully.
            </div>
            <% } else if (msg.equals("error")) { %>
            <div class="alert alert-danger">
                Oops! Something went wrong. Please try again.
            </div>
            <% }
            }
            %>

            <form action="ContactServlet" method="POST" id="contactForm">
                <div class="form-group">
                    <label for="name">Full Name <span class="required">*</span></label>
                    <input type="text"
                           id="name"
                           name="name"
                           placeholder="Enter your full name"
                           required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="your.email@example.com"
                           required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number <span class="required">*</span></label>
                    <input type="tel"
                           id="phone"
                           name="phone"
                           placeholder="+60 12-345 6789"
                           required>
                </div>

                <div class="form-group">
                    <label for="subject">Subject <span class="required">*</span></label>
                    <select id="subject" name="subject" required>
                        <option value="">-- Select a subject --</option>
                        <option value="General Inquiry">General Inquiry</option>
                        <option value="Custom Order">Custom Order Request</option>
                        <option value="Quote Request">Quote Request</option>
                        <option value="Technical Support">Technical Support</option>
                        <option value="Complaint">Complaint</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="message">Message <span class="required">*</span></label>
                    <textarea id="message"
                              name="message"
                              placeholder="Tell us more about your inquiry..."
                              required></textarea>
                </div>

                <button type="button" class="btn-submit" onclick="handleContactSubmit()">Send Message</button>
            </form>
        </div>
    </div>
</div>

<script>
    function handleContactSubmit() {
        <%
            User authContact = (User) session.getAttribute("auth");
            if (authContact == null) authContact = (User) session.getAttribute("currentUser");
        %>
        var isLoggedIn = <%= (authContact != null) ? "true" : "false" %>;

        if (!isLoggedIn) {
            alert("⚠️ Please LOGIN first before sending us a message.");
            window.location.href = "login.jsp";
            return;
        }

        var form = document.getElementById('contactForm');
        if (form.checkValidity()) {
            form.submit();
        } else {
            form.reportValidity();
        }
    }
</script>

//secondary cliend-side for validation from integrity
<script>
    // Form validation
    document.getElementById('contactForm').addEventListener('submit', function(e) {
        const name = document.getElementById('name').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const subject = document.getElementById('subject').value;
        const message = document.getElementById('message').value.trim();

        if (!name || !phone || !subject || !message) {
            e.preventDefault();
            alert('Please fill in all required fields');
            return false;
        }

        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            alert('Please enter a valid email address');
            return false;
        }

        return true;
    });
</script>
<%@ include file="footer.jsp" %>
</body>
</html>
