<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.*, com.example.rheakaprinting.dao.*, java.util.*" %>
<%@ include file="admin-auth-check.jsp" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProductDao pDao = new ProductDao(DbConnection.getConnection());
    Product p = pDao.getSingleProduct(id); // Ensure this method exists in your DAO
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Product - Rheaka Printing</title>
</head>
<body>
<%@ include file="admin-sidebar.jsp" %>
<div class="main-content">
    <div class="top-bar">
        <h1>Edit Product #<%= p.getId() %></h1>
    </div>
    <div class="content-card">
        <form action="UpdateProductServlet" method="POST">
            <input type="hidden" name="id" value="<%= p.getId() %>">
            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" value="<%= p.getName() %>" required>
            </div>
            <div class="form-group">
                <label>Price</label>
                <input type="number" step="0.01" name="price" value="<%= p.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label>Stock Quantity</label>
                <input type="number" name="quantity" value="<%= p.getQuantity() %>" required>
            </div>
            <button type="submit" class="btn-add">Update Product</button>
        </form>
    </div>
</div>
</body>
</html>
