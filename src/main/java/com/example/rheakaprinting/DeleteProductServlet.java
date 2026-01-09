package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteProductServlet")
    public class DeleteProductServlet extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            int productId = Integer.parseInt(request.getParameter("id"));

            try {
                // Using your existing DbConnection and a Delete method in ProductDao
                ProductDao pdao = new ProductDao(DbConnection.getConnection());
                boolean deleted = pdao.deleteProduct(productId);

                if (deleted) {
                    // Success - redirect back to products list
                    response.sendRedirect("admin-products.jsp?msg=deleted");
                } else {
                    response.sendRedirect("admin-products.jsp?error=failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-products.jsp?error=exception");
            }
        }
    }
