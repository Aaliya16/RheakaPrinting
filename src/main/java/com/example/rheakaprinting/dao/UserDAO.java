package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.User;

import java.sql.*;

public class UserDAO {
    private String url = "jdbc:mysql://localhost:3306/ecommerce_db";
    private String user = "root";
    private String pass = "PASSWORD_ANDA"; // Masukkan password MySQL anda

    public boolean registerUser(User newUser) {
        String sql = "INSERT INTO Users (username, password, email, full_name, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newUser.getUsername());
            ps.setString(2, newUser.getPassword()); // Sebaiknya di-hash untuk Security
            ps.setString(3, newUser.getEmail());
            ps.setString(4, newUser.getFullName());
            ps.setString(5, newUser.getRole());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}