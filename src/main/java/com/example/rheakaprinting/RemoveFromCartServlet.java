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

@WebServlet(name = "RemoveFromCartServlet", value = "/remove-from-cart")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. TERIMA ID & VARIATION
        String idParam = request.getParameter("id");
        String variationParam = request.getParameter("variation"); // Wajib ada

        // Null safety (supaya tak error masa compare string)
        if (variationParam == null) variationParam = "";

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);

                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    for (int i = 0; i < cart_list.size(); i++) {
                        Cart c = cart_list.get(i);

                        // Null safety untuk variation dalam cart object
                        String itemVariation = (c.getVariation() != null) ? c.getVariation() : "";

                        // 2. SYARAT PADAM: ID SAMA && VARIATION SAMA
                        if (c.getId() == id && itemVariation.equals(variationParam)) {
                            cart_list.remove(i);
                            break; // Dah jumpa & padam, terus keluar loop
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
