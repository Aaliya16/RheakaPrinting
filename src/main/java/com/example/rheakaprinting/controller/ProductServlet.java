package com.example.rheakaprinting.controller;

import com.example.rheakaprinting.dao.ProductAdminDao;
import com.example.rheakaprinting.model.Product; // Necessary to use the Product object
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manageProduct")
public class ProductServlet extends HttpServlet {
    private ProductAdminDao dao = new ProductAdminDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Product p = new Product();
            p.setName(request.getParameter("productName"));
            p.setCategory(request.getParameter("category"));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            p.setImage(request.getParameter("image"));
            p.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            p.setDescription(request.getParameter("description"));
            p.setStock(Integer.parseInt(request.getParameter("stock")));

            dao.addProduct(p);
        }
        response.sendRedirect("admin_dashboard.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { // Added ServletException for consistency
        String idParam = request.getParameter("id");
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            dao.deleteProduct(id);
        }
        response.sendRedirect("admin_dashboard.jsp");
    }
}