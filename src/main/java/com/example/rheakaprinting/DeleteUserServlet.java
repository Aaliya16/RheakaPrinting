package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.UserDAO;
import com.example.rheakaprinting.model.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
/*
 * Servlet implementation for deleting a user account.
 * This is typically accessed via the Admin Dashboard.
 */
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve the User ID from the request parameter
        String userId = request.getParameter("id");

        // 2. Validate that the ID is not null or empty
        if (userId != null && !userId.trim().isEmpty()) {
            try {
                // Initialize DAO with a database connection
                UserDAO userDao = new UserDAO(DbConnection.getConnection());
                boolean deleted = userDao.deleteUser(Integer.parseInt(userId));

                if (deleted) {
                    response.sendRedirect("admin-users.jsp?msg=User deleted successfully");
                } else {
                    response.sendRedirect("admin-users.jsp?error=Failed to delete user");
                }
            } catch (Exception e) {
                // Handle database or connection exceptions
                e.printStackTrace();
                response.sendRedirect("admin-users.jsp?error=Error: " + e.getMessage());
            }
        } else {
            // Missing ID parameter
            response.sendRedirect("admin-users.jsp?error=Invalid user ID");
        }
    }
}