<%-- admin-products.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*" %>
<%@ page import="com.example.rheakaprinting.dao.*" %>
<%@ page import="java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    // Logic remains exactly the same
    String displayName = (adminUser != null && !adminUser.trim().isEmpty()) ? adminUser : "Admin";
    String avatarLetter = displayName.substring(0, 1).toUpperCase();

    ProductDao pDao = new ProductDao(DbConnection.getConnection());
    List<Product> allProducts = pDao.getAllProducts();

    if (allProducts == null) {
        allProducts = new ArrayList<>();
    }

    int totalProducts = allProducts.size();
    int outOfStock = 0;
    int lowStock = 0;
    for (Product p : allProducts) {
        if (p.getQuantity() <= 0) outOfStock++;
        else if (p.getQuantity() < 5) lowStock++;
    }
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
            --brand-color: #6c5ce7; /* Single professional purple */
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

        /* Fixed Icon Sizes to match Dashboard exactly */
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
        .header-icon-box i { font-size: 22px; } /* Standardized icon size */

        .top-bar h1 { font-size: 24px; color: var(--text-main); margin: 0; line-height: 1.2; }

        .search-container {
            background: #f1f2f6; border-radius: 12px; padding: 10px 20px;
            display: flex; align-items: center; gap: 10px; width: 350px;
        }
        .search-container input { border: none; background: transparent; outline: none; width: 100%; font-size: 14px; }

        .admin-profile { display: flex; align-items: center; gap: 12px; }
        .avatar-circle {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--brand-color); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }

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

        .btn-add {
            background-color: var(--brand-color); color: white; border: none; padding: 10px 25px;
            border-radius: 12px; font-weight: 600; cursor: pointer; display: flex;
            align-items: center; gap: 10px; transition: 0.2s;
        }
        .btn-add:hover { opacity: 0.9; transform: translateY(-2px); }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; color: #b2bec3; font-size: 11px; text-transform: uppercase; border-bottom: 2px solid #f1f2f6; }
        td { padding: 20px 15px; border-bottom: 1px solid #f1f2f6; font-size: 14px; }

        .status-badge {
            padding: 6px 12px; border-radius: 8px; font-size: 11px;
            font-weight: 700; text-transform: uppercase;
        }
        .in-stock { background: #d1e7dd; color: #0f5132; }
        .out-of-stock { background: #f8d7da; color: #842029; }

        .btn-action { width: 35px; height: 35px; border-radius: 10px; border: none; cursor: pointer; transition: 0.2s; display: inline-flex; align-items: center; justify-content: center; }
        .btn-edit { background: var(--brand-light); color: var(--brand-color); }
        .btn-delete { background: #fff5f5; color: var(--danger-red); margin-left: 5px; }
        .btn-action:hover { transform: scale(1.1); }

        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); backdrop-filter: blur(4px); }
        .modal-content { background: white; margin: 5% auto; padding: 30px; border-radius: 25px; width: 450px; animation: slideDown 0.3s ease; }
        @keyframes slideDown { from { transform: translateY(-20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 700; font-size: 13px; color: #b2bec3; text-transform: uppercase;}
        .form-group input, .form-group select { width: 100%; padding: 12px; border: 1px solid #f1f2f6; background: #f1f2f6; border-radius: 12px; outline: none;}

        /* Back Button */
        .back-container { display: flex; justify-content: flex-end; margin-top: 25px; }
        .btn-back {
            display: flex; align-items: center; gap: 8px; padding: 10px 20px;
            background: white; color: var(--brand-color); border: 2px solid var(--brand-color);
            border-radius: 12px; font-weight: 700; font-size: 13px; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { background: var(--brand-color); color: white; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <%-- Standardized Top Bar --%>
    <div class="top-bar">
        <div class="header-left">
            <div class="header-icon-box"><i class="fas fa-tag"></i></div>
            <h1>Products<br><span style="font-weight: 400; font-size: 22px;">Management</span></h1>
        </div>

        <div class="search-container">
            <i class="fas fa-search" style="color: var(--brand-color);"></i>
            <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search products...">
        </div>

        <%-- Profile section with "Admin" text removed --%>
        <div class="admin-profile">
            <div class="avatar-circle">
                <%= (displayName != null && !displayName.isEmpty()) ? displayName.substring(0, 1).toUpperCase() : "A" %>
            </div>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= totalProducts %></div>
                <div class="stat-label">Total Items</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-boxes"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= outOfStock %></div>
                <div class="stat-label">Out of Stock</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-exclamation-triangle"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val"><%= lowStock %></div>
                <div class="stat-label">Low Stock</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-chart-line"></i></div>
        </div>
        <div class="stat-card">
            <div>
                <div class="stat-val">Live</div>
                <div class="stat-label">Sync Status</div>
            </div>
            <div class="stat-icon-mini"><i class="fas fa-sync"></i></div>
        </div>
    </div>

    <div class="content-card">
        <div class="filter-action-bar" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <div style="display: flex; gap: 15px;">
                <select id="categoryFilter" onchange="filterTable()" style="padding: 10px 20px; border: none; border-radius: 12px; background: #f1f2f6; cursor: pointer; outline: none; font-size: 13px;">
                    <option value="">All Categories</option>
                    <option value="Apparel">Apparel</option>
                    <option value="Printing">Printing</option>
                    <option value="Signage">Signage</option>
                    <option value="Stationery">Stationery</option>
                </select>

                <select id="statusFilter" onchange="filterTable()" style="padding: 10px 20px; border: none; border-radius: 12px; background: #f1f2f6; cursor: pointer; outline: none; font-size: 13px;">
                    <option value="">All Status</option>
                    <option value="In Stock">In Stock</option>
                    <option value="Out of Stock">Out of Stock</option>
                </select>
            </div>

            <button type="button" class="btn-add" onclick="openAddModal()">
                <i class="fas fa-plus"></i> Add New Product
            </button>
        </div>

        <table id="productsTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Product Details</th>
                <th>Category</th>
                <th>Price</th>
                <th>Status</th>
                <th>Quantity</th>
                <th style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Product p : allProducts) { %>
            <tr data-category="<%= p.getCategory() %>" data-status="<%= (p.getQuantity() > 0) ? "In Stock" : "Out of Stock" %>">
                <td>#<%= p.getId() %></td>
                <td><strong><%= p.getName() %></strong></td>
                <td><%= p.getCategory() %></td>
                <td style="font-weight: 700;">RM <%= String.format("%.2f", p.getPrice()) %></td>
                <td>
                    <span class="status-badge <%= (p.getQuantity() > 0) ? "in-stock" : "out-of-stock" %>">
                        <%= (p.getQuantity() > 0) ? "In Stock" : "Out of Stock" %>
                    </span>
                </td>
                <td style="font-weight: 700; color: var(--text-main);"><%= p.getQuantity() %> units</td>
                <td style="text-align: right;">
                    <button class="btn-action btn-edit" title="Edit"
                            onclick="openEditModal('<%= p.getId() %>', '<%= p.getName().replace("'", "\\'") %>', '<%= p.getCategory() %>', '<%= p.getPrice() %>', '<%= p.getQuantity() %>')">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-action btn-delete" title="Delete"
                            onclick="confirmDelete('<%= p.getId() %>', '<%= p.getName().replace("'", "\\'") %>')">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <%-- Standardized Back Button --%>
        <div class="back-container">
            <button onclick="window.history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </button>
        </div>
    </div>
</div>

<div id="productModal" class="modal">
    <div class="modal-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <h2 id="modalTitle" style="color: var(--brand-color);">Add New Product</h2>
            <span onclick="closeModal()" style="cursor: pointer; font-size: 24px; color: #b2bec3;">&times;</span>
        </div>
        <form id="productForm" action="UpdateProductServlet" method="POST">
            <input type="hidden" name="id" id="prodId">
            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" id="prodName" required>
            </div>
            <div class="form-group">
                <label>Category</label>
                <select name="category" id="prodCategory" required>
                    <option value="Apparel">Apparel</option>
                    <option value="Printing">Printing</option>
                    <option value="Signage">Signage</option>
                    <option value="Sticker">Large Format</option>
                    <option value="Large Format">Large Format</option>
                    <option value="Others">Others</option>
                </select>
            </div>
            <div class="form-group">
                <label>Price (RM)</label>
                <input type="number" step="0.01" name="price" id="prodPrice" required>
            </div>
            <div class="form-group">
                <label>Stock Quantity</label>
                <input type="number" name="quantity" id="prodQuantity" required>
            </div>
            <div style="display: flex; gap: 10px; margin-top: 25px;">
                <button type="submit" class="btn-add" id="submitBtn" style="flex: 1; justify-content: center;">Save Product</button>
                <button type="button" onclick="closeModal()" style="flex: 1; background: #f1f2f6; border: none; border-radius: 12px; cursor: pointer; color: #636e72; font-weight: 600;">Cancel</button>
            </div>
        </form>
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

            let matchesSearch = productName.includes(searchText);
            let matchesCategory = categoryValue === "" || rowCategory === categoryValue;
            let matchesStatus = statusValue === "" || rowStatus === statusValue;

            row.style.display = (matchesSearch && matchesCategory && matchesStatus) ? "" : "none";
        });
    }

    function confirmDelete(productId, productName) {
        if (confirm("Are you sure you want to delete '" + productName + "'?\nThis action cannot be undone.")) {
            window.location.href = "DeleteProductServlet?id=" + productId;
        }
    }

    function openEditModal(id, name, category, price, quantity) {
        document.getElementById('modalTitle').innerText = "Edit Product";
        document.getElementById('submitBtn').innerText = "Update Product";
        document.getElementById('productForm').action = "UpdateProductServlet";

        document.getElementById('prodId').value = id;
        document.getElementById('prodName').value = name;
        document.getElementById('prodCategory').value = category;
        document.getElementById('prodPrice').value = price;
        document.getElementById('prodQuantity').value = quantity;

        document.getElementById('productModal').style.display = "block";
    }

    function openAddModal() {
        document.getElementById('modalTitle').innerText = "Add New Product";
        document.getElementById('submitBtn').innerText = "Save Product";
        document.getElementById('productForm').action = "AddProductServlet";
        document.getElementById('productForm').reset();
        document.getElementById('prodId').value = "";
        document.getElementById('productModal').style.display = "block";
    }

    function closeModal() {
        document.getElementById('productModal').style.display = "none";
    }

    window.onclick = function(event) {
        let modal = document.getElementById('productModal');
        if (event.target == modal) {
            closeModal();
        }
    }
</script>
</body>
</html>