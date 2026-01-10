<%-- admin-settings.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    String displayName = (adminUser != null && !adminUser.trim().isEmpty()) ? adminUser : "Admin";
    String avatarLetter = displayName.substring(0, 1).toUpperCase();
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
            --brand-color: #6c5ce7; /* Professional monochrome purple */
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

        /* Standardized Top Bar */
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

        .admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--brand-color); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        /* Settings Grid Layout - Updated to ensure same sizes */
        .settings-grid {
            display: grid;
            gap: 25px;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            align-items: stretch; /* This makes all cards in a row the same height */
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

        /* Back Button */
        .back-container { display: flex; justify-content: flex-end; margin-top: 30px; width: 100%; grid-column: 1 / -1; }
        .btn-back {
            display: flex; align-items: center; gap: 8px; padding: 12px 25px;
            background: white; color: var(--brand-color); border: 2px solid var(--brand-color);
            border-radius: 12px; font-weight: 700; font-size: 14px; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { background: var(--brand-color); color: white; }
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

        <div class="admin-profile">
            <div class="avatar-circle">
                <%= (displayName != null && !displayName.isEmpty()) ? displayName.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <div class="settings-grid">
        <div class="settings-card">
            <h2><i class="fas fa-money-bill-wave"></i> Regional & Tax</h2>
            <form action="UpdateRegionalSettings" method="POST">
                <div class="form-group">
                    <label>Currency Symbol</label>
                    <input type="text" name="currency" value="RM">
                </div>
                <div class="form-group">
                    <label>SST / Tax Percentage (%)</label>
                    <input type="number" name="taxRate" value="6" step="0.1">
                </div>
                <div class="form-group">
                    <label>Timezone</label>
                    <select name="timezone">
                        <option value="Asia/Kuala_Lumpur">Kuala Lumpur (GMT+8)</option>
                        <option value="Asia/Singapore">Singapore (GMT+8)</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update Finance Settings</button>
            </form>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-share-alt"></i> Social Presence</h2>
            <form action="UpdateSocialSettings" method="POST">
                <div class="form-group">
                    <label><i class="fab fa-facebook"></i> Facebook URL</label>
                    <input type="url" name="fb" value="https://facebook.com/rheaka">
                </div>
                <div class="form-group">
                    <label><i class="fab fa-instagram"></i> Instagram URL</label>
                    <input type="url" name="ig" value="https://instagram.com/rheaka">
                </div>
                <div class="form-group">
                    <label><i class="fab fa-whatsapp"></i> WhatsApp Number</label>
                    <input type="text" name="wa" value="+60123456789">
                </div>
                <button type="submit" class="btn btn-primary">Update Social Links</button>
            </form>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-shipping-fast"></i> Shipping Rules</h2>
            <form action="UpdateShippingSettings" method="POST">
                <div class="form-group">
                    <label>Base Shipping Fee (RM)</label>
                    <input type="number" name="baseShip" value="10.00" step="0.5">
                </div>
                <div class="form-group">
                    <label>Free Shipping Threshold (RM)</label>
                    <input type="number" name="freeShip" value="200.00">
                </div>
                <div class="setting-item">
                    <span style="font-size: 13px; font-weight: 700; color: var(--text-main);">Self-Pickup</span>
                    <input type="checkbox" checked style="width: auto;">
                </div>
                <button type="submit" class="btn btn-primary">Save Logistics</button>
            </form>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-key"></i> Security</h2>
            <form action="UpdateAdminPassword" method="POST">
                <div class="form-group">
                    <label>Update Password</label>
                    <input type="password" placeholder="Current Password">
                    <input type="password" placeholder="New Password" style="margin-top: 10px;">
                </div>
                <button type="submit" class="btn btn-primary" style="background: var(--brand-color);">Change Password</button>
            </form>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-database"></i> Maintenance</h2>
            <p style="font-size: 13px; color: #b2bec3; margin-bottom: 20px; line-height: 1.5;">Regular maintenance prevents data loss from unexpected server failures.</p>
            <button class="btn btn-primary" style="background: var(--brand-light); color: var(--brand-color); margin-bottom: 12px;">
                <i class="fas fa-download"></i> Generate SQL Backup
            </button>
            <button class="btn btn-primary" style="background: #f1f2f6; color: var(--danger-red);">
                <i class="fas fa-broom"></i> Clear Audit Logs
            </button>
        </div>

        <div class="back-container">
            <button onclick="window.history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </button>
        </div>
    </div>
</div>

</body>
</html>