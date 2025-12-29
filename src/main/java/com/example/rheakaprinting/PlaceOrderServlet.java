package com.example.rheakaprinting;

import com.example.rheakaprinting.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.text.DecimalFormat;

@WebServlet(name = "PlaceOrderServlet", value = "/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

        if (cart_list == null || cart_list.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String postcode = request.getParameter("postcode");
        String state = request.getParameter("state");
        String notes = request.getParameter("notes");

        // Calculate total
        double total = 0.0;
        for (Cart c : cart_list) {
            total += c.getPrice() * c.getQuantity();
        }

        // Here you would typically:
        // 1. Save order to database
        // 2. Send confirmation email
        // 3. Process payment
        // 4. Clear the cart

        // For now, we'll just:
        // 1. Store order details in session
        // 2. Clear cart
        // 3. Redirect to order confirmation page

        session.setAttribute("order_name", fullName);
        session.setAttribute("order_email", email);
        session.setAttribute("order_total", total);
        session.setAttribute("order_items", cart_list.size());

        // Clear the cart
        session.removeAttribute("cart-list");

        // Redirect to order confirmation page
        response.sendRedirect("order-confirmation.jsp");
    }
}