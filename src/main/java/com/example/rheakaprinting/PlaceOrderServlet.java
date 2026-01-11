package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.OrderDao;
import com.example.rheakaprinting.dao.ProductDao; // Pastikan import ini ada
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
import java.util.ArrayList;

@WebServlet(name = "PlaceOrderServlet", value = "/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        System.out.println("=== PLACE ORDER REQUEST ===");

        User authUser = (User) session.getAttribute("currentUser");

        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
        }

        // 2. Get cart
        ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
        if (cart_list == null || cart_list.isEmpty()) {
            System.out.println("❌ Cart is empty");
            response.sendRedirect("cart.jsp");
            return;
        }

        // 3. Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "Cash / Online Banking";
        }

        // 4. Calculate total
        double subtotal = 0.0;
        double shippingFee = 10.0;

        for (Cart c : cart_list) {
            subtotal += c.getPrice() * c.getQuantity();
        }
        double totalWithShipping = subtotal + shippingFee;

        try {
            // 5. Create Order via DAO
            OrderDao orderDao = new OrderDao(DbConnection.getConnection());

            int orderId = orderDao.createOrder(
                    authUser.getUserId(),
                    cart_list,
                    totalWithShipping,
                    address,
                    phone,
                    paymentMethod,
                    fullName,
                    email
            );

            if (orderId > 0) {
                System.out.println("✅ Order created successfully! ID: " + orderId);

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
                    System.out.println("🧹 Database cart cleared");
                } catch (Exception e) {
                    System.out.println("⚠️ Gagal clear DB cart: " + e.getMessage());
                }

                // 8. Redirect
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