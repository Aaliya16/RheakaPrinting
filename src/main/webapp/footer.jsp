<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.rheakaprinting.dao.SettingsDao" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>

<%
    // Initialize connection and fetch dynamic settings
    Connection footerConn = DbConnection.getConnection();
    SettingsDao footerDao = new SettingsDao(footerConn);
    Map<String, String> liveSettings = footerDao.getAllSettings();

    // Updated keys to match your UpdateSettingsServlet and Admin Panel names
    String f_address = liveSettings.getOrDefault("footer_address", "Gerai No.12, Tapak Pauh Lama, Pauh 02600 Arau Perlis");
    String f_phone = liveSettings.getOrDefault("whatsapp_num", "011-7078-7469");
    String f_email = liveSettings.getOrDefault("footer_email", "rheakadesign@gmail.com");

    // Social keys updated to match your admin-settings.jsp input names
    String fbUrl = liveSettings.getOrDefault("facebook_url", "https://www.facebook.com/matuzair06/");
    String ttUrl = liveSettings.getOrDefault("tiktok_url", "https://www.tiktok.com/@rheakadesign");

    // Generates the WhatsApp link dynamically from the phone number
    String waUrl = "https://wa.me/6" + f_phone.replace("-", "");
%>

<style>
    /* Footer Styling */
    .footer {
        background-color: #ffffff;
        padding: 30px 50px;
        text-align: center;
        border-top: 1px solid #e0e0e0;
        margin-top: auto;
    }
    .footer-content { max-width: 1200px; margin: 0 auto; }
    .footer p { margin: 8px 0; color: #333; font-size: 14px; line-height: 1.6; }
    .footer strong { color: #000; font-weight: 600; }
    .footer a { color: #0055ff; text-decoration: none; font-weight: 500; transition: color 0.3s ease; }
    .footer a:hover { color: #003399; text-decoration: underline; }
    .social-links { margin-top: 15px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; }
    .social-links a { color: #0055ff; font-size: 14px; }
    .copyright { margin-top: 20px; padding-top: 20px; border-top: 1px solid #e0e0e0; color: #666; font-size: 13px; }

    @media (max-width: 768px) {
        .footer { padding: 20px; }
        .footer p { font-size: 13px; }
    }
</style>

<footer class="footer">
    <div class="footer-content">
        <p><strong>Rheaka Design Services</strong>. All Rights Reserved.</p>

        <%-- Dynamic Address and Phone --%>
        <p><%=f_address %> |
            <a href="tel:<%= f_phone %>"><%= f_phone %></a>
        </p>

        <%-- Dynamic Email --%>
        <p>Email:
            <a href="mailto:<%= f_email %>"><%= f_email %></a>
        </p>

        <div class="social-links">
            <span>Follow us on:</span>
            <%-- These now link to the URLs you save in the Admin Panel --%>
            <a href="<%= fbUrl %>" target="_blank">Facebook</a>
            <span>•</span>
            <a href="<%= ttUrl %>" target="_blank">Tiktok</a>
            <span>•</span>
            <a href="<%= waUrl %>" target="_blank">Whatsapp</a>
        </div>

        <div class="copyright">
            © <%= java.time.Year.now().getValue() %> Rheaka Design Services
        </div>
    </div>
</footer>