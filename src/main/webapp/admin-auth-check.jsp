<%
    // 1. Get attributes from session
    String adminUser = (String) session.getAttribute("userName");
    String role = (String) session.getAttribute("userRole");

    // 2. THIS IS THE DEBUG CODE - Check your IntelliJ "Console" tab at the bottom
    System.out.println("--- Auth Check Debug ---");
    System.out.println("Session userName: [" + adminUser + "]");
    System.out.println("Session userRole: [" + role + "]");
    System.out.println("------------------------");

    // 3. Security logic
    if (adminUser == null || role == null || !role.equalsIgnoreCase("admin")) {
        System.out.println("!!! Access Denied: Redirecting to login !!!");
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }
%>