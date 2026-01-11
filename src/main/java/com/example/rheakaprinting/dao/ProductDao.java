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

    // PENTING: Gunakan nama kolum 'stock_quantity' secara konsisten jika itu yang ada di DB
    private static final String COL_STOCK = "stock_quantity";

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        try (PreparedStatement pst = this.con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Product row = new Product();
                row.setId(rs.getInt("id"));
                row.setName(rs.getString("name"));
                row.setCategory(rs.getString("category"));
                row.setPrice(rs.getDouble("price"));
                row.setImage(rs.getString("image"));
                row.setQuantity(rs.getInt(COL_STOCK));
                products.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean addProduct(Product p) {
        boolean result = false;
        // Dibaiki: Guna COL_STOCK (stock_quantity)
        String query = "INSERT INTO products (name, category, price, " + COL_STOCK + ") VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = this.con.prepareStatement(query)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            result = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean reduceStock(int productId, int quantityPurchased) {
        boolean result = false;
        String query = "UPDATE products SET " + COL_STOCK + " = " + COL_STOCK + " - ? WHERE id = ? AND " + COL_STOCK + " >= ?";
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            pst.setInt(1, quantityPurchased);
            pst.setInt(2, productId);
            pst.setInt(3, quantityPurchased);
            result = pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> cartProducts = new ArrayList<>();
        try {
            if (cartList != null && cartList.size() > 0) {
                for (Cart item : cartList) {
                    // Pastikan SELECT * atau pilih kolum stok secara spesifik
                    query = "SELECT * FROM products WHERE id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        Cart row = new Cart();
                        row.setId(rs.getInt("id"));
                        row.setName(rs.getString("name"));
                        row.setImage(rs.getString("image"));
                        row.setPrice(item.getPrice());
                        row.setQuantity(item.getQuantity());
                        row.setStock(rs.getInt(COL_STOCK));

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

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList != null && cartList.size() > 0) {
                for (Cart item : cartList) {
                    sum += item.getPrice() * item.getQuantity();
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getTotalCartPrice: " + e.getMessage());
            e.printStackTrace();
        }
        return sum;
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
                p.setCategory(rs.getString("category"));
                int dbStock = rs.getInt("stock_quantity");
                p.setStock(dbStock);
                p.setQuantity(dbStock);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }

    public boolean updateProduct(Product p) {
        boolean result = false;
        try {
            String query = "UPDATE products SET name=?, price=?, stock_quantity=?, category=? WHERE id=?";
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


