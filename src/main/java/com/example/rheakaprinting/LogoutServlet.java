package com.example.rheakaprinting;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
/*
 * Servlet implementation for handling user logout.
 * Clears the session and redirects the user back to the login page.
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 1. Retrieve the current session, but do not create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        // 2. If a session exists, invalidate it to clear all attributes (user details, cart, etc.)
        if (session != null) {
            session.invalidate();
        }
        // 3. Redirect the user back to the login page with a clean slate
        response.sendRedirect("login.jsp");
    }
}