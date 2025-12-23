
package com.example.rheakaprinting;

import com.example.rheakaprinting.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        User newUser = new User(user, pass, email, fullName, "customer");
        UserDAO dao = new UserDAO();

        if (dao.registerUser(newUser)) {
            response.sendRedirect("login.jsp?msg=success");
        } else {
            response.sendRedirect("register.jsp?msg=failed");
        }
    }
}