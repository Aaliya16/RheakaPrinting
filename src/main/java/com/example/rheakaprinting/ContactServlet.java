package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.MessageDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Message;
import com.example.rheakaprinting.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Ambil session
        HttpSession session = request.getSession();

        // 2. Semak Login (Pagar Keselamatan)
        User auth = (User) session.getAttribute("auth");
        if (auth == null) {
            auth = (User) session.getAttribute("currentUser");
        }

        // Jika tiada user dalam session, halau ke login.jsp
        if (auth == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return; // Penting: supaya kod di bawah tidak berjalan
        }
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        Message msg = new Message();
        msg.setName(name);
        msg.setEmail(email);
        msg.setName(phone);
        msg.setSubject(subject);
        msg.setMessage(messageText);

        try {
            MessageDao dao = new MessageDao(DbConnection.getConnection());
            if (dao.insertMessage(msg)) {
                response.sendRedirect("contact.jsp?msg=success");
            } else {
                response.sendRedirect("contact.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("contact.jsp?msg=error");
        }
    }
}
