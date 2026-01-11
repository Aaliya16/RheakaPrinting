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

@WebServlet(name = "QuantityIncDecServlet", value = "/quantity-inc-dec")
public class QuantityIncDecServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        String qtyParam = request.getParameter("quantity");

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (action != null && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    double itemSubtotal = 0;
                    double cartTotal = 0;

                    // 1. Kemaskini kuantiti dahulu
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

                    // 2. Kira SEMULA jumlah keseluruhan (Wajib di luar loop ID tadi)
                    for (Cart c : cart_list) {
                        cartTotal += (c.getPrice() * c.getQuantity());
                    }

                    if (isAjax) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        // Format dengan 2 decimal places
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
