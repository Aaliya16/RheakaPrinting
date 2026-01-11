package com.example.rheakaprinting;

import com.example.rheakaprinting.model.User;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

//Servlet implementation for new user registration.
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 1. Extract user input from the request object
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        try {
            // 2. Establish database connection
            Connection con = DbConnection.getConnection();
            String query = "INSERT INTO users (email, name, password, role) VALUES (?, ?, ?, 'customer')";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, name);
            pst.setString(3, password);

            // Logging for debugging purposes (masked password for safety)
            System.out.println("=== REGISTRATION ATTEMPT ===");
            System.out.println("Email: " + email);
            System.out.println("Full Name: " + name);
            System.out.println("Password: " + (password != null ? "***" : "NULL"));

            // 4. Execute update and handle redirection
            int result = pst.executeUpdate();
            if (result > 0) {
                // Success: Take user to login page
                response.sendRedirect("login.jsp");
            } else {
                // Logic failure: Record not inserted
                response.sendRedirect("register.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server");
        }
    }
}