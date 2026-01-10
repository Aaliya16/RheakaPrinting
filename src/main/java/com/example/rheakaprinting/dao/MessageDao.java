package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Message;
import java.sql.*;
import java.util.*;

public class MessageDao {
    private Connection con;

    public MessageDao(Connection con) {
        this.con = con;
    }

    // Fungsi untuk Admin baca mesej
    public List<Message> getAllMessages() {
        List<Message> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM contact_messages ORDER BY id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setName(rs.getString("name"));
                msg.setEmail(rs.getString("email"));
                msg.setPhone(rs.getString("phone"));
                msg.setSubject(rs.getString("subject"));
                msg.setMessage(rs.getString("message"));
                msg.setCreatedAt(rs.getString("created_at"));
                list.add(msg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // FUNGSI BARU: Untuk pelanggan simpan mesej
    public boolean insertMessage(Message msg) {
        boolean result = false;
        try {
            String query = "INSERT INTO contact_messages (name, email, phone, subject, message) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, msg.getName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getPhone());
            ps.setString(4, msg.getSubject());
            ps.setString(5, msg.getMessage());

            int i = ps.executeUpdate();
            if (i == 1) result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}