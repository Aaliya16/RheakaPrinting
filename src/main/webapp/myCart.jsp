<%--
  Created by IntelliJ IDEA.
  User: MSI MODERN 15
  Date: 19/12/2025
  Time: 1:25 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rheakaprinting.model.DbConnection" %>
<%@ page import="java.sql.*"%>
<%@ include file="header.jsp" %>
<%@ include file="footer.jsp" %>
<!DOCTYPE>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart</title>
    <style>
        h3{
            color: black;
            text-align: center;
        }
    </style>
</head>
<body>
<div style="color: white; text-align: center; font-size: 30px;">My Cart </div>
<%
    String msg= request.getParameter("msg");
    if("notPossible".equals(msg)){
        %><h3 class="alert">There is only one Quantity! So click on remove!</h3>
    <%} %>
<%
    if("inc".equals(msg)){
        %><h3 class="alert">Quantity  Increased Successfully!</h3>
    <%} %>
<%
    if("dec".equals(msg)){
        %><h3 class="alert">Quantity  Decreased Successfully!</h3>
    <%} %>
<%
    if("dec".equals(msg)){
        %><h3 class="alert"><h3 class="alert">Product Successfully Removed!</h3>
    <%} %>
<table>
    <thead>
        <tr>
            <th scope="col" style="background-color: lightblue;">Total: </th>
            <th scope="col"><a href="">Proceed to order</a></th>
        </tr>
    </thead>
    <thead>
        <tr>
            <th scope="col">S.No</th>
            <th scope="col">Product Name</th>
            <th scope="col">Category</th>
            <th scope="col"><i class="fa fa-inr"></i> price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Sub Total</th>
            <th scope="col">Remove <i class='fas fa-trash-alt'></i></th>
        </tr>
    </thead>
</table>
</body>
</html>
