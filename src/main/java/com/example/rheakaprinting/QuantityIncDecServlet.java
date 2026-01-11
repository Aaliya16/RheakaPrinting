package com.example.rheakaprinting;

import com.example.rheakaprinting.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import com.google.gson.JsonObject;
/*
 * Servlet to handle incrementing, decrementing, or manually updating
 * product quantities within the shopping cart.
 */
@WebServlet(name = "QuantityIncDecServlet", value = "/quantity-inc-dec")
public class QuantityIncDecServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Capture parameters from the URL
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        String qtyParam = request.getParameter("quantity");

        // Determine if the request is coming from a JavaScript AJAX call
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (action != null && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    double itemSubtotal = 0;
                    double cartTotal = 0;

                    // 2. Update the specific item's quantity based on the action
                    for (Cart c : cart_list) {
                        if (c.getId() == id) {
                            if (action.equals("inc") && c.getQuantity() < c.getStock()) {
                                c.setQuantity(c.getQuantity() + 1);
                            } else if (action.equals("dec") && c.getQuantity() > 1) {
                                c.setQuantity(c.getQuantity() - 1);
                            } else if (action.equals("update") && qtyParam != null) {
                                int n = Integer.parseInt(qtyParam);
                                if (n >= 1 && n <= c.getStock()) c.setQuantity(n);
                            }
                            itemSubtotal = c.getPrice() * c.getQuantity();
                        }
                    }

                    // 3. Recalculate the grand total for the entire cart
                    for (Cart c : cart_list) {
                        cartTotal += (c.getPrice() * c.getQuantity());
                    }

                    // 4. Handle AJAX Response
                    if (isAjax) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        DecimalFormat dcf = new DecimalFormat("0.00");

                        String json = String.format(
                                "{\"success\":true, \"itemSubtotal\":\"%s\", \"cartTotal\":\"%s\"}",
                                dcf.format(itemSubtotal),
                                dcf.format(cartTotal)
                        );

                        response.getWriter().write(json);
                        return;
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to cart page
        response.sendRedirect("cart.jsp");
    }
}
