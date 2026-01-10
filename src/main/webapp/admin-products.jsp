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

    ProductDao pDao = new ProductDao(DbConnection.getConnection());
    List<Product> allProducts = pDao.getAllProducts();

    if (allProducts == null) {
        allProducts = new ArrayList<>();
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
            --primary-dark: #1a3a6d;
            --accent-blue: #3498db;
            --success-green: #2ecc71;
            --danger-red: #ee5253;
            --bg-body: #f8f9fc;
        }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg-body); color: #333; }

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
            height: 70px; /* Matches dashboard */
        }
        .top-bar h1 {
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

        .btn-add {
            background-color: var(--success-green); color: white; border: none; padding: 10px 20px;
            border-radius: 8px; font-weight: 600; cursor: pointer; display: flex;
            align-items: center; gap: 10px; transition: 0.2s;
        }
        .btn-add:hover { background-color: #27ae60; transform: translateY(-2px); }

        .search-input { width: 100%; padding: 12px 15px; border: 1px solid #e0e0e0; border-radius: 8px; outline: none; }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 12px 15px; background: #fcfcfc; color: #7f8c8d; font-size: 11px; text-transform: uppercase; border-bottom: 2px solid #f1f1f1; }
        td { padding: 15px; border-bottom: 1px solid #f8f9fa; font-size: 14px; }

        .status-badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .in-stock { background: #d1e7dd; color: #0f5132; }
        .out-of-stock { background: #f8d7da; color: #842029; }

        .btn-action { width: 35px; height: 35px; border-radius: 8px; border: none; cursor: pointer; transition: 0.2s; display: inline-flex; align-items: center; justify-content: center; }
        .btn-edit { background: #f0f7ff; color: var(--accent-blue); }
        .btn-delete { background: #fff5f5; color: var(--danger-red); margin-left: 5px; }
        .btn-action:hover { transform: scale(1.1); }

        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); backdrop-filter: blur(4px); }
        .modal-content { background: white; margin: 5% auto; padding: 30px; border-radius: 15px; width: 450px; animation: slideDown 0.3s ease; }
        @keyframes slideDown { from { transform: translateY(-20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; font-size: 13px; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; }
    </style>
</head>
<body>

<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <div class="header-title">
            <i class="fas fa-tag" style="font-size: 24px; color: var(--accent-blue);"></i>
            <h2>Products Management</h2>
        </div>
        <div class="admin-profile">
            <strong style="font-size: 14px;"><%= displayName %></strong>
            <div class="avatar-circle"><%= avatarLetter %></div>
        </div>
    </div>

    <div class="content-card">
        <div class="filter-action-bar" style="display: flex; flex-direction: column; gap: 15px; margin-bottom: 25px;">
            <div style="display: flex; gap: 15px;">
                <input type="text" class="search-input" id="searchInput"
                       placeholder="Search products..." onkeyup="filterTable()"
                       style="flex: 2;">

                <select id="categoryFilter" onchange="filterTable()" style="flex: 1; padding: 12px; border: 1px solid #e0e0e0; border-radius: 8px; background: white; cursor: pointer;">
                    <option value="">All Categories</option>
                    <option value="Apparel">Apparel</option>
                    <option value="Printing">Printing</option>
                    <option value="Signage">Signage</option>
                    <option value="Stationery">Stationery</option>
                </select>

                <select id="statusFilter" onchange="filterTable()" style="flex: 1; padding: 12px; border: 1px solid #e0e0e0; border-radius: 8px; background: white; cursor: pointer;">
                    <option value="">All Status</option>
                    <option value="In Stock">In Stock</option>
                    <option value="Out of Stock">Out of Stock</option>
                </select>
            </div>

            <div style="display: flex; justify-content: flex-start;">
                <button type="button" class="btn-add" onclick="openAddModal()">
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
            <% for (Product p : allProducts) { %>
            <tr data-category="<%= p.getCategory() %>" data-status="<%= (p.getQuantity() > 0) ? "In Stock" : "Out of Stock" %>">
                <td>#<%= p.getId() %></td>
                <td><strong><%= p.getName() %></strong></td>
                <td><%= p.getCategory() %></td>
                <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                <td>
                    <span class="status-badge <%= (p.getQuantity() > 0) ? "in-stock" : "out-of-stock" %>">
                        <%= (p.getQuantity() > 0) ? "In Stock" : "Out of Stock" %>
                    </span>
                </td>
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
    </div>
</div>

<div id="productModal" class="modal">
    <div class="modal-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 id="modalTitle">Add New Product</h2>
            <span onclick="closeModal()" style="cursor: pointer; font-size: 24px;">&times;</span>
        </div>
        <form action="AddProductServlet" method="POST" id="productForm">
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
                    <option value="Stationery">Stationery</option>
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
            <div style="display: flex; gap: 10px; margin-top: 20px;">
                <button type="submit" class="btn-add" id="submitBtn" style="flex: 1; justify-content: center;">Save Product</button>
                <button type="button" onclick="closeModal()" style="flex: 1; background: #eee; border: none; border-radius: 8px; cursor: pointer;">Cancel</button>
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