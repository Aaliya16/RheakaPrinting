package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.QuoteDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Quote;
import com.example.rheakaprinting.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

//It handles both form data and file uploads for printing designs.
@WebServlet(name = "SubmitQuoteServlet", value = "/submit-quote")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class SubmitQuoteServlet extends HttpServlet {

    // Relative path where uploaded artwork will be stored
    private static final String UPLOAD_DIR = "uploads/quotes";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User authUser = (User) session.getAttribute("currentUser");

        // 1. Authenticate User
        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return;
        }

        // 2. Capture and Validate Parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String product = request.getParameter("product");
        String quantityStr = request.getParameter("quantity");
        String note = request.getParameter("note");

        if (name == null || email == null || phone == null ||
                product == null || quantityStr == null ||
                name.isEmpty() || email.isEmpty() || phone.isEmpty() ||
                product.isEmpty() || quantityStr.isEmpty()) {

            response.sendRedirect("quote.jsp?error=missing_fields");
            return;
        }

        int quantity;
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

        // 3. Handle File Upload
        String fileName = null;
        String filePath = null;

        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileExtension = "";
            int dotIndex = originalFileName.lastIndexOf('.');
            if (dotIndex > 0) {
                fileExtension = originalFileName.substring(dotIndex);
            }

            // Generate unique filename to avoid overwriting
            String uniqueFileName = "quote_" + System.currentTimeMillis() + fileExtension;

            // FIX: Always use "/" for the web-accessible path stored in DB
            filePath = UPLOAD_DIR + "/" + uniqueFileName;
            String fullSavePath = uploadPath + File.separator + uniqueFileName;

            try {
                filePart.write(fullSavePath);
                fileName = uniqueFileName;
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("quote.jsp?error=file_upload_failed");
                return;
            }
        }

        // 4. Save Quote to Database
        try {
            Quote quote = new Quote();
            quote.setUserId(authUser.getUserId());
            quote.setName(name);
            quote.setEmail(email);
            quote.setPhone(phone);
            quote.setProduct(product);
            quote.setQuantity(quantity);
            quote.setNote(note);
            quote.setFileName(fileName);
            quote.setFilePath(filePath);
            quote.setStatus("Under Review"); // Sets default status for admin filter

            QuoteDao quoteDao = new QuoteDao(DbConnection.getConnection());
            boolean saved = quoteDao.saveQuote(quote);

            if (saved) {
                // Store info in session for the confirmation page
                session.setAttribute("quote_name", name);
                session.setAttribute("quote_email", email);
                session.setAttribute("quote_product", product);
                session.setAttribute("quote_quantity", quantity);

                response.sendRedirect("quote-confirmation.jsp");
            } else {
                response.sendRedirect("quote.jsp?error=save_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("quote.jsp?error=db_error");
        }
    }
}