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

//Servlet implementation for updating global shop settings.
@WebServlet("/UpdateSettingsServlet")
public class UpdateSettingsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Establish database connection
        Connection conn = DbConnection.getConnection();
        SettingsDao sDao = new SettingsDao(conn);

        // 2. Capture all parameters sent from the admin-settings.jsp form
        Map<String, String[]> paramMap = request.getParameterMap();

        for (String key : paramMap.keySet()) {
            String value = request.getParameter(key);
            // 3. Filter out the submit button and null values
            if (value != null && !key.equals("submit")) {
                sDao.updateSetting(key, value);
            }
        }

        // 4. Redirect back to the settings page with a success flag
        response.sendRedirect("admin-settings.jsp?status=success");
    }
}
