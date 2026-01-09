package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Cart;
import java.sql.*;
import java.util.List;

public class OrderDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public OrderDao(Connection con) {
        this.con = con;
    }

    public int createOrder(int userId, List<Cart> cartList, double totalAmount, String address, String phone, String paymentMethod) {
        int orderId = 0;

        try {
            // 1. INSERT INTO ORDERS (Table Induk)
            // Pastikan nama column sama dengan Database! (u_id, total_price, shipping_address)
            // Saya tambah column 'payment_method' juga (kalau database awak ada)
            query = "INSERT INTO orders (user_id, total_amount, address, phone_number, status, order_date) VALUES (?, ?, ?, ?, 'Processing', NOW())";

            pst = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, userId);
            pst.setDouble(2, totalAmount);
            pst.setString(3, address);
            pst.setString(4, phone);
            // pst.setString(5, paymentMethod); // Uncomment baris ini jika database orders ada column 'payment_method'

            int result = pst.executeUpdate();

            if (result > 0) {
                // Dapatkan Order ID yang baru di-generate
                rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }

                // 2. INSERT INTO ORDER_ITEMS (Table Barang)
                // PENTING: Nama table ialah 'order_items' (ikut SQL sebelum ni)
                // PENTING: Bilangan '?' mesti sama dengan bilangan column (6 column = 6 tanda soal)
                String query2 = "INSERT INTO order_details (order_id, product_id, quantity, price, variation, addon, design_image) VALUES (?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement pst2 = this.con.prepareStatement(query2);

                for (Cart c : cartList) {
                    pst2.setInt(1, orderId);
                    pst2.setInt(2, c.getId());
                    pst2.setInt(3, c.getQuantity());
                    pst2.setDouble(4, c.getPrice() * c.getQuantity()); // Subtotal
                    pst2.setString(5, c.getVariation());
                    pst2.setString(6, c.getAddon());
                    pst2.setString(7, c.getDesignImage());

                    pst2.executeUpdate(); // Jalankan insert untuk setiap barang
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error in OrderDao: " + e.getMessage());
            e.printStackTrace();
        }

        return orderId;
    }
}