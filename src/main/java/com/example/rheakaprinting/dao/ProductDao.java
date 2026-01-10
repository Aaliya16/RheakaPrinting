package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Cart;
import com.example.rheakaprinting.model.Product;
import java.sql.*;
import java.util.*;

public class ProductDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ProductDao(Connection con) {
        this.con = con;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            query = "SELECT * FROM products";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Product row = new Product();
                row.setId(rs.getInt("id"));
                row.setName(rs.getString("name"));
                row.setCategory(rs.getString("category"));
                row.setPrice(rs.getDouble("price"));
                row.setImage(rs.getString("image"));

                products.add(row);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllProducts: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }

    /**
     * Get cart products with details from database
     * ✅ FIXED: Tidak multiply price dengan quantity di sini
     */
    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> cartProducts = new ArrayList<>();
        try {
            if (cartList != null && cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "SELECT * FROM products WHERE id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        Cart row = new Cart();
                        row.setId(rs.getInt("id"));
                        row.setName(rs.getString("name"));
                        row.setImage(rs.getString("image"));

                        // ✅ PENTING: Guna price dari item (yang dah customize),
                        // BUKAN dari database (base price sahaja)
                        row.setPrice(item.getPrice()); // Unit price dari cart
                        row.setQuantity(item.getQuantity());

                        cartProducts.add(row);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getCartProducts: " + e.getMessage());
            e.printStackTrace();
        }
        return cartProducts;
    }

    /**
     * Calculate total cart price
     * ✅ FIXED: Tidak multiply price dengan quantity di database query
     */
    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList != null && cartList.size() > 0) {
                for (Cart item : cartList) {
                    // ✅ Guna price dari cart item terus
                    // (dah include addons & customization)
                    sum += item.getPrice() * item.getQuantity();
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getTotalCartPrice: " + e.getMessage());
            e.printStackTrace();
        }
        return sum;
    }

    /**
     * Get single product by ID
     */
    public Product getProductById(int id) {
        Product product = null;
        try {
            query = "SELECT * FROM products WHERE id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getDouble("price"));
                product.setImage(rs.getString("image"));
            }
        } catch (SQLException e) {
            System.err.println("Error in getProductById: " + e.getMessage());
            e.printStackTrace();
        }
        return product;
    }
    public boolean addProduct(Product p) {
        boolean result = false;
        try {
            String query = "INSERT INTO products (name, category, price, quantity) VALUES (?, ?, ?, ?)";
            java.sql.PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());

            int rows = ps.executeUpdate();
            if (rows > 0) result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public boolean deleteProduct(int id) {
        boolean result = false;
        try {
            String query = "DELETE FROM products WHERE id=?";
            java.sql.PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            if (rows > 0) result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    // Fetch one product by ID
    public Product getSingleProduct(int id) {
        Product p = null;
        try {
            String query = "SELECT * FROM products WHERE id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setCategory(rs.getString("category"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }

    // Update the database
    public boolean updateProduct(Product p) {
        boolean result = false;
        try {
            String query = "UPDATE products SET name=?, price=?, quantity=?, category=? WHERE id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getQuantity());
            ps.setString(4, p.getCategory());
            ps.setInt(5, p.getId());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return result;
    }
}

