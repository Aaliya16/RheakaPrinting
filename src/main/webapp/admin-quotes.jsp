<%-- admin-quotes.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*, com.example.rheakaprinting.dao.*, java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    QuoteDao qDao = new QuoteDao(DbConnection.getConnection());
    List<Quote> allQuotes = qDao.getAllQuotes();

    // Header logic similar to settings
    String displayName = (adminUser != null && !adminUser.trim().isEmpty()) ? adminUser : "Admin";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quote Management - Rheaka Printing</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --brand-color: #6c5ce7;
            --brand-light: rgba(108, 92, 231, 0.1);
            --bg-body: #f1f2f6;
            --text-main: #2d3436;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            color: var(--text-main);
        }

        /* Consistent Sidebar and Content Layout */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 30px;
            opacity: 0;
            will-change: transform, opacity;
            animation: smoothSlideUp 0.7s cubic-bezier(0.22, 1, 0.36, 1) forwards;
        }

        @keyframes smoothSlideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Staggered Row Animation */
        tbody tr {
            opacity: 0;
            animation: rowAppear 0.5s ease-out forwards;
        }
        tbody tr:nth-child(1) { animation-delay: 0.2s; }
        tbody tr:nth-child(2) { animation-delay: 0.3s; }
        tbody tr:nth-child(3) { animation-delay: 0.4s; }

        @keyframes rowAppear {
            from { opacity: 0; transform: translateX(-10px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .top-bar {
            background: white; padding: 20px 35px; border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin-bottom: 30px;
            display: flex; justify-content: space-between; align-items: center;
        }

        .header-left { display: flex; align-items: center; gap: 20px; }
        .header-icon-box {
            width: 50px; height: 50px; min-width: 50px;
            background: var(--brand-color); border-radius: 15px;
            display: flex; align-items: center; justify-content: center; color: white;
        }
        .header-icon-box i { font-size: 22px; }

        .top-bar h1 { font-size: 24px; color: var(--text-main); margin: 0; line-height: 1.2; }

        .search-container {
            background: #f1f2f6; border-radius: 12px; padding: 10px 20px;
            display: flex; align-items: center; gap: 10px; width: 400px;
        }
        .search-container input { border: none; background: transparent; outline: none; width: 100%; font-size: 14px; }

        .admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--brand-color); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        .content-card {
            background: white; padding: 30px; border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
        }

        .tab-bar { display: flex; gap: 10px; margin-bottom: 25px; align-items: center; }
        .tab-btn {
            padding: 8px 20px; border-radius: 10px; border: none; font-weight: 600;
            font-size: 13px; cursor: pointer; transition: 0.2s; background: #f1f2f6; color: #636e72;
        }
        .tab-btn.active { background: var(--brand-color); color: white; }

        /* Table and Pill Styling */
        .message-table { width: 100%; border-collapse: collapse; }
        .message-table th { text-align: left; padding: 15px; border-bottom: 2px solid #f1f2f6; color: #b2bec3; font-size: 11px; text-transform: uppercase; }
        .message-table td { padding: 20px 15px; border-bottom: 1px solid #f1f2f6; font-size: 14px; }

        .status-pill {
            padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 700;
            cursor: pointer; transition: 0.3s; display: inline-block;
        }
        .status-review { background: #fff4e6; color: #d9480f; border: 1px solid #ffd8a8; }
        .status-completed { background: #ebfbee; color: #2b8a3e; border: 1px solid #b2f2bb; }

        .file-link { color: var(--brand-color); text-decoration: none; font-weight: 600; font-size: 13px; }
        .file-link:hover { text-decoration: underline; }

        .back-container { display: flex; justify-content: flex-end; margin-top: 30px; }
        .btn-back {
            display: flex; align-items: center; gap: 8px; padding: 12px 25px;
            background: white; color: var(--brand-color); border: 2px solid var(--brand-color);
            border-radius: 12px; font-weight: 700; font-size: 14px; cursor: pointer; transition: 0.3s;
        }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div class="header-left">
            <div class="header-icon-box"><i class="fas fa-file-invoice-dollar"></i></div>
            <h1>Quote<br><span style="font-weight: 400; font-size: 22px;">Requests</span></h1>
        </div>

        <div class="search-container">
            <i class="fas fa-search" style="color: var(--brand-color);"></i>
            <input type="text" id="quoteSearch" onkeyup="searchTable()" placeholder="Search by name or product...">
        </div>

        <div class="admin-profile">
            <div class="avatar-circle">
                <%= (displayName != null && !displayName.isEmpty()) ? displayName.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <div class="content-card">
        <div class="tab-bar">
            <button class="tab-btn active">All</button>
            <button class="tab-btn">Under Review</button>
            <button class="tab-btn">Completed</button>
        </div>

        <table class="message-table" id="quoteTable">
            <thead>
            <tr>
                <th>Customer</th>
                <th>Product & Qty</th>
                <th>Design File</th>
                <th>Status</th>
                <th style="text-align: right;">Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Quote q : allQuotes) {
                String statusClass = q.getStatus().equalsIgnoreCase("Completed") ? "status-completed" : "status-review";
            %>
            <tr class="message-row" data-status="<%= q.getStatus().toLowerCase() %>">
                <td>
                    <div style="font-weight: 700;"><%= q.getName() %></div>
                    <div style="font-size: 11px; color: #b2bec3;"><%= q.getEmail() %></div>
                </td>
                <td>
                    <div style="font-weight: 600;"><%= q.getProduct() %></div>
                    <div style="font-size: 12px; color: var(--brand-color);">Qty: <%= q.getQuantity() %></div>
                </td>
                <td>
                    <% if (q.getFilePath() != null && !q.getFilePath().isEmpty()) { %>
                    <a href="<%= q.getFilePath() %>" target="_blank" class="file-link">
                        <i class="fas fa-paperclip"></i> <%= q.getFileName() %>
                    </a>
                    <% } else { %>
                    <span style="color: #ccc; font-size: 12px;">No Attachment</span>
                    <% } %>
                </td>
                <td>
                    <span class="status-pill <%= statusClass %>" onclick="toggleStatus(<%= q.getQuoteId() %>, this)">
                        <%= q.getStatus() %>
                    </span>
                </td>
                <td style="text-align: right; white-space: nowrap;">
                    <%-- NEW: Complete Button added here --%>
                    <% if (!q.getStatus().equalsIgnoreCase("Completed")) { %>
                    <button class="tab-btn"
                            style="background: #2ecc71; color: white; margin-right: 5px;"
                            onclick="markAsCompleted(<%= q.getQuoteId() %>, this)">
                        Complete
                    </button>
                    <% } %>
                    <button class="tab-btn" onclick="alert('<%= q.getNote().replace("'", "\\'") %>')">View Note</button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="back-container">
            <button onclick="window.history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </button>
        </div>
    </div>
</div>

<script>
    // Tab Filtering Logic
    document.querySelectorAll('.tab-btn').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.tab-btn').forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            const filter = this.innerText.trim().toLowerCase();
            document.querySelectorAll('.message-row').forEach(row => {
                const status = row.getAttribute('data-status');
                row.style.display = (filter === 'all' || status.includes(filter)) ? '' : 'none';
            });
        });
    });

    function searchTable() {
        var input = document.getElementById("quoteSearch");
        var filter = input.value.toUpperCase();
        var rows = document.querySelectorAll("#quoteTable tbody tr");
        rows.forEach(row => {
            row.style.display = row.innerText.toUpperCase().includes(filter) ? "" : "none";
        });
    }

    function toggleStatus(id, element) {
        const currentStatus = element.innerText;
        const newStatus = (currentStatus === 'Completed') ? 'Under Review' : 'Completed';
        element.innerText = newStatus;
        element.className = 'status-pill ' + (newStatus === 'Completed' ? 'status-completed' : 'status-review');
        element.closest('tr').setAttribute('data-status', newStatus.toLowerCase());
        fetch('UpdateQuoteStatusServlet?id=' + id + '&status=' + newStatus);
    }

    // NEW: Function to handle the Completed button action
    function markAsCompleted(id, btn) {
        if (confirm("Mark this quote as completed?")) {
            const row = btn.closest('tr');

            // 1. Update status attribute for filtering
            row.setAttribute('data-status', 'all completed');

            // 2. Update status pill visually
            const pill = row.querySelector('.status-pill');
            if (pill) {
                pill.innerText = 'Completed';
                pill.className = 'status-pill status-completed';
            }

            // 3. Remove the button instantly
            btn.remove();

            // 4. If in "Under Review" tab, hide the row
            const activeTab = document.querySelector('.tab-btn.active').innerText.trim();
            if (activeTab === "Under Review") {
                row.style.display = 'none';
            }

            // 5. Update database
            fetch('UpdateQuoteStatusServlet?id=' + id + '&status=Completed');
        }
    }
</script>
</body>
</html>