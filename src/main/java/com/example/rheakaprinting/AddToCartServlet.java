package com.example.rheakaprinting;

import com.example.rheakaprinting.dao.ProductDao;
import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Product;
import com.example.rheakaprinting.model.User;
import com.example.rheakaprinting.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
@MultipartConfig // Required for handling design file uploads (images/PDFs)
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        User auth = (User) session.getAttribute("currentUser");

        // 1. SECURITY CHECK: Only logged-in users can add to cart
        if (auth == null) {
            System.out.println("Unauthorized access: User must login to add to cart");
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return;
        }

        try (PrintWriter out = response.getWriter()) {

            // 2. RETRIEVE PRODUCT DATA
            String idParam = request.getParameter("id");
            String quantityParam = request.getParameter("quantity");
            String priceParam = request.getParameter("price");

            // Debug
            System.out.println("=== ADD TO CART DEBUG ===");
            System.out.println("ID: " + idParam);

            // Validation
            if (idParam == null || idParam.isEmpty()) { response.sendRedirect("index.jsp"); return; }
            if (quantityParam == null || quantityParam.isEmpty()) { response.sendRedirect("index.jsp"); return; }
            if (priceParam == null || priceParam.isEmpty()) { priceParam = "0.00"; }

            // Parse values
            int id = Integer.parseInt(idParam);
            int quantity = Integer.parseInt(quantityParam);
            double totalPrice = Double.parseDouble(priceParam);
            double unitPrice = (quantity > 0) ? (totalPrice / quantity) : 0.0;

            // --- 2. HANDLE FILE UPLOAD ---
            String imageFileName = null;

            try {
                Part part = request.getPart("design_image");

                if (part != null && part.getSize() > 0) {

                    String contentDisp = part.getHeader("content-disposition");
                    String[] items = contentDisp.split(";");
                    for (String s : items) {
                        if (s.trim().startsWith("filename")) {
                            imageFileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                        }
                    }

                    if (imageFileName != null && !imageFileName.isEmpty()) {
                        imageFileName = "design_" + System.currentTimeMillis() + "_" + imageFileName;

                        String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img" + File.separator + "uploads";

                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdir();

                        part.write(uploadPath + File.separator + imageFileName);
                        System.out.println("File uploaded to: " + uploadPath + File.separator + imageFileName);
                    }
                }
            } catch (Exception e) {
                System.out.println("No file uploaded or upload failed: " + e.getMessage());
                imageFileName = "no-design"; // Default value
            }

            // 4. PROCESS VARIATIONS (Printing Types, Fabric, etc.)
            String finalVariation = request.getParameter("variation_name");
            String finalAddon = request.getParameter("addon_name");
            String pType = request.getParameter("printing_type");

            if (pType != null && !pType.isEmpty()) {

                String fabric = request.getParameter("fabric_type");
                String apparel = request.getParameter("apparel_type");
                String nametag = request.getParameter("nametag");

                finalVariation = pType + " | " + (fabric != null ? fabric : "-") + " | " + (apparel != null ? apparel : "-");

                if (nametag != null && !nametag.trim().isEmpty() && !nametag.equals("No Nametag")) {
                    String nametagText = "Nametag: " + nametag;
                    finalAddon = (finalAddon != null && !finalAddon.isEmpty()) ? finalAddon + ", " + nametagText : nametagText;
                }
            }

            if (finalVariation == null || finalVariation.trim().isEmpty()) finalVariation = "Standard";
            if (finalAddon == null || finalAddon.trim().isEmpty()) finalAddon = "None";

            System.out.println("Final Variation: " + finalVariation);
            System.out.println("Final Addon: " + finalAddon);

            // 5. DATABASE PERSISTENCE
            ProductDao pDao = new ProductDao(DbConnection.getConnection());
            Product product = pDao.getSingleProduct(id);

            if (product == null) {
                System.out.println("Error: Product with ID " + id + " not found.");
                response.sendRedirect("index.jsp?error=productNotFound");
                return;
            }

            Cart cm = new Cart();
            cm.setId(id);
            cm.setName(product.getName());
            cm.setImage(product.getImage());
            cm.setQuantity(quantity);
            cm.setPrice(unitPrice);
            cm.setStock(product.getStock());
            cm.setDesignImage(imageFileName);


            try {
                com.example.rheakaprinting.dao.CartDao cartDao = new com.example.rheakaprinting.dao.CartDao(DbConnection.getConnection());
                cartDao.insertCartItem(cm, auth.getUserId());
                System.out.println("Item disimpan ke Database untuk User: " + auth.getUserId());
            } catch (Exception e) {
                System.out.println("Gagal simpan ke DB, tapi teruskan ke Session: " + e.getMessage());
            }

            // 6. SESSION SYNC (For immediate UI updates)
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

            if (cart_list == null) {
                cart_list = new ArrayList<>();
                cart_list.add(cm);
            } else {
                boolean exist = false;
                for (Cart c : cart_list) {
                    // DIBAIKI: Hanya semak ID sahaja
                    if (c.getId() == id) {
                        exist = true;
                        c.setQuantity(c.getQuantity() + quantity);
                        break;
                    }
                }
                if (!exist) {
                    cart_list.add(cm);
                }
            }

            session.setAttribute("cart-list", cart_list);
            response.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Error: Invalid number format. " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("products.jsp");
    }
}


