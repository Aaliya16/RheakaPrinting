package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.UserDAO;
import com.example.rheakaprinting.model.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("id");

        if (userId != null && !userId.trim().isEmpty()) {
            try {
                UserDAO userDao = new UserDAO(DbConnection.getConnection());
                boolean deleted = userDao.deleteUser(Integer.parseInt(userId));

                if (deleted) {
                    response.sendRedirect("admin-users.jsp?msg=User deleted successfully");
                } else {
                    response.sendRedirect("admin-users.jsp?error=Failed to delete user");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-users.jsp?error=Error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("admin-users.jsp?error=Invalid user ID");
        }
    }
}