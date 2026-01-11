package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Cart;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//Data Access Object for managing shopping cart operations in the database.
public class CartDao {
    private Connection con;

    //Initialize with a database connection
    public CartDao(Connection con) {
        this.con = con;
    }

    //Saves a single item into the cart_items table for a specific user
    public boolean insertCartItem(Cart cart, int userId) {
        boolean result = false;
        String query = "INSERT INTO cart_items (user_id, product_id, quantity, price_at_added) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            pst.setInt(1, userId);
            pst.setInt(2, cart.getId());
            pst.setInt(3, cart.getQuantity());
            pst.setDouble(4, cart.getPrice());

            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            System.err.println("❌ Database Insert Error: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    //Retrieves all items in a user's cart by joining cart_items with the products table
    public List<Cart> getCartItemsByUserId(int userId) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT c.*, p.name, p.image, p.stock_quantity FROM cart_items c " +
                "JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            pst.setInt(1, userId);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Cart row = new Cart();
                    row.setId(rs.getInt("product_id"));
                    row.setName(rs.getString("name"));
                    row.setImage(rs.getString("image"));
                    row.setPrice(rs.getDouble("price_at_added"));
                    row.setQuantity(rs.getInt("quantity"));
                    row.setStock(rs.getInt("stock_quantity"));
                    list.add(row);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    //Removes all items from the cart for a specific user (usually after checkout)
    public boolean clearCartByUserId(int userId) {
        String query = "DELETE FROM cart_items WHERE user_id = ?";
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            pst.setInt(1, userId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }
}