package com.example.rheakaprinting;

import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateAdminPassword")
public class UpdateAdminPassword extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters from your admin-settings.jsp form
        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");

        // 2. Get current admin session
        HttpSession session = request.getSession();
        String adminUser = (String) session.getAttribute("adminUser");

        try (Connection conn = DbConnection.getConnection()) {
            // 3. Verify Current Password against the 'admins' table
            String checkSql = "SELECT password FROM admins WHERE username = ?";
            PreparedStatement pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, adminUser);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next() && rs.getString("password").equals(currentPass)) {
                // 4. Update to New Password
                String updateSql = "UPDATE admins SET password = ? WHERE username = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, newPass);
                updateStmt.setString(2, adminUser);
                updateStmt.executeUpdate();

                // Redirect with success status
                response.sendRedirect("admin-settings.jsp?status=success");
            } else {
                // Redirect with mismatch error
                response.sendRedirect("admin-settings.jsp?status=error&msg=WrongCurrentPassword");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin-settings.jsp?status=error");
        }
    }
}