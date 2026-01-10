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

        // 1. CHECK LOGIN
        User auth = (User) session.getAttribute("auth");
        if (auth == null) {
            auth = (User) session.getAttribute("currentUser");
        }

        if (auth == null) {
            System.out.println("❌ User not logged in");
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return;
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
        String city = request.getParameter("city");
        String postcode = request.getParameter("postcode");
        String state = request.getParameter("state");
        String notes = request.getParameter("notes");

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "Cash / COD";
        }

        // --- FIX ALAMAT ---
        if (address == null) address = "";
        if (city == null) city = "";
        if (postcode == null) postcode = "";
        if (state == null) state = "";

        StringBuilder sb = new StringBuilder();
        if (!address.isEmpty()) sb.append(address).append(", ");
        if (!postcode.isEmpty()) sb.append(postcode).append(" ");
        if (!city.isEmpty()) sb.append(city).append(", ");
        if (!state.isEmpty()) sb.append(state);

        String shippingAddress = sb.toString();
        if (shippingAddress.endsWith(", ")) {
            shippingAddress = shippingAddress.substring(0, shippingAddress.length() - 2);
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
                    auth.getUserId(),
                    cart_list,
                    totalWithShipping,
                    shippingAddress,
                    phone,
                    paymentMethod,
                    fullName,
                    email
            );

            if (orderId > 0) {
                System.out.println("✅ Order created successfully! ID: " + orderId);

                // --- 🚀 BARU: LOGIK TOLAK STOK DI DATABASE ---
                ProductDao pDao = new ProductDao(DbConnection.getConnection());
                for (Cart c : cart_list) {
                    // Kita tolak stock_quantity berdasarkan kuantiti yang dibeli
                    pDao.reduceStock(c.getId(), c.getQuantity());
                    System.out.println("📉 Stok ditolak untuk ID: " + c.getId() + " sebanyak " + c.getQuantity());
                }
                // ----------------------------------------------

                // 6. Set info untuk page confirmation
                session.setAttribute("order_name", fullName);
                session.setAttribute("order_email", email);
                session.setAttribute("order_id", orderId);
                session.setAttribute("order_total", totalWithShipping);
                session.setAttribute("order_items", cart_list.size());
                session.setAttribute("order_address", shippingAddress);
                session.setAttribute("order_payment", paymentMethod);

                // 7. CLEAR CART (Session sahaja)
                session.removeAttribute("cart-list");

                // Tambahan: Padam juga cart dari database (Persistent Cart)
                try {
                    com.example.rheakaprinting.dao.CartDao dbCart = new com.example.rheakaprinting.dao.CartDao(DbConnection.getConnection());
                    dbCart.clearCartByUserId(auth.getUserId());
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