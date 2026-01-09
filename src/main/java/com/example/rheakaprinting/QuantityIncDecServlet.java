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

        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        // 1. TERIMA PARAMETER BARU: variation
        // Kita perlu tahu user nak ubah quantity untuk variation yang mana satu
        String variationParam = request.getParameter("variation");

        // Null safety (kalau null, anggap kosong supaya tak error masa .equals)
        if (variationParam == null) variationParam = "";

        if (action != null && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);

                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    for (Cart c : cart_list) {
                        // 2. CHECK ID **DAN** VARIATION
                        // Dulu: if (c.getId() == id)
                        // Sekarang: Kena check dua-dua match barulah betul

                        // Nota: c.getVariation() mungkin null, jadi guna safe check
                        String cartVariation = (c.getVariation() != null) ? c.getVariation() : "";

                        if (c.getId() == id && cartVariation.equals(variationParam)) {

                            if (action.equals("inc")) {
                                c.setQuantity(c.getQuantity() + 1);
                            } else if (action.equals("dec")) {
                                int newQty = c.getQuantity() - 1;
                                if (newQty > 0) {
                                    c.setQuantity(newQty);
                                } else {
                                    cart_list.remove(c);
                                }
                            }
                            break; // Dah jumpa & update, terus keluar loop
                        }
                    }

                    // Update session
                    session.setAttribute("cart-list", cart_list);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("cart.jsp");
    }
}