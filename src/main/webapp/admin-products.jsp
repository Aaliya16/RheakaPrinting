<%-- admin-products.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Variable 'adminUser' is provided by admin-auth-check.jsp
    String displayName = (adminUser != null && !adminUser.trim().isEmpty()) ? adminUser : "Admin";
    String avatarLetter = displayName.substring(0, 1).toUpperCase();

    // Sample data - replace with ProductDao logic (e.g., productDao.getAllProducts()) when ready
    String[][] products = {
            {"14", "Apron Custom", "Apparel", "16.00", "In Stock"},
            {"4", "Banner & Bunting", "Printing", "18.00", "In Stock"},
            {"3", "Apparel Printing", "Printing", "11.90", "In Stock"},
            {"15", "Acrylic Clear", "Signage", "47.00", "Out of Stock"}
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Management - Rheaka Printing</title>
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

        /* --- Main Content Layout --- */
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
        .header-title { display: flex; align-items: center; gap: 12px; color: var(--primary-dark); }

        .admin-profile { display: flex; align-items: center; gap: 15px; }
        .avatar-circle {
            width: 35px; height: 35px; background: #5f27cd; color: white;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

        .btn-add {
            background-color: var(--success-green); color: white; border: none; padding: 10px 20px;
            border-radius: 8px; font-weight: 600; cursor: pointer; display: flex;
            align-items: center; gap: 10px; transition: 0.2s;
        }
        .btn-add:hover { background-color: #27ae60; transform: translateY(-2px); }

        /* --- Content Card & Table --- */
        .content-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); }
        .filter-bar { margin-bottom: 25px; }
        .search-input { width: 100%; padding: 12px 15px; border: 1px solid #e0e0e0; border-radius: 8px; outline: none; }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 12px 15px; background: #fcfcfc; color: #7f8c8d; font-size: 11px; text-transform: uppercase; border-bottom: 2px solid #f1f1f1; }
        td { padding: 15px; border-bottom: 1px solid #f8f9fa; font-size: 14px; }

        .status-badge { padding: 5px 10px; border-radius: 6px; font-size: 10px; font-weight: 700; text-transform: uppercase; }
        .status-badge.in-stock { background: #d1e7dd; color: #0f5132; }
        .status-badge.out-stock { background: #f8d7da; color: #842029; }

        .btn-action { width: 35px; height: 35px; border-radius: 8px; border: none; cursor: pointer; transition: 0.2s; display: inline-flex; align-items: center; justify-content: center; }
        .btn-edit { background: #f0f7ff; color: var(--accent-blue); }
        .btn-delete { background: #fff5f5; color: var(--danger-red); margin-left: 5px; }
        .btn-action:hover { transform: scale(1.1); }

        /* --- Modal Styles --- */
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); backdrop-filter: blur(4px); }
        .modal-content { background: white; margin: 5% auto; padding: 30px; border-radius: 15px; width: 450px; animation: slideDown 0.3s ease; }
        @keyframes slideDown { from { transform: translateY(-20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; font-size: 13px; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; }
    </style>
</head>
<body>

<%-- Include the unified sidebar --%>
<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div class="header-title">
            <i class="fas fa-tag" style="font-size: 24px; color: var(--accent-blue);"></i>
            <h2>Products Management</h2>
        </div>
        <div class="admin-profile">
            <div class="avatar-circle"><%= avatarLetter %></div>
            <strong style="font-size: 14px;"><%= displayName %></strong>
        </div>
    </div>

    <div class="content-card">
        <div class="filter-action-bar" style="display: flex; flex-direction: column; gap: 15px; margin-bottom: 25px;">

            <div style="display: flex; gap: 15px;">
                <input type="text" class="search-input" id="searchInput"
                       placeholder="Search products..." onkeyup="filterTable()"
                       style="flex: 2; padding: 12px 15px; border: 1px solid #e0e0e0; border-radius: 8px; outline: none;">

                <select id="categoryFilter" onchange="filterTable()"
                        style="flex: 1; padding: 12px; border: 1px solid #e0e0e0; border-radius: 8px; outline: none; background: white; cursor: pointer;">
                    <option value="">All Categories</option>
                    <option value="Apparel">Apparel</option>
                    <option value="Printing">Printing</option>
                    <option value="Signage">Signage</option>
                    <option value="Stationery">Stationery</option>
                </select>

                <select id="statusFilter" onchange="filterTable()"
                        style="flex: 1; padding: 12px; border: 1px solid #e0e0e0; border-radius: 8px; outline: none; background: white; cursor: pointer;">
                    <option value="">All Status</option>
                    <option value="In Stock">In Stock</option>
                    <option value="Out of Stock">Out of Stock</option>
                </select>
            </div>

            <div style="display: flex; justify-content: flex-start;">
                <button type="button" class="btn-add" onclick="openModal('addModal')"
                        style="background-color: var(--success-green); color: white; border: none; padding: 10px 25px; border-radius: 8px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 10px; transition: 0.2s;">
                    <i class="fas fa-plus"></i> Add New Product
                </button>
            </div>
        </div>

        <table id="productsTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Status</th>
                <th style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%-- Your existing loop here --%>
            <% for (String[] product : products) {
                String statusClass = product[4].equalsIgnoreCase("In Stock") ? "in-stock" : "out-stock";
            %>
            <tr data-category="<%= product[2] %>" data-status="<%= product[4] %>">
                <td style="color: #7f8c8d;">#<%= product[0] %></td>
                <td><strong style="color: var(--primary-dark);"><%= product[1] %></strong></td>
                <td><%= product[2] %></td>
                <td style="font-weight: 600;">RM <%= product[3] %></td>
                <td><span class="status-badge <%= statusClass %>"><%= product[4] %></span></td>
                <td style="text-align: right;">
                    <button class="btn-action btn-edit" onclick="openEditModal('<%= product[0] %>', '<%= product[1] %>', '<%= product[2] %>', '<%= product[3] %>', '10')">
                        <i class="fas fa-edit"></i>
                    </button>
                    <a href="DeleteProductServlet?id=<%= product[0] %>" class="btn-action btn-delete" onclick="return confirm('Delete this product?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterTable() {
        let searchText = document.getElementById("searchInput").value.toLowerCase();
        let categoryValue = document.getElementById("categoryFilter").value.toLowerCase();
        let statusValue = document.getElementById("statusFilter").value.toLowerCase();

        let rows = document.querySelectorAll("#productsTable tbody tr");

        rows.forEach(row => {
            let productName = row.querySelector("strong").innerText.toLowerCase();
            let rowCategory = row.getAttribute("data-category").toLowerCase();
            let rowStatus = row.getAttribute("data-status").toLowerCase();

            // Check if row matches all filters
            let matchesSearch = productName.includes(searchText);
            let matchesCategory = categoryValue === "" || rowCategory === categoryValue;
            let matchesStatus = statusValue === "" || rowStatus === statusValue;

            if (matchesSearch && matchesCategory && matchesStatus) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }
</script>
</body>
</html>