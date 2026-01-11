package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.UserDAO;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the ID from the URL
        String userIdStr = request.getParameter("id");

        if (userIdStr != null) {
            try (Connection con = DbConnection.getConnection()) {
                int userId = Integer.parseInt(userIdStr);

                // 2. Call the DAO to delete the user
                UserDAO uDao = new UserDAO(con);
                boolean success = uDao.deleteUser(userId);

                if (success) {
                    // Redirect with success status
                    response.sendRedirect("admin-users.jsp?status=deleted");
                } else {
                    response.sendRedirect("admin-users.jsp?status=error");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-users.jsp?status=error");
            }
        }
    }
}