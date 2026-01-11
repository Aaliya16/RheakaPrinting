package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.QuoteDao;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateQuoteStatusServlet", value = "/UpdateQuoteStatusServlet")
public class UpdateQuoteStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get parameters from the fetch URL
            int quoteId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            // 2. Call the DAO method we added earlier
            QuoteDao qDao = new QuoteDao(DbConnection.getConnection());
            boolean updated = qDao.updateQuoteStatus(quoteId, status);

            // 3. Send a simple success or error response
            if (updated) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Success");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Update failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
        }
    }
}
