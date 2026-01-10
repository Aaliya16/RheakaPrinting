package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Capture all parameters from the modal form
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Create product object and set values
            Product p = new Product();
            p.setId(id);
            p.setName(name);
            p.setCategory(category);
            p.setPrice(price);
            p.setQuantity(quantity);

            // Execute update via DAO
            ProductDao pdao = new ProductDao(DbConnection.getConnection());
            boolean success = pdao.updateProduct(p);

            if (success) {
                response.sendRedirect("admin-products.jsp?msg=updated");
            } else {
                response.sendRedirect("admin-products.jsp?error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-products.jsp?error=exception");
        }
    }
}