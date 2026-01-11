package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
/*
 * Servlet implementation for adding new products to the inventory.
 * Access is typically restricted to Admin users.
 */
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // 1. Retrieve form data from the request
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // 2. Create and populate the Product model object
            Product p = new Product();
            p.setName(name);
            p.setCategory(category);
            p.setPrice(price);
            p.setQuantity(quantity);

            // 3. Initialize DAO and attempt to save to database
            ProductDao pdao = new ProductDao(DbConnection.getConnection());
            boolean success = pdao.addProduct(p);

            // 4. Redirect based on success or failure
            if (success) {
                response.sendRedirect("admin-products.jsp?msg=added");
            } else {
                response.sendRedirect("admin-products.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-products.jsp?error=exception");
        }
    }
}