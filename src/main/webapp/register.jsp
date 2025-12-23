<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 20/12/2025
  Time: 12:24 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - Rheaka Printing</title>
</head>
<body>
<h2>Create a New Account</h2>

<%-- Show an error message if the registration fails --%>
<% if(request.getParameter("msg") != null && request.getParameter("msg").equals("failed")) { %>
<p style="color:red;">Registration failed. Please try again.</p>
<% } %>

<form action="RegisterServlet" method="POST">
    <label>Full Name:</label><br>
    <input type="text" name="fullName" required><br><br>

    <label>Email Address:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Username:</label><br>
    <input type="text" name="username" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Register Account</button>
</form>

<p>Already have an account? <a href="login.jsp">Login here</a></p>
</body>
</html>
