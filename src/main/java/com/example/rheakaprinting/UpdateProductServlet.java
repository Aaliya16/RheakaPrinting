package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Enumeration;

//This class acts as the Controller in the MVC pattern for the Update operation.
@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 1. DEBUGGING: Log all incoming parameters to the server console
        System.out.println("=== DEBUG UPDATE REQUEST ===");
        Enumeration<String> params = request.getParameterNames();
        while(params.hasMoreElements()){
            String paramName = params.nextElement();
            System.out.println(paramName + " = " + request.getParameter(paramName));
        }
        System.out.println("============================");

        // 2. DATA EXTRACTION: Capture form data from the request
        String sId = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String sPrice = request.getParameter("price");
        String sQuantity = request.getParameter("quantity");

        // Validation: Ensure the ID is present before attempting an update
        if (sId == null || sId.trim().isEmpty()) {
            System.err.println("CRITICAL ERROR: Parameter 'id' missing from request.");
            response.sendRedirect("admin-products.jsp?error=id_missing");
            return;
        }

        try {
            // 3. PARSING & MAPPING: Convert strings to appropriate numeric types and populate Model
            int id = Integer.parseInt(sId.trim());
            double price = Double.parseDouble(sPrice != null ? sPrice.trim() : "0");
            int quantity = Integer.parseInt(sQuantity != null ? sQuantity.trim() : "0");

            Product p = new Product();
            p.setId(id);
            p.setName(name);
            p.setCategory(category);
            p.setPrice(price);
            p.setQuantity(quantity);

            // 4. PERSISTENCE: Use ProductDao to execute the SQL UPDATE command
            ProductDao pdao = new ProductDao(DbConnection.getConnection());
            boolean success = pdao.updateProduct(p);

            // 5. REDIRECTION: Provide feedback to the admin panel
            if (success) {
                response.sendRedirect("admin-products.jsp?msg=updated");
            } else {
                response.sendRedirect("admin-products.jsp?error=db_failed");
            }

        } catch (NumberFormatException e) {
            System.err.println("FORMAT ERROR: Failed to parse numeric values. ID:" + sId);
            response.sendRedirect("admin-products.jsp?error=invalid_format");
        }
    }
}