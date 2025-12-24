<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.dao.ProductAdminDao" %>
<%@ page import="com.example.rheakaprinting.model.Product" %>
<%@ page import="java.util.List" %>
<%
    // Job 2: Security Check - Restrict access to Admins only
    String role = (String) session.getAttribute("userRole");
    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Rheaka Printing | Admin Panel</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display: flex; margin: 0; background: #f4f7f6; color: #333; }
        .sidebar { width: 240px; background: white; height: 100vh; padding: 20px; border-right: 1px solid #eee; position: fixed; }
        .main { margin-left: 280px; flex: 1; padding: 40px; }
        .card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 30px; }

        /* Form Styling */
        .form-group { margin-bottom: 15px; }
        input, select, textarea { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        textarea { height: 80px; resize: vertical; }

        .btn { background: linear-gradient(135deg, #9c27b0, #e91e63); color: white; border: none; padding: 12px 24px; border-radius: 6px; cursor: pointer; font-weight: bold; transition: opacity 0.3s; }
        .btn:hover { opacity: 0.9; }

        /* Table Styling */
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; }
        th { background: #f8f9fa; padding: 15px; text-align: left; border-bottom: 2px solid #eee; }
        td { padding: 15px; border-bottom: 1px solid #eee; }
        .action-link { color: #e91e63; text-decoration: none; font-weight: bold; }
        .action-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="sidebar">
    <h2 style="color: #d63384; margin-bottom: 30px;">Rheaka Printing</h2>
    <nav>
        <p style="cursor: pointer;">📊 Dashboard</p>
        <p style="cursor: pointer;">👥 Users</p>
        <p style="color: #e91e63; font-weight: bold; cursor: pointer;">📦 Services/Products</p>
        <p style="cursor: pointer;">🛒 Orders</p>
        <hr>
        <a href="logout" style="color: #666; text-decoration: none;">🚪 Logout</a>
    </nav>
</div>

<div class="main">
    <h1>Administrative Management</h1>

    <div class="card">
        <h3>Add New Service</h3>
        <form action="manageProduct" method="POST">
            <input type="hidden" name="action" value="add">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="productName" placeholder="e.g. Business Card Printing" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category">
                        <option value="Printing">Printing Services</option>
                        <option value="Design">Design Services</option>
                        <option value="Merchandise">Merchandise</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (RM)</label>
                    <input type="number" name="price" step="0.01" placeholder="0.00" required>
                </div>
                <div class="form-group">
                    <label>Initial Stock Count</label>
                    <input type="number" name="stock" placeholder="100" required>
                </div>
                <div class="form-group">
                    <label>Image Path/URL</label>
                    <input type="text" name="image" placeholder="assets/images/product1.jpg">
                </div>
                <div class="form-group">
                    <label>Default Quantity</label>
                    <input type="number" name="quantity" value="1" required>
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" placeholder="Brief details about the service..."></textarea>
            </div>
            <button type="submit" class="btn">+ Register Service</button>
        </form>
    </div>

    <div class="card">
        <h3>Current Active Catalog</h3>
        <table>
            <thead>
            <tr>
                <th>Product</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                ProductAdminDao dao = new ProductAdminDao();
                List<Product> products = dao.getAllProducts();
                if (products != null && !products.isEmpty()) {
                    for (Product p : products) {
            %>
            <tr>
                <td>
                    <strong><%= p.getName() %></strong><br>
                    <small style="color: #888;"><%= p.getDescription() != null ? p.getDescription() : "No description" %></small>
                </td>
                <td><%= p.getCategory() %></td>
                <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                <td><%= p.getStock() %> units</td>
                <td>
                    <a href="manageProduct?id=<%= p.getId() %>"
                       class="action-link"
                       onclick="return confirm('Delete this service permanently?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center; color: #999; padding: 30px;">No products found in the database.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>