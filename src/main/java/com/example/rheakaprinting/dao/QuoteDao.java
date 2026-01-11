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
        // DIBAIKI: Tukar 'user_id' kepada 'u_id' mengikut skema database anda
        String query = "INSERT INTO quotes (u_id, name, email, phone, product, quantity, note, file_name, file_path) VALUES (?,?,?,?,?,?,?,?,?)";

        try (PreparedStatement pst = this.con.prepareStatement(query)) {

            // Set u_id ke null jika user tidak login (Guest Quote)
            if (quote.getUserId() > 0) {
                pst.setInt(1, quote.getUserId());
            } else {
                pst.setNull(1, java.sql.Types.INTEGER);
            }

            pst.setString(2, quote.getName());
            pst.setString(3, quote.getEmail());
            pst.setString(4, quote.getPhone());
            pst.setString(5, quote.getProduct());
            pst.setInt(6, quote.getQuantity());
            pst.setString(7, quote.getNote());
            pst.setString(8, quote.getFileName());
            pst.setString(9, quote.getFilePath());

            int rowAffected = pst.executeUpdate();
            if (rowAffected > 0) {
                result = true;
                System.out.println("✅ Quote saved successfully for: " + quote.getName());
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in saveQuote: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}