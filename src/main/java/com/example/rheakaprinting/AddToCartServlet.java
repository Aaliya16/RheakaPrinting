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
@MultipartConfig
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        User auth = (User) session.getAttribute("auth");
        if (auth == null) {
            auth = (User) session.getAttribute("currentUser");
        }

        // Jika pengguna belum login, hantar ke login.jsp dengan mesej amaran
        if (auth == null) {
            System.out.println("❌ Unauthorized access: User must login to add to cart");
            response.sendRedirect("login.jsp?msg=notLoggedIn");
            return; // PENTING: Mesti ada return supaya kod seterusnya tidak dijalankan
        }

        try (PrintWriter out = response.getWriter()) {

            // --- 1. GET BASIC DATA ---
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

            // --- 2. HANDLE FILE UPLOAD (GAMBAR DESIGN) ---
            String imageFileName = null;

            try {
                // Ambil file dari form (pastikan name="design_image" di HTML)
                Part part = request.getPart("design_image");

                if (part != null && part.getSize() > 0) {
                    // Dapatkan nama file asal
                    String contentDisp = part.getHeader("content-disposition");
                    String[] items = contentDisp.split(";");
                    for (String s : items) {
                        if (s.trim().startsWith("filename")) {
                            imageFileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                        }
                    }

                    // Generate nama unik (supaya tak replace gambar orang lain)
                    // Contoh: design_123456789.jpg
                    if (imageFileName != null && !imageFileName.isEmpty()) {
                        imageFileName = "design_" + System.currentTimeMillis() + "_" + imageFileName;

                        // Tentukan lokasi simpan (Folder assets/img/uploads)
                        // Nota: Ini akan simpan dalam folder build server
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img" + File.separator + "uploads";

                        // Buat folder kalau belum wujud
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdir();

                        // Simpan file
                        part.write(uploadPath + File.separator + imageFileName);
                        System.out.println("✅ File uploaded to: " + uploadPath + File.separator + imageFileName);
                    }
                }
            } catch (Exception e) {
                System.out.println("⚠️ No file uploaded or upload failed: " + e.getMessage());
                imageFileName = "no-design"; // Default value
            }

            // A. Ambil value default (dari hidden input produk biasa - Banner, Sticker)
            String finalVariation = request.getParameter("variation_name");
            String finalAddon = request.getParameter("addon_name");

            // B. Logic Khas untuk APPAREL (Baju) - Check kalau parameter wujud
            // Sebab form baju tak guna hidden input 'variation_name', dia guna dropdown berasingan
            String pType = request.getParameter("printing_type");

            if (pType != null && !pType.isEmpty()) {
                // Ambil semua detail baju
                String fabric = request.getParameter("fabric_type");
                String apparel = request.getParameter("apparel_type"); // Ini biasanya pegang saiz/jenis
                String nametag = request.getParameter("nametag");

                // GABUNGKAN jadi satu string untuk variation
                // Format: "Sublimation | Eyelet | Round Neck Size L"
                finalVariation = pType + " | " + (fabric != null ? fabric : "-") + " | " + (apparel != null ? apparel : "-");

                // Handle Nametag (Masuk ke Addon)
                if (nametag != null && !nametag.trim().isEmpty() && !nametag.equals("No Nametag")) {
                    String nametagText = "Nametag: " + nametag;
                    // Kalau addon dah ada isi, tambah koma. Kalau tak, terus letak nametag.
                    finalAddon = (finalAddon != null && !finalAddon.isEmpty()) ? finalAddon + ", " + nametagText : nametagText;
                }
            }

            // C. Null Safety (Supaya tak error masa save database)
            if (finalVariation == null || finalVariation.trim().isEmpty()) finalVariation = "Standard";
            if (finalAddon == null || finalAddon.trim().isEmpty()) finalAddon = "None";

            System.out.println("Final Variation: " + finalVariation);
            System.out.println("Final Addon: " + finalAddon);

            // --- 3. CREATE CART OBJECT ---
            ProductDao pDao = new ProductDao(DbConnection.getConnection());
            Product product = pDao.getSingleProduct(id);

            Cart cm = new Cart();
            cm.setId(id);
            cm.setName(product.getName());   // TAMBAH INI supaya tak keluar 'null'
            cm.setImage(product.getImage()); // TAMBAH INI supaya gambar keluar
            cm.setQuantity(quantity);
            cm.setPrice(unitPrice);
            cm.setStock(product.getStock()); // Ini untuk fungsi butang +/- anda
            cm.setVariation(finalVariation);
            cm.setAddon(finalAddon);

            // --- 4. DATABASE & SESSION LOGIC ---

            // A. SIMPAN KE DATABASE (Supaya barang tak hilang bila logout)
            // Sila pastikan anda sudah import com.example.rheakaprinting.dao.CartDao;
            try {
                com.example.rheakaprinting.dao.CartDao cartDao = new com.example.rheakaprinting.dao.CartDao(DbConnection.getConnection());
                cartDao.insertCartItem(cm, auth.getUserId());
                System.out.println("✅ Item disimpan ke Database untuk User: " + auth.getUserId());
            } catch (Exception e) {
                System.out.println("⚠️ Gagal simpan ke DB, tapi teruskan ke Session: " + e.getMessage());
            }

            // B. KEMASKINI SESSION (Untuk paparan serta-merta di cart.jsp)
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

            if (cart_list == null) {
                cart_list = new ArrayList<>();
                cart_list.add(cm);
                System.out.println("✅ New cart created in session");
            } else {
                boolean exist = false;
                for (Cart c : cart_list) {
                    if (c.getId() == id && c.getVariation().equals(finalVariation)) {
                        exist = true;
                        c.setQuantity(c.getQuantity() + quantity);
                        System.out.println("✅ Quantity updated in session");
                        break;
                    }
                }
                if (!exist) {
                    cart_list.add(cm);
                    System.out.println("✅ Added new item to session cart");
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


