<%-- admin-settings.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.rheakaprinting.dao.SettingsDao" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    String displayName = (adminUser != null && !adminUser.trim().isEmpty()) ? adminUser : "Admin";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Advanced Settings - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --brand-color: #6c5ce7;
            --brand-light: rgba(108, 92, 231, 0.1);
            --bg-body: #f1f2f6;
            --text-main: #2d3436;
            --danger-red: #ee5253;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

        .main-content { margin-left: 260px; padding: 30px; min-height: 100vh; }

        .top-bar {
            background: white;
            padding: 20px 35px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left { display: flex; align-items: center; gap: 20px; }
        .header-icon-box {
            width: 50px; height: 50px; min-width: 50px;
            background: var(--brand-color);
            border-radius: 15px; display: flex; align-items: center; justify-content: center;
            color: white;
        }
        .header-icon-box i { font-size: 22px; }

        .top-bar h1 { font-size: 24px; color: var(--text-main); margin: 0; line-height: 1.2; }

        admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--brand-color); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        .settings-grid {
            display: grid;
            gap: 25px;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            align-items: stretch;
        }

        .settings-card {
            background: white;
            padding: 30px;
            border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
            display: flex;
            flex-direction: column;
            transition: 0.3s ease;
        }
        .settings-card:hover { transform: translateY(-5px); }

        .settings-card form, .maintenance-actions {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .settings-card h2 {
            color: var(--text-main); font-size: 18px; margin-bottom: 25px;
            padding-bottom: 15px; border-bottom: 2px solid #f1f2f6;
            display: flex; align-items: center; gap: 12px;
        }
        .settings-card h2 i { color: var(--brand-color); }

        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-weight: 700; margin-bottom: 8px; font-size: 11px; color: #b2bec3; text-transform: uppercase; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%; padding: 12px; border: 1px solid #f1f2f6; background: #f1f2f6; border-radius: 10px; font-size: 14px; outline: none;
        }

        .setting-item {
            display: flex; justify-content: space-between; align-items: center;
            padding: 15px; background: #f8fafc; border-radius: 12px; margin-bottom: 15px;
        }

        .btn { padding: 12px 20px; border: none; border-radius: 12px; font-size: 13px; font-weight: 700; cursor: pointer; transition: 0.3s; margin-top: auto; }
        .btn-primary { background: var(--brand-color); color: white; width: 100%; }
        .btn-primary:hover { opacity: 0.9; }

        .back-container { display: flex; justify-content: flex-end; margin-top: 30px; width: 100%; grid-column: 1 / -1; }
        .btn-back {
            display: flex; align-items: center; gap: 8px; padding: 12px 25px;
            background: white; color: var(--brand-color); border: 2px solid var(--brand-color);
            border-radius: 12px; font-weight: 700; font-size: 14px; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { background: var(--brand-color); color: white; }

        #toast {
            visibility: hidden;
            min-width: 300px;
            background-color: #2ecc71;
            color: #fff;
            text-align: center;
            border-radius: 12px;
            padding: 16px 24px;
            position: fixed;
            z-index: 1000;
            left: 50%;
            bottom: 30px;
            transform: translateX(-50%);
            font-size: 15px;
            font-weight: 600;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        #toast.show {
            visibility: visible;
            animation: slideUpFade 0.5s, slideDownFade 0.5s 2.5s;
        }

        @keyframes slideUpFade {
            from { bottom: 0; opacity: 0; transform: translate(-50%, 20px); }
            to { bottom: 30px; opacity: 1; transform: translate(-50%, 0); }
        }

        @keyframes slideDownFade {
            from { bottom: 30px; opacity: 1; transform: translate(-50%, 0); }
            to { bottom: 0; opacity: 0; transform: translate(-50%, 20px); }
        }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div class="header-left">
            <div class="header-icon-box"><i class="fas fa-tools"></i></div>
            <h1>System<br><span style="font-weight: 400; font-size: 22px;">Configuration</span></h1>
        </div>

        <div class="admin-profile" style="display: flex; align-items: center; gap: 15px;">
            <%-- NEW: Welcome Greeting --%>
            <div style="text-align: right;">
        <span style="display:block; font-size: 14px; color: var(--text-main); font-weight: 600;">
            Welcome, Administrator
        </span>
            </div>

            <%-- Avatar Circle --%>
            <div class="avatar-circle">
                <%= (adminUser != null && !adminUser.isEmpty()) ? adminUser.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <div class="settings-grid">
        <%
            Connection gridConn = DbConnection.getConnection();
            SettingsDao gridDao = new SettingsDao(gridConn);
            Map<String, String> gridSettings = gridDao.getAllSettings();
        %>
        <%-- Footer Contact Info Card --%>
        <div class="settings-card">
            <h2><i class="fas fa-map-marker-alt"></i> Footer Contact Info</h2>
            <form action="UpdateSettingsServlet" method="POST">
                <div class="form-group">
                    <label>Business Address</label>
                    <input type="text" name="footer_address" value="<%= gridSettings.getOrDefault("footer_address", "Gerai No.12, Tapak Pauh Lama, 02600 Arau Perlis") %>">
                </div>
                <div class="form-group">
                    <label>Public Email</label>
                    <input type="email" name="footer_email" value="<%= gridSettings.getOrDefault("footer_email", "rheakadesign@gmail.com") %>">
                </div>
                <button type="submit" class="btn btn-primary">Update Website Footer</button>
            </form>
        </div>

        <%-- Social Presence Card --%>
        <div class="settings-card">
            <h2><i class="fas fa-share-alt"></i> Social Presence</h2>
            <form action="UpdateSettingsServlet" method="POST">
                <div class="form-group">
                    <label><i class="fab fa-facebook"></i> Facebook URL</label>
                    <input type="url" name="facebook_url" value="<%= gridSettings.getOrDefault("facebook_url", "https://www.facebook.com/matuzair06/") %>">
                </div>
                <div class="form-group">
                    <label><i class="fab fa-tiktok"></i> TikTok URL</label>
                    <input type="url" name="tiktok_url" value="<%= gridSettings.getOrDefault("tiktok_url", "https://www.tiktok.com/@rheakadesign") %>">
                </div>
                <div class="form-group">
                    <label><i class="fab fa-whatsapp"></i> WhatsApp Number</label>
                    <input type="text" name="whatsapp_num" value="<%= gridSettings.getOrDefault("whatsapp_num", "011-7078-7469") %>">
                </div>
                <button type="submit" class="btn btn-primary">Update Social Links</button>
            </form>
        </div>

        <%-- Shipping Rules --%>
        <div class="settings-card">
            <h2><i class="fas fa-shipping-fast"></i> Shipping Rules</h2>
            <%
                Connection shipConn = DbConnection.getConnection();
                String shipQuery = "SELECT * FROM shipping_settings WHERE id = 1";
                PreparedStatement shipPs = shipConn.prepareStatement(shipQuery);
                ResultSet shipRs = shipPs.executeQuery();

                double baseFee = 10.00;
                double freeThreshold = 200.00;
                boolean selfPickupEnabled = true;

                if (shipRs.next()) {
                    baseFee = shipRs.getDouble("base_fee");
                    freeThreshold = shipRs.getDouble("free_threshold");
                    selfPickupEnabled = shipRs.getBoolean("self_pickup_enabled");
                }
            %>
            <form action="UpdateShippingSettings" method="POST">
                <div class="form-group">
                    <label>Base Shipping Fee (RM)</label>
                    <input type="number" name="baseShip" value="<%= baseFee %>" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Free Shipping Threshold (RM)</label>
                    <input type="number" name="freeShip" value="<%= freeThreshold %>" step="0.01" required>
                </div>
                <div class="setting-item">
                    <span style="font-size: 13px; font-weight: 700; color: var(--text-main);">Self-Pickup</span>
                    <input type="checkbox" name="selfPickup" <%= selfPickupEnabled ? "checked" : "" %> style="width: auto;">
                </div>
                <button type="submit" class="btn btn-primary">Save Logistics</button>
            </form>
        </div>

        <%-- Security --%>
        <div class="settings-card">
            <h2><i class="fas fa-key"></i> Security</h2>
            <form action="UpdateAdminPassword" method="POST">
                <div class="form-group">
                    <label>Current Password</label>
                    <input type="password" name="currentPassword" required>
                </div>
                <div class="form-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword" required>
                </div>
                <button type="submit" class="btn btn-primary">Change Password</button>

            </form>
        </div>

        <div class="back-container">
            <button onclick="window.history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </button>
        </div>
    </div>
</div>

<div id="toast"><i class="fas fa-check-circle"></i> Settings updated successfully!</div>

<script>
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('status') === 'success') {
            var x = document.getElementById("toast");
            x.className = "show";
            setTimeout(function(){
                x.className = x.className.replace("show", "");
                window.history.replaceState({}, document.title, window.location.pathname);
            }, 3000);
        }
    };
</script>
</body>
</html>