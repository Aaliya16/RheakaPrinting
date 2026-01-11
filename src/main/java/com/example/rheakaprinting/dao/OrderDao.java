package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    private Connection con;

    public OrderDao(Connection con) {
        this.con = con;
    }

    // --- 1. GET ALL ORDERS (Main Table View) ---
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        try {
            // FIXED: JOINs orders.user_id with users.id to match your DB
            String query = "SELECT orders.*, users.name FROM orders " +
                    "JOIN users ON orders.user_id = users.id " +
                    "ORDER BY orders.order_id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setName(rs.getString("name"));
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

    // --- 2. GET ORDER ITEMS (For the Eye Icon/Details View) ---
    public List<OrderItem> getItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_details WHERE order_id = ?";
        try (PreparedStatement ps = this.con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setVariation(rs.getString("variation"));
                item.setAddon(rs.getString("addon"));
                item.setDesignImage(rs.getString("design_image"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    // --- 3. UPDATE ORDER STATUS ---
    public boolean updateOrderStatus(int id, String status) {
        boolean result = false;
        try {
            String query = "UPDATE orders SET status=? WHERE order_id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, id);
            result = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // --- 4. CREATE NEW ORDER (Checkout Logic) ---
    public int createOrder(int userId, List<Cart> cartList, double total, String address, String phone, String payment) {
        int orderId = 0;
        try {
            String query = "INSERT INTO orders (user_id, total_amount, address, phone_number, status, order_date, payment_method) VALUES (?, ?, ?, ?, 'Pending', NOW(), ?)";
            PreparedStatement pst = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, userId);
            pst.setDouble(2, total);
            pst.setString(3, address);
            pst.setString(4, phone);
            pst.setString(5, payment);

            if (pst.executeUpdate() > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) orderId = rs.getInt(1);

                String query2 = "INSERT INTO order_details (order_id, product_id, quantity, price, variation, addon, design_image) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pst2 = this.con.prepareStatement(query2);
                for (Cart c : cartList) {
                    pst2.setInt(1, orderId);
                    pst2.setInt(2, c.getId());
                    pst2.setInt(3, c.getQuantity());
                    pst2.setDouble(4, c.getPrice() * c.getQuantity());
                    pst2.setString(5, c.getVariation());
                    pst2.setString(6, c.getAddon());
                    pst2.setString(7, c.getDesignImage());
                    pst2.executeUpdate();
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return orderId;
    }
}