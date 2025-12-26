package com.example.rheakaprinting;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "SubmitQuoteServlet", value = "/submit-quote")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class SubmitQuoteServlet extends HttpServlet {

    // Directory to save uploaded files
    private static final String UPLOAD_DIR = "uploads/quotes";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String product = request.getParameter("product");
        String quantityStr = request.getParameter("quantity");
        String note = request.getParameter("note");

        // Validate required fields
        if (name == null || email == null || phone == null ||
                product == null || quantityStr == null ||
                name.isEmpty() || email.isEmpty() || phone.isEmpty() ||
                product.isEmpty() || quantityStr.isEmpty()) {

            response.sendRedirect("quote.jsp?error=missing_fields");
            return;
        }

        int quantity = 0;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity <= 0) {
                response.sendRedirect("quote.jsp?error=invalid_quantity");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("quote.jsp?error=invalid_quantity");
            return;
        }

        // Handle file upload
        String fileName = null;
        String filePath = null;

        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            // Get filename
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Create upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Generate unique filename to avoid overwriting
            String fileExtension = "";
            int dotIndex = fileName.lastIndexOf('.');
            if (dotIndex > 0) {
                fileExtension = fileName.substring(dotIndex);
                fileName = fileName.substring(0, dotIndex);
            }

            String uniqueFileName = fileName + "_" + System.currentTimeMillis() + fileExtension;
            filePath = uploadPath + File.separator + uniqueFileName;

            // Save file
            try {
                filePart.write(filePath);
                fileName = uniqueFileName; // Store the unique filename
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("quote.jsp?error=file_upload_failed");
                return;
            }
        }

        // TODO: Save quote to database
        /*
        Quote quote = new Quote();
        quote.setName(name);
        quote.setEmail(email);
        quote.setPhone(phone);
        quote.setProduct(product);
        quote.setQuantity(quantity);
        quote.setNote(note);
        quote.setFileName(fileName);
        quote.setFilePath(filePath);
        quote.setCreatedAt(new java.util.Date());

        QuoteDao quoteDao = new QuoteDao(DbConnection.getConnection());
        boolean saved = quoteDao.saveQuote(quote);

        if (!saved) {
            response.sendRedirect("quote.jsp?error=save_failed");
            return;
        }
        */

        // TODO: Send email notification to admin
        /*
        EmailService emailService = new EmailService();
        emailService.sendQuoteNotification(quote);
        */

        // TODO: Send confirmation email to customer
        /*
        emailService.sendQuoteConfirmation(email, name);
        */

        // Store quote info in session for confirmation page
        request.getSession().setAttribute("quote_name", name);
        request.getSession().setAttribute("quote_email", email);
        request.getSession().setAttribute("quote_product", product);
        request.getSession().setAttribute("quote_quantity", quantity);

        // Redirect to confirmation page
        response.sendRedirect("quote-confirmation.jsp");
    }
}