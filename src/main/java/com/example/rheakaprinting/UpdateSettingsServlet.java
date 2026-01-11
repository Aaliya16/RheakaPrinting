package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.SettingsDao;
import com.example.rheakaprinting.model.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.Map;

@WebServlet("/UpdateSettingsServlet")
public class UpdateSettingsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = DbConnection.getConnection();
        SettingsDao sDao = new SettingsDao(conn);

        Map<String, String[]> paramMap = request.getParameterMap();

        for (String key : paramMap.keySet()) {
            String value = request.getParameter(key);
            if (value != null && !key.equals("submit")) {
                sDao.updateSetting(key, value);
            }
        }

        response.sendRedirect("admin-settings.jsp?status=success");
    }
}
