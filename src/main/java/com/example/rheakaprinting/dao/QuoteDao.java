package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Quote;
import java.sql.*;

public class QuoteDao {
    private Connection con;

    public QuoteDao(Connection con) {
        this.con = con;
    }

    public boolean saveQuote(Quote quote) {
        boolean result = false;
        try {
            String query = "INSERT INTO quotes (user_id, name, email, phone, product, quantity, note, file_name, file_path) VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = this.con.prepareStatement(query);

            // Set userId ke 0 atau null jika tidak login
            if(quote.getUserId() > 0) pst.setInt(1, quote.getUserId());
            else pst.setNull(1, Types.INTEGER);

            pst.setString(2, quote.getName());
            pst.setString(3, quote.getEmail());
            pst.setString(4, quote.getPhone());
            pst.setString(5, quote.getProduct());
            pst.setInt(6, quote.getQuantity());
            pst.setString(7, quote.getNote());
            pst.setString(8, quote.getFileName());
            pst.setString(9, quote.getFilePath());

            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}