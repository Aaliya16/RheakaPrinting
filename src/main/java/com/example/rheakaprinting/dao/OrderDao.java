package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Cart;
import com.example.rheakaprinting.model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//Data Access Object for managing customer orders and inventory synchronization.
public class OrderDao {
    private Connection con;

    public OrderDao(Connection con) {
        this.con = con;
    }

    // --- METHOD 1: CREATE ORDER (Customer Checkout) ---
    public int createOrder(int userId, List<Cart> cartList, double totalAmount, String address, String phone, String paymentMethod, String fullName, String email, String orderNotes) {
        int orderId = 0;
        try {
            //Start Transaction : Prevent partial data entry if an error occurs
            con.setAutoCommit(false);

            String query = "INSERT INTO orders (user_id, total_amount, address, phone_number, status, order_date, payment_method, recipient_name, recipient_email, order_notes) VALUES (?, ?, ?, ?, 'Pending', NOW(), ?, ?, ?, ?)";
            PreparedStatement pst = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            // FIXED: Parameter mapping now matches SQL column order
            pst.setInt(1, userId);              // user_id
            pst.setDouble(2, totalAmount);      // total_amount
            pst.setString(3, address);          // address
            pst.setString(4, phone);            // phone_number
            // position 5 = 'Pending' (hardcoded in SQL)
            // position 6 = NOW() (hardcoded in SQL)
            pst.setString(5, paymentMethod);    // payment_method (? position 5 in VALUES)
            pst.setString(6, fullName);         // recipient_name (? position 6 in VALUES)
            pst.setString(7, email);            // recipient_email (? position 7 in VALUES)
            pst.setString(8, orderNotes);       // order_notes (? position 8 in VALUES)

            if (pst.executeUpdate() > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) orderId = rs.getInt(1);

                String queryDetails = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                String queryStock = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";

                PreparedStatement pstDetails = this.con.prepareStatement(queryDetails);
                PreparedStatement pstStock = this.con.prepareStatement(queryStock);

                //Process each item in the cart
                for (Cart c : cartList) {
                    // save item record
                    pstDetails.setInt(1, orderId);
                    pstDetails.setInt(2, c.getId());
                    pstDetails.setInt(3, c.getQuantity());
                    pstDetails.setDouble(4, c.getPrice());
                    pstDetails.executeUpdate();

                    pstStock.setInt(1, c.getQuantity());
                    pstStock.setInt(2, c.getId());
                    pstStock.setInt(3, c.getQuantity());

                    int stockCheck = pstStock.executeUpdate();
                    if (stockCheck == 0) {
                        throw new SQLException("Insufficient stock for Product ID: " + c.getId());
                    }
                }

                con.commit();
                System.out.println("Success: Order placed and stock updated.");
            }
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
                System.err.println("Transaction Failed: Rollback executed. " + e.getMessage());
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

    //fetches order history for a specific customer
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

            String query = "SELECT orders.*, orders.recipient_name, orders.recipient_email FROM orders ORDER BY orders.id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("id"));
                order.setName(rs.getString("recipient_name"));  // FIXED: Use recipient_name from orders table
                order.setEmail(rs.getString("recipient_email")); // FIXED: Get email too
                order.setShippingAddress(rs.getString("address"));
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