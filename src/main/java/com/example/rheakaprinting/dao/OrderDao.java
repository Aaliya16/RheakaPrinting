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
    public int createOrder(int userId, List<Cart> cartList, double totalAmount, String address, String phone) {
        int orderId = 0;
        try {
            // INSERT INTO ORDERS
            String query = "INSERT INTO orders (user_id, total_amount, address, phone_number, status, order_date) VALUES (?, ?, ?, ?, 'Pending', NOW())";
            PreparedStatement pst = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, userId);
            pst.setDouble(2, totalAmount);
            pst.setString(3, address);
            pst.setString(4, phone);

            if (pst.executeUpdate() > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) orderId = rs.getInt(1);

                // INSERT INTO ORDER_DETAILS
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
        } catch (SQLException e) {
            e.printStackTrace();
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
                order.setShippingAddress(rs.getString("address")); // Fixed column name
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
            // Note: We join with users table to get the customer's name for the admin view
            String query = "SELECT orders.*, users.name FROM orders JOIN users ON orders.user_id = users.id ORDER BY orders.id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("id"));
                order.setName(rs.getString("name")); // From users table
                order.setPrice(rs.getDouble("total_amount")); // total_amount maps to the order's value
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
    // Update this in your OrderDao.java
    public int createOrder(int userId, List<Cart> cartList, double totalAmount, String address, String phone, String paymentMethod) {
        int orderId = 0;
        try {
            // Added payment_method to the SQL query
            String query = "INSERT INTO orders (user_id, total_amount, address, phone_number, status, order_date, payment_method) VALUES (?, ?, ?, ?, 'Pending', NOW(), ?)";

            PreparedStatement pst = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, userId);
            pst.setDouble(2, totalAmount);
            pst.setString(3, address);
            pst.setString(4, phone);
            pst.setString(5, paymentMethod); // This is the new 5th parameter for the SQL

            if (pst.executeUpdate() > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) orderId = rs.getInt(1);

                // Insert into order_details (Logic remains the same)
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }
}