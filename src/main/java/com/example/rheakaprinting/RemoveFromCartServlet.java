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

        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);

                HttpSession session = request.getSession();
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

                if (cart_list != null) {
                    // Remove the item from cart
                    for (int i = 0; i < cart_list.size(); i++) {
                        if (cart_list.get(i).getId() == id) {
                            cart_list.remove(i);
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