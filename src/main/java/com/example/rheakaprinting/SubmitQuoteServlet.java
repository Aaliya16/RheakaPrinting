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

@WebServlet(name = "SubmitQuoteServlet", value = "/submit-quote")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class SubmitQuoteServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/quotes";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User authUser = (User) session.getAttribute("currentUser");

        if (authUser == null) {
            response.sendRedirect("login.jsp?msg=notLoggedIn");
        }

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

        String fileName = null;
        String filePath = null;

        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileExtension = "";
            int dotIndex = fileName.lastIndexOf('.');
            if (dotIndex > 0) {
                fileExtension = fileName.substring(dotIndex);
                fileName = fileName.substring(0, dotIndex);
            }

            String uniqueFileName = fileName + "_" + System.currentTimeMillis() + fileExtension;
            filePath = UPLOAD_DIR + File.separator + uniqueFileName;
            String fullPath = uploadPath + File.separator + uniqueFileName;

            try {
                filePart.write(fullPath);
                fileName = uniqueFileName;
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("quote.jsp?error=file_upload_failed");
                return;
            }
        }

        // 4. Simpan ke Pangkalan Data
        try {
            authUser = (User) session.getAttribute("currentUser");

            if (authUser == null) {
                response.sendRedirect("login.jsp?msg=notLoggedIn");
            }
            int userId = (authUser != null) ? authUser.getUserId() : 0;

            Quote quote = new Quote();
            quote.setUserId(userId);
            quote.setName(name);
            quote.setEmail(email);
            quote.setPhone(phone);
            quote.setProduct(product);
            quote.setQuantity(quantity);
            quote.setNote(note);
            quote.setFileName(fileName);
            quote.setFilePath(filePath);

            QuoteDao quoteDao = new QuoteDao(DbConnection.getConnection());
            boolean saved = quoteDao.saveQuote(quote);

            if (saved) {
                // 5. Simpan info ke session untuk confirmation page
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
