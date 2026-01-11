package com.example.rheakaprinting;

import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/UpdateMessageStatusServlet")
public class UpdateMessageStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters from the JavaScript fetch() call
        String msgId = request.getParameter("id");
        String action = request.getParameter("action");

        if (msgId != null && action != null) {
            try (Connection con = DbConnection.getConnection()) {
                String sql = "";

                // 2. Determine which column to update based on the 'action'
                switch (action) {
                    case "read":
                        sql = "UPDATE contact_messages SET is_read = 1 WHERE id = ?";
                        break;
                    case "favorite":
                        sql = "UPDATE contact_messages SET is_important = 1 WHERE id = ?";
                        break;
                    case "unfavorite":
                        sql = "UPDATE contact_messages SET is_important = 0 WHERE id = ?";
                        break;
                }

                if (!sql.isEmpty()) {
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(msgId));
                    ps.executeUpdate();
                }

                // Send a success status back to the script
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }
}
