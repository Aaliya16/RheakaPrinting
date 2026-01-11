package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Cart;
import com.example.rheakaprinting.model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    private Connection con;

    public OrderDao(Connection con) {
        this.con = con;
    }

    // --- METHOD 1: CREATE ORDER (Customer Checkout) ---
    public int createOrder(int userId, List<Cart> cartList, double totalAmount, String address, String phone, String paymentMethod, String fullName, String email, String orderNotes) {
        int orderId = 0;
        try {
            // A. MULAKAN TRANSAKSI
            con.setAutoCommit(false);

            // 1. Masukkan ke table 'orders' (GUNA recipient_name & recipient_email)
            String query = "INSERT INTO orders (user_id, total_amount, address, phone_number, status, order_date, payment_method, recipient_name, recipient_email, order_notes) VALUES (?, ?, ?, ?, 'Pending', NOW(), ?, ?, ?, ?)";
            PreparedStatement pst = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, userId);
            pst.setDouble(2, totalAmount);
            pst.setString(3, address);
            pst.setString(4, phone);
            pst.setString(5, paymentMethod);
            pst.setString(6, fullName);
            pst.setString(7, email);
            pst.setString(8, orderNotes);

            if (pst.executeUpdate() > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) orderId = rs.getInt(1);

                // 2. Masukkan item ke 'order_details' DAN tolak stok
                String queryDetails = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                String queryStock = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";

                PreparedStatement pstDetails = this.con.prepareStatement(queryDetails);
                PreparedStatement pstStock = this.con.prepareStatement(queryStock);

                for (Cart c : cartList) {
                    // Simpan Detail
                    pstDetails.setInt(1, orderId);
                    pstDetails.setInt(2, c.getId());
                    pstDetails.setInt(3, c.getQuantity());
                    pstDetails.setDouble(4, c.getPrice());
                    pstDetails.executeUpdate();

                    // Tolak Stok
                    pstStock.setInt(1, c.getQuantity());
                    pstStock.setInt(2, c.getId());
                    pstStock.setInt(3, c.getQuantity());

                    int stockCheck = pstStock.executeUpdate();
                    if (stockCheck == 0) {
                        throw new SQLException("Stok tidak mencukupi untuk Produk ID: " + c.getId());
                    }
                }

                con.commit();
                System.out.println("✅ Transaksi Berjaya: Order disimpan & Stok ditolak.");
            }
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
                System.err.println("❌ Transaksi Gagal: Rollback dilakukan. " + e.getMessage());
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            orderId = 0;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }

    // --- METHOD 2: USER ORDERS (Customer "My Orders" Page) ---
    public List<Order> userOrders(int userId) {
        List<Order> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("id"));
                order.setUid(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDate(rs.getString("order_date"));
                order.setStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("address"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- METHOD 3: GET ALL ORDERS (Admin Management) ---
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        try {
            // Join dengan users table untuk dapat customer name
            String query = "SELECT orders.*, users.name FROM orders JOIN users ON orders.user_id = users.id ORDER BY orders.id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("id"));
                order.setName(rs.getString("name")); // Customer name dari users table
                order.setPrice(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDate(rs.getString("order_date"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- METHOD 4: UPDATE ORDER STATUS (Admin Action) ---
    public boolean updateOrderStatus(int id, String status) {
        boolean result = false;
        try {
            String query = "UPDATE orders SET status=? WHERE id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, id);
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}