package com.example.rheakaprinting;

import com.example.rheakaprinting.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
@MultipartConfig // Add this for file upload support
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // 1. GET DATA FROM FORM - Match dengan nama field dalam form
            String idParam = request.getParameter("id");
            String quantityParam = request.getParameter("quantity");
            String priceParam = request.getParameter("final_unit_price"); // BETULKAN INI!

            // Validation - pastikan semua parameter ada
            if (idParam == null || quantityParam == null || priceParam == null ||
                    priceParam.isEmpty() || priceParam.equals("0.00")) {
                out.println("<h3>Error: Missing required fields or price not calculated</h3>");
                out.println("<p>ID: " + idParam + "</p>");
                out.println("<p>Quantity: " + quantityParam + "</p>");
                out.println("<p>Price: " + priceParam + "</p>");
                out.println("<a href='product-details.jsp?id=" + idParam + "'>Go Back</a>");
                return;
            }

            int id = Integer.parseInt(idParam);
            int quantity = Integer.parseInt(quantityParam);
            double unitPrice = Double.parseDouble(priceParam);

            // Optional: Get customization details
            String variationName = request.getParameter("variation_name");
            String addonName = request.getParameter("addon_name");

            // 2. CREATE CART OBJECT
            Cart cm = new Cart();
            cm.setId(id);
            cm.setQuantity(quantity);
            cm.setPrice(unitPrice); // Unit price, bukan total

            // If your Cart model supports these fields:
            // cm.setVariation(variationName);
            // cm.setAddon(addonName);

            // 3. GET OR CREATE SESSION CART
            HttpSession session = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

            if (cart_list == null) {
                // First item in cart
                cart_list = new ArrayList<>();
                cart_list.add(cm);
                session.setAttribute("cart-list", cart_list);
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
            }

            // Update session
            session.setAttribute("cart-list", cart_list);

            // Redirect to cart page
            response.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: Invalid number format</h3>");
            response.getWriter().println("<p>" + e.getMessage() + "</p>");
            response.getWriter().println("<a href='index.jsp'>Go Back</a>");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to products page
        response.sendRedirect("products.jsp");
    }
}