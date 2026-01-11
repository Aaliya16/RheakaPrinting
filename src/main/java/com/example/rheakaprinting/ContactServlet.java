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
/*
 * Servlet implementation for handling contact form submissions.
 * It captures user inquiries and stores them in the database for admin review.
 */
@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        User authUser = (User) session.getAttribute("currentUser");

        // 1. Security Check: Ensure the user is logged in before processing the message
        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return;
        }

        // 2. Data Extraction: Capture form parameters from the request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        // 3. Model Mapping: Populate the Message object
        Message msg = new Message();
        msg.setName(name);
        msg.setEmail(email);
        msg.setPhone(phone);
        msg.setSubject(subject);
        msg.setMessage(messageText);

        try {
            // 4. Persistence: Initialize DAO and attempt to insert the record
            MessageDao dao = new MessageDao(DbConnection.getConnection());
            if (dao.insertMessage(msg)) {
                response.sendRedirect("contact.jsp?msg=success");
            } else {
                response.sendRedirect("contact.jsp?msg=error");
            }
        } catch (Exception e) {
            // Unexpected Exception: Log the error and notify the user
            e.printStackTrace();
            response.sendRedirect("contact.jsp?msg=error");
        }
    }
}
