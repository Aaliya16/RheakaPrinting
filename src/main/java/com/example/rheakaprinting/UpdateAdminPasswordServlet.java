package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.UserDAO;
import com.example.rheakaprinting.model.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateAdminPassword")
public class UpdateAdminPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String adminEmail = (String) session.getAttribute("adminEmail");

        // Get form parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Validate inputs
        if (currentPassword == null || newPassword == null ||
                currentPassword.trim().isEmpty() || newPassword.trim().isEmpty()) {
            response.sendRedirect("admin-settings.jsp?status=error&msg=All fields are required");
            return;
        }

        try {
            UserDAO userDao = new UserDAO(DbConnection.getConnection());

            // Verify current password
            boolean isValid = userDao.verifyAdminPassword(adminEmail, currentPassword);

            if (!isValid) {
                response.sendRedirect("admin-settings.jsp?status=error&msg=Current password is incorrect");
                return;
            }

            // Update password
            boolean updated = userDao.updateAdminPassword(adminEmail, newPassword);

            if (updated) {
                response.sendRedirect("admin-settings.jsp?status=success&msg=Password updated successfully");
            } else {
                response.sendRedirect("admin-settings.jsp?status=error&msg=Failed to update password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-settings.jsp?status=error&msg=Server error occurred");
        }
    }
}