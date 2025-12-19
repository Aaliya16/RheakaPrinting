package com.example.rheakaprinting.controller;

import com.example.rheakaprinting.dao.ProductAdminDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/manageProduct")
public class ProductServlet extends HttpServlet {
    private ProductAdminDao dao = new ProductAdminDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("productName");
            String cat = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            dao.addProduct(name, cat, price);
        }
        response.sendRedirect("admin_dashboard.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deleteProduct(id);
        response.sendRedirect("admin_dashboard.jsp");
    }
}