<%-- admin-contact-messages.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Logic remains exactly the same
    MessageDao msgDao = new MessageDao(DbConnection.getConnection());
    List<Message> allMessages = msgDao.getAllMessages();

    if (allMessages == null) {
        allMessages = new ArrayList<>();
    }

    int totalCount = allMessages.size();
    int unreadCount = 0;
    int repliedCount = 0;
    int thisWeekCount = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Messages - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --brand-color: #6c5ce7; /* Single professional purple theme */
            --brand-light: rgba(108, 92, 231, 0.1);
            --bg-body: #f1f2f6;
            --text-main: #2d3436;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 30px;
            opacity: 0; /* Starts hidden */
            will-change: transform, opacity;
            /* FIX: Changed animation name to match keyframes below */
            animation: smoothSlideUp 0.7s cubic-bezier(0.22, 1, 0.36, 1) forwards;
        }

        /* FIX: Keyframes must match the name used in the animation property above */
        @keyframes smoothSlideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Staggered Row Animation - Makes the table rows "roll in" */
        tbody tr {
            opacity: 0;
            animation: rowAppear 0.5s ease-out forwards;
        }

        tbody tr:nth-child(1) { animation-delay: 0.2s; }
        tbody tr:nth-child(2) { animation-delay: 0.3s; }
        tbody tr:nth-child(3) { animation-delay: 0.4s; }
        tbody tr:nth-child(4) { animation-delay: 0.5s; }

        @keyframes rowAppear {
            from { opacity: 0; transform: translateX(-10px); }
            to { opacity: 1; transform: translateX(0); }
        }
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

        /* Fixed Icon Sizes to match Dashboard exactly */
        .header-icon-box {
            width: 50px; height: 50px; min-width: 50px;
            background: var(--brand-color);
            border-radius: 15px; display: flex; align-items: center; justify-content: center;
            color: white;
        }
        .header-icon-box i { font-size: 22px; }

        .top-bar h1 { font-size: 24px; color: var(--text-main); margin: 0; line-height: 1.2; }

        .search-container {
            background: #f1f2f6; border-radius: 12px; padding: 10px 20px;
            display: flex; align-items: center; gap: 10px; width: 400px;
        }
        .search-container input { border: none; background: transparent; outline: none; width: 100%; font-size: 14px; }

        /* Monochrome Stats Grid */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 30px; }
        .stat-card {
            background: white; padding: 25px; border-radius: 20px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.04); transition: 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-val { font-size: 32px; font-weight: 800; color: var(--text-main); }
        .stat-label { font-size: 11px; color: #b2bec3; text-transform: uppercase; font-weight: 700; margin-top: 5px; }

        .stat-icon-mini {
            width: 45px; height: 45px; border-radius: 12px;
            background: var(--brand-light);
            display: flex; align-items: center; justify-content: center;
            color: var(--brand-color); font-size: 18px;
        }

        .content-card {
            background: white; padding: 30px; border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04); min-height: 400px;
        }

        /* Tab buttons */
        .tab-bar { display: flex; gap: 10px; margin-bottom: 25px; align-items: center; }
        .tab-btn {
            padding: 8px 20px; border-radius: 10px; border: none; font-weight: 600;
            font-size: 13px; cursor: pointer; transition: 0.2s; background: #f1f2f6; color: #636e72;
        }
        .tab-btn.active { background: var(--brand-color); color: white; }
        .btn-refresh { margin-left: auto; background: var(--brand-color); color: white; display: flex; align-items: center; gap: 8px; }

        /* Empty State */
        .empty-state {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            padding: 60px 0; text-align: center;
        }
        .mailbox-img { width: 120px; margin-bottom: 25px; filter: grayscale(1) opacity(0.5); }
        .empty-state h2 { font-size: 22px; color: var(--text-main); margin-bottom: 10px; }
        .empty-state p { color: #b2bec3; max-width: 400px; line-height: 1.6; font-size: 14px; }

        .message-table { width: 100%; border-collapse: collapse; }
        .message-table th { text-align: left; padding: 15px; border-bottom: 2px solid #f1f2f6; color: #b2bec3; font-size: 11px; text-transform: uppercase; }
        .message-table td { padding: 20px 15px; border-bottom: 1px solid #f1f2f6; font-size: 14px; }

        .admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; background: var(--brand-color); color: white;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        /* Back Button */
        .back-container { display: flex; justify-content: flex-end; margin-top: 30px; }
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
            <div class="header-icon-box"><i class="fas fa-comment-dots"></i></div>
            <h1>Contact<br><span style="font-weight: 400; font-size: 22px;">Messages</span></h1>
        </div>

        <div class="search-container">
            <i class="fas fa-search" style="color: var(--brand-color);"></i>
            <input type="text" id="msgInput" onkeyup="searchTable()" placeholder="Search messages...">
        </div>

        <div class="admin-profile">
            <strong style="font-size: 14px; margin-right: 10px;"><%= adminUser %></strong>
            <div class="avatar-circle">
                <%= (adminUser != null && adminUser.length() > 0) ? adminUser.substring(0,1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= totalCount %></div>
                <div class="stat-label">Total Messages</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-inbox"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= unreadCount %></div>
                <div class="stat-label">Unread</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-envelope-open"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= repliedCount %></div>
                <div class="stat-label">Replied</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-check-double"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= thisWeekCount %></div>
                <div class="stat-label">This Week</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-calendar-alt"></i></div>
        </div>
    </div>

    <div class="content-card">
        <div class="tab-bar">
            <button class="tab-btn active">All</button>
            <button class="tab-btn">Unread</button>
            <button class="tab-btn">Important</button>
            <button class="tab-btn">Archived</button>
            <button onclick="location.reload()" class="tab-btn btn-refresh"><i class="fas fa-sync-alt"></i> Refresh</button>
        </div>

        <% if (allMessages.isEmpty()) { %>
        <div class="empty-state">
            <img src="https://cdn-icons-png.flaticon.com/512/6591/6591000.png" class="mailbox-img" alt="Empty">
            <h2>No messages found</h2>
            <p>Form submissions from your contact page will appear here. Check back later or refresh to see new messages.</p>
        </div>
        <% } else { %>
        <table class="message-table" id="msgTable">
            <thead>
            <tr>
                <th>Sender</th>
                <th>Subject</th>
                <th>Message Snippet</th>
                <th style="text-align: right;">Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (allMessages != null && !allMessages.isEmpty()) {
                    for (Message m : allMessages) {
                        // 1. Logic to determine status for filtering
                        String status = "all";
                        // These methods must exist in Message.java to avoid the red errors
                        if (m.isRead()) status += " read"; else status += " unread";
                        if (m.isImportant()) status += " important";
                        if (m.isArchived()) status += " archived";
            %>
            <%-- Add class and data-status to the row --%>
            <tr class="message-row" data-status="<%= status %>">
                <td>
                    <div style="font-weight: 700; color: var(--text-main);"><%= m.getName() %></div>
                    <div style="font-size: 12px; color: var(--brand-color);"><%= m.getEmail() %></div>
                </td>
                <td style="font-weight: 600; color: var(--text-main);"><%= m.getSubject() %></td>
                <td style="color: #b2bec3; max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                    <%= m.getMessage() %>
                </td>
                <td style="text-align: right;">
                    <%-- Standardized View Button matching your monochrome theme --%>
                    <button class="tab-btn" style="background: var(--brand-light); color: var(--brand-color);"
                            onclick="alert('<%= m.getMessage().replace("'", "\\'") %>')">
                        View
                    </button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" style="text-align: center; padding: 60px; color: #b2bec3;">
                    <i class="fas fa-envelope-open" style="font-size: 40px; display: block; margin-bottom: 15px;"></i>
                    No messages found.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>

        <%-- Standardized Back Button --%>
        <div class="back-container">
            <button onclick="window.history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </button>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tabs = document.querySelectorAll('.tab-btn');
        const rows = document.querySelectorAll('.message-row');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active class from all tabs and add to clicked one
                tabs.forEach(t => t.classList.remove('active'));
                this.classList.add('active');

                const filter = this.innerText.toLowerCase();

                rows.forEach(row => {
                    const rowStatus = row.getAttribute('data-status').toLowerCase();

                    if (filter === 'all') {
                        row.style.display = '';
                    } else if (rowStatus.includes(filter)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });
    });
    function searchTable() {
        var input, filter, table, tr, td, i;
        input = document.getElementById("msgInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("msgTable");
        if(!table) return;
        tr = table.getElementsByTagName("tr");
        for (i = 1; i < tr.length; i++) {
            var rowText = tr[i].innerText.toUpperCase();
            tr[i].style.display = rowText.indexOf(filter) > -1 ? "" : "none";
        }
    }

</script>

</body>
</html>