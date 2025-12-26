package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.User;
import com.example.rheakaprinting.model.DbConnection;
import java.sql.*;

public class UserDAO {

    // --- METHOD REGISTER ---
    public boolean registerUser(User newUser) {
        // Pastikan nama column (name, email, password, role) SAMA dengan database awak
        String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";

        try {
            // 1. Guna DbConnection (JANGAN guna DriverManager manual)
            Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            // 2. Masukkan data
            ps.setString(2, newUser.getName());
            ps.setString(3, newUser.getEmail());
            ps.setString(4, newUser.getPassword());
            ps.setString(5, "customer"); // Default role user biasa

            // 3. Execute
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- METHOD LOGIN (AUTHENTICATE) ---
    public User authenticate(String email, String password) {
        User user = null;

        // Login guna email & password
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try {
            // 1. Guna DbConnection
            Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                // Pastikan nama column dalam kurungan "" SAMA dengan database
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                // Debugging - check what role is retrieved
                System.out.println("User authenticated: " + user.getName() + ", Role: " + user.getRole());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}