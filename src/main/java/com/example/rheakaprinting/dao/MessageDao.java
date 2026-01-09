package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Message;
import java.sql.*;
import java.util.*;

public class MessageDao {
    private Connection con;

    public MessageDao(Connection con) {
        this.con = con;
    }

    public List<Message> getAllMessages() {
        List<Message> list = new ArrayList<>();
        try {
            // Make sure your table name is 'contact_messages'
            String query = "SELECT * FROM contact_messages ORDER BY id DESC";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setName(rs.getString("name"));
                msg.setEmail(rs.getString("email"));
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
}
