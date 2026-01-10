package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Cart;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {
    private Connection con;

    public CartDao(Connection con) {
        this.con = con;
    }

    // Simpan item ke database bila user klik "Add to Cart"
    public boolean insertCartItem(Cart cart, int userId) {
        boolean result = false;
        try {
            String query = "INSERT INTO cart_items (user_id, product_id, variation, addon, quantity, price_at_added) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            pst.setInt(2, cart.getId());
            pst.setString(3, cart.getVariation());
            pst.setString(4, cart.getAddon());
            pst.setInt(5, cart.getQuantity());
            pst.setDouble(6, cart.getPrice());

            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean clearCartByUserId(int userId) {
        boolean result = false;
        try {
            String query = "DELETE FROM cart_items WHERE user_id = ?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);

            int row = pst.executeUpdate();
            if (row > 0) {
                result = true;
                System.out.println("✅ Database cart cleared for User: " + userId);
            }
        } catch (SQLException e) {
            System.err.println("Error in clearCartByUserId: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // Ambil semua item cart bila user login balik
    public List<Cart> getCartItemsByUserId(int userId) {
        List<Cart> list = new ArrayList<>();
        try {
            // Join dengan table products untuk dapatkan nama & image terkini
            String query = "SELECT c.*, p.name, p.image, p.stock_quantity FROM cart_items c " +
                    "JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Cart row = new Cart();
                row.setId(rs.getInt("product_id"));
                row.setName(rs.getString("name"));
                row.setImage(rs.getString("image"));
                row.setPrice(rs.getDouble("price_at_added"));
                row.setQuantity(rs.getInt("quantity"));
                row.setVariation(rs.getString("variation"));
                row.setAddon(rs.getString("addon"));
                row.setStock(rs.getInt("stock_quantity"));
                list.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}