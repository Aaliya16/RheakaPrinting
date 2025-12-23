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
@MultipartConfig
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // GET DATA FROM FORM - MATCH dengan nama field dalam JSP
            String idParam = request.getParameter("id");
            String quantityParam = request.getParameter("quantity");
            String priceParam = request.getParameter("price"); // ✅ BETUL SEKARANG!

            // Debug - print untuk tengok apa yang diterima
            System.out.println("=== ADD TO CART DEBUG ===");
            System.out.println("ID: " + idParam);
            System.out.println("Quantity: " + quantityParam);
            System.out.println("Price: " + priceParam);

            // Validation
            if (idParam == null || idParam.isEmpty()) {
                out.println("<h3>Error: Product ID is missing</h3>");
                out.println("<a href='index.jsp'>Go Back</a>");
                return;
            }

            if (quantityParam == null || quantityParam.isEmpty()) {
                out.println("<h3>Error: Quantity is missing</h3>");
                out.println("<a href='product-details.jsp?id=" + idParam + "'>Go Back</a>");
                return;
            }

            if (priceParam == null || priceParam.isEmpty() || priceParam.equals("0.00")) {
                out.println("<h3>Error: Price not calculated</h3>");
                out.println("<p>Please select product options first</p>");
                out.println("<a href='product-details.jsp?id=" + idParam + "'>Go Back</a>");
                return;
            }

            // Parse values
            int id = Integer.parseInt(idParam);
            int quantity = Integer.parseInt(quantityParam);
            double totalPrice = Double.parseDouble(priceParam);

            // Calculate unit price (sebab form hantar total)
            double unitPrice = totalPrice / quantity;

            System.out.println("Calculated Unit Price: " + unitPrice);
            System.out.println("Total: " + totalPrice);

            // Get customization details (optional)
            String variationName = request.getParameter("variation_name");
            String addonName = request.getParameter("addon_name");

            System.out.println("Variation: " + variationName);
            System.out.println("Addon: " + addonName);

            // CREATE CART OBJECT
            Cart cm = new Cart();
            cm.setId(id);
            cm.setQuantity(quantity);
            cm.setPrice(unitPrice); // ✅ Simpan unit price, bukan total

            // GET OR CREATE SESSION CART
            HttpSession session = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

            if (cart_list == null) {
                cart_list = new ArrayList<>();
                cart_list.add(cm);
                session.setAttribute("cart-list", cart_list);
                System.out.println("✅ New cart created with 1 item");
            } else {
                boolean exist = false;

                for (Cart c : cart_list) {
                    if (c.getId() == id) {
                        exist = true;
                        c.setQuantity(c.getQuantity() + quantity);
                        System.out.println("✅ Updated existing item quantity to: " + c.getQuantity());
                        break;
                    }
                }

                if (!exist) {
                    cart_list.add(cm);
                    System.out.println("✅ Added new item to cart");
                }
            }

            // Update session
            session.setAttribute("cart-list", cart_list);
            System.out.println("✅ Cart size: " + cart_list.size());
            System.out.println("=========================");

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
        response.sendRedirect("products.jsp");
    }
}