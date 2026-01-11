package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.OrderDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

//This connects the Admin Dashboard to the OrderDao.
@WebServlet(name = "UpdateOrderStatusServlet", value = "/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User authUser = (User) session.getAttribute("currentUser");

        // 1. SECURITY CHECK: Ensure the user is logged in and is an Admin
        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
        }

        // 2. DATA CAPTURE: Retrieve the specific Order ID and the target status
        String orderIdParam = request.getParameter("orderId");
        String newStatus = request.getParameter("newStatus");

        System.out.println("=== UPDATE ORDER STATUS ===");
        System.out.println("Admin: " + authUser);
        System.out.println("Order ID: " + orderIdParam);
        System.out.println("New Status: " + newStatus);

        // Basic validation for null parameters
        if (orderIdParam == null || newStatus == null) {
            response.sendRedirect("admin-orders.jsp?msg=error");
            return;
        }

        try {
            // 3. PARSING: Convert Order ID to integer
            int orderId = Integer.parseInt(orderIdParam);

            //4. Use OrderDao to update status
            OrderDao orderDao = new OrderDao(DbConnection.getConnection());
            // orderId should be an int, newStatus should be a String
            boolean updated = orderDao.updateOrderStatus(orderId, newStatus);

            // 5. REDIRECTION: Provide feedback to the Admin based on result
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