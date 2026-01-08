package com.example.rheakaprinting;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.example.rheakaprinting.model.DbConnection;

@WebServlet(name = "ContactServlet", value = "/ContactServlet")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        System.out.println("=== CONTACT FORM SUBMISSION ===");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);

        // Validation
        if (name == null || email == null || subject == null || message == null ||
                name.trim().isEmpty() || email.trim().isEmpty() ||
                subject.trim().isEmpty() || message.trim().isEmpty()) {

            System.out.println("❌ Validation failed - empty fields");
            response.sendRedirect("contact-us.jsp?msg=error");
            return;
        }

        try {
            // Save to database
            boolean saved = saveContactMessage(name, email, phone, subject, message);

            if (saved) {
                System.out.println("✅ Contact message saved successfully");

                // Optional: Send email notification (implement later)
                // sendEmailNotification(name, email, subject, message);

                System.out.println("===============================");
                response.sendRedirect("contact-us.jsp?msg=success");

            } else {
                System.out.println("❌ Failed to save contact message");
                System.out.println("===============================");
                response.sendRedirect("contact-us.jsp?msg=error");
            }

        } catch (Exception e) {
            System.err.println("❌ Error processing contact form: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("contact-us.jsp?msg=error");
        }
    }

    /**
     * Save contact message to database
     */
    private boolean saveContactMessage(String name, String email, String phone,
                                       String subject, String message) {

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = DbConnection.getConnection();

            if (conn == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }

            String query = "INSERT INTO contact_messages (name, email, phone, subject, message, status, created_at) " +
                    "VALUES (?, ?, ?, ?, ?, 'new', ?)";

            pst = conn.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, phone);
            pst.setString(4, subject);
            pst.setString(5, message);
            pst.setTimestamp(6, new Timestamp(System.currentTimeMillis()));

            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("❌ SQL Error: " + e.getMessage());
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (pst != null) pst.close();
                // Don't close connection as it's shared
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void sendEmailNotification(String name, String email, String subject, String message) {
        // TODO: Implement email sending using JavaMail
        System.out.println("📧 Email notification would be sent here");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to contact page
        response.sendRedirect("contact-us.jsp");
    }
}