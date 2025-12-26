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

@WebServlet(name = "QuantityIncDecServlet", value = "/quantity-inc-dec")
public class QuantityIncDecServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action != null && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);

                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    for (Cart c : cart_list) {
                        if (c.getId() == id) {
                            if (action.equals("inc")) {
                                // Increase quantity
                                c.setQuantity(c.getQuantity() + 1);
                            } else if (action.equals("dec")) {
                                // Decrease quantity
                                int newQty = c.getQuantity() - 1;

                                if (newQty > 0) {
                                    c.setQuantity(newQty);
                                } else {
                                    // If quantity becomes 0, remove item from cart
                                    cart_list.remove(c);
                                }
                            }
                            break;
                        }
                    }

                    // Update session
                    session.setAttribute("cart-list", cart_list);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to cart page
        response.sendRedirect("cart.jsp");
    }
}