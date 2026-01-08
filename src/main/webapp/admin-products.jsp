<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/1/2026
  Time: 3:00 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 1. Retrieve the User object using the "auth" key from Login.java
    com.example.rheakaprinting.model.User authUser = (com.example.rheakaprinting.model.User) session.getAttribute("auth");

    // 2. Security: Redirect if not logged in or not an admin
    if (authUser == null || !"admin".equalsIgnoreCase(authUser.getRole())) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return; // Stops unauthorized content from loading
    }

    // 3. Set name for the sidebar/topbar
    String adminUser = authUser.getName();

    // Sample products data (Keep this for now as you requested)
    String[][] products = {
            {"14", "Apron Custom", "Apparel", "16.00", "In Stock"},
            {"4", "Banner & Bunting", "Printing", "18.00", "In Stock"},
            {"3", "Apparel Printing", "Printing", "11.90", "In Stock"},
            {"15", "Acrylic Clear", "Signage", "47.00", "In Stock"}
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Management - Admin Panel</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #2c3e50;
            --accent: #3498db;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
        }

        /* Sidebar (copy from dashboard) */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 250px;
            height: 100vh;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 20px;
            overflow-y: auto;
        }

        .sidebar-header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 30px;
        }

        .sidebar-header h2 { font-size: 24px; margin-bottom: 5px; }
        .sidebar-header p { font-size: 12px; color: #bdc3c7; }

        .nav-menu { list-style: none; }
        .nav-item { margin-bottom: 5px; }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            color: #ecf0f1;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(52, 152, 219, 0.2);
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .top-bar {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar h1 {
            color: var(--primary);
            font-size: 28px;
        }

        .btn-add {
            background: var(--success);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-add:hover {
            background: #27ae60;
            transform: translateY(-2px);
        }

        /* Products Table */
        .products-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 25px;
        }

        .search-bar {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-bar input {
            flex: 1;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
        }

        .search-bar input:focus {
            outline: none;
            border-color: var(--accent);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8f9fa;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--primary);
            border-bottom: 2px solid #e0e0e0;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-badge.in-stock {
            background: #d4edda;
            color: #155724;
        }

        .status-badge.out-stock {
            background: #f8d7da;
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-icon {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-edit {
            background: #e3f2fd;
            color: var(--accent);
        }

        .btn-edit:hover {
            background: var(--accent);
            color: white;
        }

        .btn-delete {
            background: #ffebee;
            color: var(--danger);
        }

        .btn-delete:hover {
            background: var(--danger);
            color: white;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h2>🛡️ ADMIN</h2>
        <p>Rheaka Printing</p>
    </div>

    <ul class="nav-menu">
        <li class="nav-item">
            <a href="admin_dashboard.jsp" class="nav-link">
                <span>📊</span>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="admin-orders.jsp" class="nav-link">
                <span>📦</span>
                <span>Orders</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="admin-products.jsp" class="nav-link active">
                <span>🏷️</span>
                <span>Products</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="admin-users.jsp" class="nav-link">
                <span>👥</span>
                <span>Users</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="admin-settings.jsp" class="nav-link">
                <span>⚙️</span>
                <span>Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="top-bar">
        <h1>Products Management</h1>
        <a href="#" class="btn-add">
            <span>➕</span>
            <span>Add New Product</span>
        </a>
    </div>

    <div class="products-container">
        <div class="search-bar">
            <input type="text" placeholder="🔍 Search products..." id="searchInput">
            <select style="padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px;">
                <option>All Categories</option>
                <option>Apparel</option>
                <option>Printing</option>
                <option>Signage</option>
            </select>
        </div>

        <table id="productsTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Category</th>
                <th>Price (RM)</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (String[] product : products) { %>
            <tr>
                <td>#<%= product[0] %></td>
                <td><strong><%= product[1] %></strong></td>
                <td><%= product[2] %></td>
                <td>RM <%= product[3] %></td>
                <td>
                        <span class="status-badge <%= product[4].equals("In Stock") ? "in-stock" : "out-stock" %>">
                            <%= product[4] %>
                        </span>
                </td>
                <td>
                    <div class="action-buttons">
                        <button class="btn-icon btn-edit" onclick="editProduct(<%= product[0] %>)">
                            ✏️ Edit
                        </button>
                        <button class="btn-icon btn-delete" onclick="deleteProduct(<%= product[0] %>)">
                            🗑️ Delete
                        </button>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    // Search functionality
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();
        const rows = document.querySelectorAll('#productsTable tbody tr');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(searchTerm) ? '' : 'none';
        });
    });

    function editProduct(id) {
        alert('Edit product #' + id + ' (implement later)');
    }

    function deleteProduct(id) {
        if (confirm('Are you sure you want to delete product #' + id + '?')) {
            alert('Product deleted (implement later)');
        }
    }
</script>

</body>
</html>