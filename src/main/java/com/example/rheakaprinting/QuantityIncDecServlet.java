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
        String variationParam = request.getParameter("variation");

        if (variationParam == null) variationParam = "";

        boolean success = false;
        String message = "";
        int newQuantity = 0;
        double itemSubtotal = 0.0;
        double cartTotal = 0.0;

        if (action != null && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    for (Cart c : cart_list) {
                        String cartVariation = (c.getVariation() != null) ? c.getVariation() : "";

                        if (c.getId() == id && cartVariation.equals(variationParam)) {

                            if (action.equals("inc")) {
                                if (c.getQuantity() < c.getStock()) {
                                    c.setQuantity(c.getQuantity() + 1);
                                    success = true;
                                    message = "Quantity increased";
                                } else {
                                    System.out.println("Had stok dicapai untuk ID: " + c.getId());
                                    message = "Maximum stock reached";
                                }
                            } else if (action.equals("dec")) {
                                if (c.getQuantity() > 1) {
                                    c.setQuantity(c.getQuantity() - 1);
                                    success = true;
                                    message = "Quantity decreased";
                                } else {
                                    message = "Minimum quantity is 1";
                                }
                            }
                            break;
                        }
                    }
                    session.setAttribute("cart-list", cart_list);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("cart.jsp");
    }
}

