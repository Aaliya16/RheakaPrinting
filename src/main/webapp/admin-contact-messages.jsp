<%-- admin-contact-messages.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Fetch REAL data from Database
    MessageDao msgDao = new MessageDao(DbConnection.getConnection());
    List<Message> allMessages = msgDao.getAllMessages();

    if (allMessages == null) {
        allMessages = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Messages - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* YOUR ORIGINAL CSS - UNCHANGED */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --primary-dark: #1a3a6d;
            --accent-blue: #3498db;
            --bg-body: #f8f9fc;
        }

        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: var(--bg-body); color: #2c3e50; }

        .main-content {
            margin-left: 260px;
            padding: 30px;
            min-height: 100vh;
            background: #f5f6fa;
        }

        .top-bar {
            background: white;
            padding: 0 35px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }
        .top-bar h1 {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-weight: 600;
            font-size: 24px;
            color: #1a3a6d;
            margin: 0;
        }

        .content-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }
        .header-title { display: flex; align-items: center; gap: 12px; color: var(--primary-dark); }

        .admin-profile { display: flex; align-items: center; gap: 15px; }
        .avatar-circle {
            width: 35px; height: 35px; background: #5f27cd; color: white;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 35px; }
        .stat-card {
            background: white; padding: 15px 25px; height: 100px;
            border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.03);
            display: flex; align-items: center; gap: 20px;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-5px); }

        .stat-icon {
            width: 50px; height: 50px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; color: white;
        }
        .bg-new { background: #a29bfe; }
        .bg-total { background: #ffeaa7; }

        .stat-info h3 { font-size: 22px; font-weight: 700; margin: 0; color: #2d3436; }
        .stat-info p { font-size: 12px; color: #b2bec3; font-weight: 600; text-transform: uppercase; }

        .message-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .message-table th {
            text-align: left;
            padding: 12px;
            background: #f8f9fa;
            border-bottom: 2px solid #edf2f7;
            font-size: 12px;
            text-transform: uppercase;
            color: #718096;
        }
        .message-table td {
            padding: 15px 12px;
            border-bottom: 1px solid #f1f2f6;
            font-size: 14px;
        }

        .empty-state {
            text-align: center; color: #a0aec0; padding: 50px 0;
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            width: 100%;
        }
        .empty-state i { font-size: 60px; margin-bottom: 20px; color: #dfe6e9; }
        .empty-state h2 { color: #636e72; margin-bottom: 10px; }

        /* Small additional CSS for the new functional buttons */
        .btn-action {
            padding: 6px 12px; border-radius: 6px; border: none; cursor: pointer;
            font-size: 12px; transition: 0.2s; background: #edf2f7; color: #4a5568;
        }
        .btn-action:hover { background: var(--accent-blue); color: white; }

        .search-box {
            padding: 8px 15px; border-radius: 8px; border: 1px solid #ddd;
            width: 300px; outline: none;
        }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div class="header-title">
            <i class="fas fa-envelope-open-text" style="font-size: 24px; color: var(--accent-blue);"></i>
            <h1>Contact Messages</h1>
        </div>

        <input type="text" id="msgInput" onkeyup="searchTable()" placeholder="Search messages..." class="search-box">

        <div class="admin-profile">
            <div class="avatar-circle">
                <%= (adminUser != null && adminUser.length() > 0) ? adminUser.substring(0,1).toUpperCase() : "A" %>
            </div>
            <span style="font-weight: 600; font-size: 14px;"><%= adminUser %></span>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon bg-new"><i class="fas fa-envelope"></i></div>
            <div class="stat-info">
                <h3><%= allMessages.size() %></h3>
                <p>Total Inbox</p>
            </div>
        </div>
    </div>

    <div class="content-card">
        <% if (allMessages.isEmpty()) { %>
        <div class="empty-state">
            <i class="fas fa-mail-bulk"></i>
            <h2>No messages found</h2>
            <p>Form submissions from your contact page will appear here.</p>
            <button onclick="location.reload()" class="btn-action" style="margin-top: 15px;">Refresh</button>
        </div>
        <% } else { %>
        <table class="message-table" id="msgTable">
            <thead>
            <tr>
                <th>Sender</th>
                <th>Subject</th>
                <th>Message</th>
                <th>Date</th>
                <th style="text-align: right;">Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Message m : allMessages) { %>
            <tr>
                <td>
                    <strong><%= m.getName() %></strong><br>
                    <small style="color: var(--accent-blue)"><%= m.getEmail() %></small>
                </td>
                <td><%= m.getSubject() %></td>
                <td style="color: #636e72;"><%= m.getMessage() %></td>
                <td style="white-space: nowrap;"><%= m.getCreatedAt() %></td>
                <td style="text-align: right;">
                    <button class="btn-action" onclick="alert('<%= m.getMessage().replace("'", "\\'") %>')">View</button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

<script>
    // Professional Search Script
    function searchTable() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("msgInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("msgTable");
        tr = table.getElementsByTagName("tr");
        for (i = 1; i < tr.length; i++) {
            td = tr[i].innerText;
            if (td) {
                if (td.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

</body>
</html>