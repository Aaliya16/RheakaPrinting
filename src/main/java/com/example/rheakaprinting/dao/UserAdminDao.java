package com.example.rheakaprinting.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.rheakaprinting.model.User;

public class UserAdminDao {
    private Connection con;

    public UserAdminDao(Connection con) {
        this.con = con;
    }

    // Admin login with role verification
    public User adminLogin(String email, String password) {
        User admin = null;
        try {
            String query = "SELECT * FROM users WHERE email=? AND password=? AND role='admin'";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                admin = new User();
                admin.setUserId(rs.getInt("user_id"));  // ← Fixed
                admin.setUsername(rs.getString("username"));  // ← Fixed
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }

    // Get all users for admin dashboard
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            String query = "SELECT user_id, username, name, email, role FROM users ORDER BY user_id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));  // ← Fixed
                user.setUsername(rs.getString("username"));  // ← Fixed
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Add new user
    public boolean addUser(String username, String name, String email, String password, String role) {
        try {
            String query = "INSERT INTO users (username, name, email, password, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, role);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update user
    public boolean updateUser(int userId, String username, String name, String email, String role) {
        try {
            String query = "UPDATE users SET username=?, name=?, email=?, role=? WHERE user_id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, role);
            ps.setInt(5, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete user
    public boolean deleteUser(int userId) {
        try {
            String query = "DELETE FROM users WHERE user_id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get user by ID
    public User getUserById(int userId) {
        User user = null;
        try {
            String query = "SELECT * FROM users WHERE user_id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Get total user count (for dashboard stats)
    public int getTotalUsers() {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) as total FROM users";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get admin count
    public int getAdminCount() {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) as total FROM users WHERE role='admin'";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}