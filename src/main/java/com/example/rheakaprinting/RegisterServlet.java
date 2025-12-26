package com.example.rheakaprinting;

import com.example.rheakaprinting.model.User;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/RegisterServlet") // This MUST match your form action exactly
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get data from your register.jsp form fields
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        try {
            Connection con = DbConnection.getConnection();
            String query = "INSERT INTO users (email, name, password, role) VALUES (?, ?, ?, 'customer')";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, name);
            pst.setString(3, password);

            int result = pst.executeUpdate();
            if (result > 0) {
                // Registration success, go to login
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server");
        }
    }
}