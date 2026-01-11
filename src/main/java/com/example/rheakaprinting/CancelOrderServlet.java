package com.example.rheakaprinting;

import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "CancelOrderServlet", value = "/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User authUser = (User) session.getAttribute("currentUser");

        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
        }

        String orderIdParam = request.getParameter("id");

        if (orderIdParam == null) {
            response.sendRedirect("orders.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            int userId = authUser.getUserId();

            System.out.println("=== CANCEL ORDER REQUEST ===");
            System.out.println("Order ID: " + orderId);
            System.out.println("User ID: " + userId);

            boolean cancelled = cancelOrder(orderId, userId);

            if (cancelled) {
                System.out.println("✅ Order cancelled successfully");
                response.sendRedirect("orders.jsp?msg=cancelled");
            } else {
                System.out.println("❌ Failed to cancel order");
                response.sendRedirect("orders.jsp?msg=error");
            }

        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid order ID: " + e.getMessage());
            response.sendRedirect("orders.jsp?msg=error");
        }
    }

    private boolean cancelOrder(int orderId, int userId) {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getConnection();

            if (conn == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }

            String checkQuery = "SELECT status FROM orders WHERE id = ? AND user_id = ?";
            checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, orderId);
            checkStmt.setInt(2, userId);
            rs = checkStmt.executeQuery();

            if (!rs.next()) {
                System.err.println("❌ Order not found or doesn't belong to user");
                return false;
            }

            String currentStatus = rs.getString("status");

            if (!"pending".equals(currentStatus)) {
                System.err.println("❌ Order cannot be cancelled - current status: " + currentStatus);
                return false;
            }

            String updateQuery = "UPDATE orders SET status = 'cancelled' WHERE id = ? AND user_id = ?";
            updateStmt = conn.prepareStatement(updateQuery);
            updateStmt.setInt(1, orderId);
            updateStmt.setInt(2, userId);

            int rowsAffected = updateStmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("❌ SQL Error: " + e.getMessage());
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (updateStmt != null) updateStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
