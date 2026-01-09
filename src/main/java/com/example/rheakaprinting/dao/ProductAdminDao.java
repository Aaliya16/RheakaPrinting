package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.DbConnection;
import com.example.rheakaprinting.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductAdminDao {

    public void addProduct(Product p) {
        String sql = "INSERT INTO products (name, category, price, image, quantity, description, stock) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, p.getName());
            stmt.setString(2, p.getCategory());
            stmt.setDouble(3, p.getPrice());
            stmt.setString(4, p.getImage());
            stmt.setInt(5, p.getQuantity());
            stmt.setString(6, p.getDescription());
            stmt.setInt(7, p.getStock());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY id DESC"; // Added ordering for admin convenience
        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                // Ensure your Product.java constructor matches these 8 parameters
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error in ProductAdminDao.getAllProducts: " + e.getMessage());
        }
        return list;
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}