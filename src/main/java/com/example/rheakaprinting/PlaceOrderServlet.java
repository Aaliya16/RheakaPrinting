package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.OrderDao;
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

        // 1. CHECK LOGIN (PENTING: Guna "auth" supaya sama dengan my-orders.jsp)
        User auth = (User) session.getAttribute("auth");

        // Backup check: Kalau "auth" null, cuba check "currentUser" pulak (manalah tahu)
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

        // Tambahan: Tangkap Payment Method (Default "Cash/COD" kalau tak pilih)
        String paymentMethod = request.getParameter("paymentMethod");
        if(paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "Cash / COD";
        }

        if (address == null) address = "";
        if (city == null) city = "";
        if (postcode == null) postcode = "";
        if (state == null) state = "";

        String shippingAddress = address + ", " + postcode + " " + city + ", " + state;

        System.out.println("Final Address: " + shippingAddress);

        // 4. Calculate total
        double total = 0.0;
        for (Cart c : cart_list) {
            total += c.getPrice() * c.getQuantity();
        }

        try {
            // 5. Create Order via DAO
            OrderDao orderDao = new OrderDao(DbConnection.getConnection());

            int orderId = orderDao.createOrder(
                    auth.getUserId(),
                    cart_list,
                    total,
                    shippingAddress,
                    phone,
                    paymentMethod // Hantar method bayaran yang betul
            );

            if (orderId > 0) {
                System.out.println("✅ Order created successfully! ID: " + orderId);

                // 6. Set info untuk page confirmation (resit)
                session.setAttribute("order_name", fullName);
                session.setAttribute("order_email", email);
                session.setAttribute("order_id", orderId);
                session.setAttribute("order_total", total);
                session.setAttribute("order_items", cart_list.size());

                // PENTING: Set juga address & payment method untuk paparan resit
                session.setAttribute("order_address", shippingAddress);
                session.setAttribute("order_payment", paymentMethod);

                // 7. CLEAR CART
                session.removeAttribute("cart-list");

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
