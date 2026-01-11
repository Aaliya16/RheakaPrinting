package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // --- BAHAGIAN DEBUG (LIHAT DI CONSOLE INTELLIJ) ---
        System.out.println("=== DEBUG UPDATE REQUEST ===");
        Enumeration<String> params = request.getParameterNames();
        while(params.hasMoreElements()){
            String paramName = params.nextElement();
            System.out.println(paramName + " = " + request.getParameter(paramName));
        }
        System.out.println("============================");

        String sId = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String sPrice = request.getParameter("price");
        String sQuantity = request.getParameter("quantity");

        // Semakan jika ID benar-benar null atau kosong
        if (sId == null || sId.trim().isEmpty()) {
            System.err.println("❌ RALAT KRITIKAL: Servlet tidak menerima parameter 'id'. Sila semak name='id' di JSP.");
            response.sendRedirect("admin-products.jsp?error=id_missing");
            return;
        }

        try {
            int id = Integer.parseInt(sId.trim());
            double price = Double.parseDouble(sPrice != null ? sPrice.trim() : "0");
            int quantity = Integer.parseInt(sQuantity != null ? sQuantity.trim() : "0");

            Product p = new Product();
            p.setId(id);
            p.setName(name);
            p.setCategory(category);
            p.setPrice(price);
            p.setQuantity(quantity);

            ProductDao pdao = new ProductDao(DbConnection.getConnection());
            boolean success = pdao.updateProduct(p);

            if (success) {
                response.sendRedirect("admin-products.jsp?msg=updated");
            } else {
                response.sendRedirect("admin-products.jsp?error=db_failed");
            }

        } catch (NumberFormatException e) {
            System.err.println("❌ RALAT FORMAT: Gagal tukar string ke nombor. ID: " + sId);
            response.sendRedirect("admin-products.jsp?error=invalid_format");
        }
    }
}