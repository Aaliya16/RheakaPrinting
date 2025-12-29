package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.UserDAO;
import com.example.rheakaprinting.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User validUser = dao.authenticate(userParam, passParam);

        if (validUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", validUser);
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}