package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Order;
import java.sql.*;
import java.util.*;

public class OrderAdminDao {
    private Connection con;

    public OrderAdminDao(Connection con) {
        this.con = con;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            // Ensure table name and order column match your DB
            String query = "SELECT * FROM orders ORDER BY order_id DESC";
            PreparedStatement pst = this.con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Order row = new Order();

                // Standardizing based on your Order Model
                row.setOrderId(rs.getInt("order_id"));
                row.setUid(rs.getInt("u_id"));
                row.setQuantity(rs.getInt("o_quantity"));
                row.setDate(rs.getString("o_date"));
                row.setStatus(rs.getString("status"));
                row.setShippingAddress(rs.getString("shipping_address"));

                // These are inherited from Product
                row.setName(rs.getString("p_name"));
                row.setPrice(rs.getDouble("p_price"));

                orders.add(row);
            }
        } catch (Exception e) {
            System.out.println("Error in OrderAdminDao: " + e.getMessage());
        }
        return orders;
    }
}
