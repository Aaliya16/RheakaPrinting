package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.UserDAO;
import com.example.rheakaprinting.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// Change this line at the top of LoginServlet.java
@WebServlet(name = "LoginServlet", value = {"/LoginServlet", "/login"})
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Pass the database connection into the constructor
        UserDAO dao = new UserDAO(com.example.rheakaprinting.model.DbConnection.getConnection());
        User validUser = dao.authenticate(email, password);

        if (validUser != null) {

            String role = validUser.getRole();
            System.out.println("Login successful - User: " + validUser.getName() + ", Role: " + role);

            HttpSession session = request.getSession();
            session.setAttribute("currentUser", validUser);
            session.setAttribute("userRole", role); // Use the role variable directly
            session.setAttribute("userName", validUser.getName());

            // Verify session attributes immediately
            System.out.println("Session userRole set to: " + session.getAttribute("userRole"));
            System.out.println("Session currentUser: " + ((User)session.getAttribute("currentUser")).getName());

            if (role != null && role.equalsIgnoreCase("admin")) {
                System.out.println("Redirecting to admin dashboard...");
                // FIX: This ensures the URL includes /RheakaPrinting_war_exploded/
                response.sendRedirect(request.getContextPath() + "/admin_dashboard.jsp");
            } else {
                System.out.println("Redirecting to index...");
                // FIX: Same for the homepage
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {

            System.out.println("Login failed - Invalid credentials");
            response.sendRedirect("login.jsp?error=1");
        }
    }
}