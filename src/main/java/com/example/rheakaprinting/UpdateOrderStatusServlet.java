package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.OrderDao;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "UpdateOrderStatusServlet", value = "/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin authentication
        HttpSession session = request.getSession();
        String adminUser = (String) session.getAttribute("adminUsername");

        if (adminUser == null) {
            response.sendRedirect("admin-login.jsp?msg=unauthorized");
            return;
        }

        String orderIdParam = request.getParameter("orderId");
        String newStatus = request.getParameter("newStatus");

        System.out.println("=== UPDATE ORDER STATUS ===");
        System.out.println("Admin: " + adminUser);
        System.out.println("Order ID: " + orderIdParam);
        System.out.println("New Status: " + newStatus);

        if (orderIdParam == null || newStatus == null) {
            response.sendRedirect("admin-orders.jsp?msg=error");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);

            // Use OrderDao to update status
            OrderDao orderDao = new OrderDao(DbConnection.getConnection());
            boolean updated = orderDao.updateOrderStatus(orderId, newStatus);

            if (updated) {
                System.out.println("✅ Status updated successfully");
                System.out.println("===========================");
                response.sendRedirect("admin-orders.jsp?msg=updated");
            } else {
                System.out.println("❌ Failed to update status");
                System.out.println("===========================");
                response.sendRedirect("admin-orders.jsp?msg=error");
            }

        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid order ID: " + e.getMessage());
            response.sendRedirect("admin-orders.jsp?msg=error");
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("admin-orders.jsp?msg=error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin-orders.jsp");
    }
}