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
            --primary-dark: #1a3a6d;
            --accent-blue: #3498db;
            --success-green: #2ecc71;
            --danger-red: #ee5253;
            --bg-body: #f8f9fc;
        }

        body { font-family: 'Segoe UI', sans-serif; background: var(--bg-body); color: #333; }
        /* Standardized Layout Sizes */
        .main-content {
            margin-left: 260px; /* Matches your sidebar width */
            padding: 30px;
            min-height: 100vh;
            background: #f5f6fa;
        }

        .top-bar {
            background: white;
            padding: 0 35px; /* Side padding for the content inside */
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px; /* THIS IS THE KEY SIZE */
        }
        .top-bar h1 {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-weight: 600; /* This creates the specific bold effect you like */
            font-size: 24px;
            color: #1a3a6d; /* The deep navy blue used in your panel */
            margin: 0;
        }

        .content-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }
        /* Settings Grid - 3 Column Layout for more detail */
        .settings-grid { display: grid; gap: 25px; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); }

        .settings-card {
            background: white; padding: 25px; border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03); height: fit-content;
        }

        .settings-card h2 {
            color: var(--primary-dark); font-size: 18px; margin-bottom: 20px;
            padding-bottom: 12px; border-bottom: 1px solid #f1f5f9;
            display: flex; align-items: center; gap: 10px;
        }

        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 6px; font-size: 13px; color: #475569; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 14px;
        }

        /* Toggle items */
        .setting-item {
            display: flex; justify-content: space-between; align-items: center;
            padding: 12px; background: #f8fafc; border-radius: 10px; margin-bottom: 10px;
        }

        .btn { padding: 10px 18px; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: 0.2s; }
        .btn-primary { background: var(--accent-blue); color: white; width: 100%; }
        .btn-success { background: var(--success-green); color: white; width: 100%; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <h2 style="color: var(--primary-dark);"><i class="fas fa-tools"></i> Advanced System Configuration</h2>
        <div class="admin-profile" style="display:flex; align-items:center; gap:10px;">
            <div style="width:35px; height:35px; border-radius:50%; background:#5f27cd; color:white; display:flex; align-items:center; justify-content:center; font-weight:bold;"><%= avatarLetter %></div>
            <span style="font-weight: 600;"><%= displayName %></span>
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
                    <label><i class="fab fa-whatsapp"></i> WhatsApp Business Number</label>
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
                    <span style="font-size: 13px; font-weight: 600;">Enable Self-Pickup</span>
                    <input type="checkbox" checked>
                </div>
                <button type="submit" class="btn btn-primary">Save Logistics</button>
            </form>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-key"></i> Security</h2>
            <form action="UpdateAdminPassword" method="POST">
                <div class="form-group">
                    <label>Change Admin Password</label>
                    <input type="password" placeholder="Current Password">
                    <input type="password" placeholder="New Password" style="margin-top: 10px;">
                </div>
                <button type="submit" class="btn btn-success">Change Password</button>
            </form>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-database"></i> Database Maintenance</h2>
            <p style="font-size: 12px; color: #64748b; margin-bottom: 15px;">Regular backups prevent data loss from server failures.</p>
            <button class="btn btn-primary" style="background: #6c757d; margin-bottom: 10px;">
                <i class="fas fa-download"></i> Generate SQL Backup
            </button>
            <button class="btn btn-primary" style="background: #e67e22;">
                <i class="fas fa-broom"></i> Clear Old Audit Logs
            </button>
        </div>

    </div>
</div>

</body>
</html>