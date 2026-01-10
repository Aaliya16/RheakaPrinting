package com.example.rheakaprinting.dao;

// These imports are required to fix the "Cannot resolve" errors
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class SettingsDao {
    private Connection conn;

    public SettingsDao(Connection conn) {
        this.conn = conn;
    }

    public Map<String, String> getAllSettings() {
        Map<String, String> settings = new HashMap<>();
        String sql = "SELECT setting_key, setting_value FROM system_settings";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                // Populate the map with database values
                settings.put(rs.getString("setting_key"), rs.getString("setting_value"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return settings;
    }

    public void updateSetting(String key, String value) {
        // This SQL works for MySQL to insert or update in one go
        String sql = "INSERT INTO system_settings (setting_key, setting_value) " +
                "VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, key);
            pstmt.setString(2, value);
            pstmt.setString(3, value);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}