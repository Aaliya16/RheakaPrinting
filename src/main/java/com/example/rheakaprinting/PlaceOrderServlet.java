package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.OrderDao;
import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.Cart;
import com.example.rheakaprinting.model.User;
import com.example.rheakaprinting.model.DbConnection;

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
import java.util.ArrayList;
/*
 * Servlet implementation for finalizing and placing an order.
 * This handles the transition from payment to order confirmation.
 */
@WebServlet(name = "PlaceOrderServlet", value = "/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        System.out.println("=== PLACE ORDER REQUEST ===");

        User authUser = (User) session.getAttribute("currentUser");

        // 1. SECURITY: Check if user is authenticated
        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return;
        }

        // 2. VALIDATION: Check if cart exists and is not empty
        ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
        if (cart_list == null || cart_list.isEmpty()) {
            System.out.println("Cart is empty");
            response.sendRedirect("cart.jsp");
            return;
        }

        // 3. DATA EXTRACTION: Capture shipping and payment details from form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        // Get order notes if exists
        String orderNotes = request.getParameter("notes");
        if (orderNotes == null) orderNotes = "";

        // Calculate total with shipping logic
        double subtotal = 0.0;
        for (Cart c : cart_list) {
            subtotal += c.getPrice() * c.getQuantity();
        }

        // Get shipping fee from database with free shipping threshold
        double shippingFee = 10.0; // default
        try {
            Connection conn = DbConnection.getConnection();
            String sql = "SELECT base_fee, free_threshold FROM shipping_settings WHERE id = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double dbBaseFee = rs.getDouble("base_fee");
                double freeThreshold = rs.getDouble("free_threshold");

                shippingFee = dbBaseFee;

                // Apply free shipping if threshold met
                if (subtotal >= freeThreshold) {
                    shippingFee = 0.0;
                }
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error fetching shipping: " + e.getMessage());
            e.printStackTrace();
        }

        double totalWithShipping = subtotal + shippingFee;

        try {
            // Create Order via DAO
            OrderDao orderDao = new OrderDao(DbConnection.getConnection());

            int orderId = orderDao.createOrder(
                    authUser.getUserId(),
                    cart_list,
                    totalWithShipping,
                    address,
                    phone,
                    paymentMethod,
                    fullName,
                    email,
                    orderNotes
            );

            if (orderId > 0) {
                System.out.println("Order created successfully! ID: " + orderId);

                session.setAttribute("order_name", fullName);
                session.setAttribute("order_email", email);
                session.setAttribute("order_id", orderId);
                session.setAttribute("order_total", totalWithShipping);
                session.setAttribute("order_items", cart_list.size());
                session.setAttribute("order_address", address);
                session.setAttribute("order_payment", paymentMethod);

                session.removeAttribute("cart-list");

                try {
                    com.example.rheakaprinting.dao.CartDao dbCart = new com.example.rheakaprinting.dao.CartDao(DbConnection.getConnection());
                    dbCart.clearCartByUserId(authUser.getUserId());
                    System.out.println("Database cart cleared");
                } catch (Exception e) {
                    System.out.println("Gagal clear DB cart: " + e.getMessage());
                }

                // Redirect
                response.sendRedirect("order-confirmation.jsp");

            } else {
                response.sendRedirect("checkout.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?msg=error");
        }
    }
}