package com.example.rheakaprinting;

import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateShippingSettings")
public class UpdateShippingSettings extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String baseShip = request.getParameter("baseShip");
        String freeShip = request.getParameter("freeShip");
        String selfPickup = request.getParameter("selfPickup");

        try {
            Connection conn = DbConnection.getConnection();
            String sql = "UPDATE shipping_settings SET base_fee = ?, free_threshold = ?, self_pickup_enabled = ? WHERE id = 1";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, Double.parseDouble(baseShip));
            ps.setDouble(2, Double.parseDouble(freeShip));
            ps.setBoolean(3, selfPickup != null);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                response.sendRedirect("admin-settings.jsp?status=success");
            } else {
                response.sendRedirect("admin-settings.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-settings.jsp?status=error");
        }
    }
}