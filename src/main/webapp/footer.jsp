<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Footer Styling */
    .footer {
        background-color: #ffffff;
        padding: 30px 50px;
        text-align: center;
        border-top: 1px solid #e0e0e0;
        margin-top: auto; /* Pushes footer to bottom */
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer p {
        margin: 8px 0;
        color: #333;
        font-size: 14px;
        line-height: 1.6;
    }

    .footer strong {
        color: #000;
        font-weight: 600;
    }

    .footer a {
        color: #0055ff;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .footer a:hover {
        color: #003399;
        text-decoration: underline;
    }

    /* Social Media Links */
    .social-links {
        margin-top: 15px;
        display: flex;
        justify-content: center;
        gap: 15px;
        flex-wrap: wrap;
    }

    .social-links a {
        color: #0055ff;
        font-size: 14px;
    }

    /* Copyright */
    .copyright {
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid #e0e0e0;
        color: #666;
        font-size: 13px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .footer {
            padding: 20px;
        }

        .footer p {
            font-size: 13px;
        }
    }
</style>

<footer class="footer">
    <div class="footer-content">
        <p><strong>Rheaka Design Printing</strong>. All Rights Reserved.</p>

        <p>Tapak Pauh Lama, 02600 Arau Perlis |
            <a href="tel:011-7078-7469">011-7078-7469</a>
        </p>

        <!-- Social Media Links -->
        <div class="social-links">
            <span>Follow us on:</span>
            <a href="https://facebook.com" target="_blank">Facebook</a>
            <span>•</span>
            <a href="https://instagram.com" target="_blank">Instagram</a>
            <span>•</span>
            <a href="https://tiktok.com" target="_blank">TikTok</a>
        </div>

        <!-- Copyright -->
        <div class="copyright">
            © 2025 Rheaka Design Printing
        </div>
    </div>
</footer>