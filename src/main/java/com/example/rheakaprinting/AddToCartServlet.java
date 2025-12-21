package com.example.rheakaprinting;

import com.example.rheakaprinting.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // 1. GET DATA FROM FORM
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));

            // Optional: Get other customization details if you want to store them
            String baseItem = request.getParameter("base_item");
            String addonService = request.getParameter("addon_service");
            String sizeAddon = request.getParameter("size_addon");

            // 2. CREATE CART OBJECT
            Cart cm = new Cart();
            cm.setId(id);
            cm.setQuantity(quantity);
            cm.setPrice(price); // Set the calculated total price

            // 3. GET OR CREATE SESSION CART
            HttpSession session = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

            if (cart_list == null) {
                // First item in cart
                cart_list = new ArrayList<>();
                cart_list.add(cm);
                session.setAttribute("cart-list", cart_list);
                response.sendRedirect("cart.jsp");
            } else {
                // Check if item already exists in cart
                boolean exist = false;

                for (Cart c : cart_list) {
                    if (c.getId() == id) {
                        exist = true;
                        // Update quantity if item already exists
                        c.setQuantity(c.getQuantity() + quantity);
                        break;
                    }
                }

                if (!exist) {
                    // Add new item to cart
                    cart_list.add(cm);
                }

                session.setAttribute("cart-list", cart_list);
                response.sendRedirect("cart.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to POST
        doPost(request, response);
    }
}