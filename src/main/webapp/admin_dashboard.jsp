<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rheakaprinting.model.*" %>
<%
    // Job 2: Security Check
    String role = (String) session.getAttribute("userRole");
    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Rheaka Printing Admin</title>
    <style>
        body { font-family: Arial; display: flex; margin: 0; background: #f4f7f6; }
        .sidebar { width: 240px; background: white; height: 100vh; padding: 20px; border-right: 1px solid #eee; }
        .main { flex: 1; padding: 40px; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .btn { background: linear-gradient(to right, #9c27b0, #e91e63); color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
<div class="sidebar">
    <h2 style="color: #d63384;">Rheaka Printing</h2>
    <p>Dashboard</p>
    <p>Users</p>
    <p style="color: #e91e63; font-weight: bold;">Products</p>
    <p>Orders</p>
</div>

<div class="main">
    <h1>Services Management</h1>

    <div class="card">
        <h3>Add New Product</h3>
        <form action="manageProduct" method="POST">
            <input type="hidden" name="action" value="add">
            <input type="text" name="productName" placeholder="Product Name" required>
            <select name="category">
                <option value="Printing">Printing</option>
                <option value="Design">Design</option>
            </select>
            <input type="number" name="price" step="0.01" placeholder="Price" required>
            <button type="submit" class="btn">+ Add Service</button>
        </form>
    </div>

    <div class="card">
        <h3>Current Products</h3>
        <table width="100%">
            <tr>
                <th>Name</th><th>Category</th><th>Price</th><th>Actions</th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>