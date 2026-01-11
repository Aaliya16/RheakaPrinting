package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Quote;
import java.sql.*;
import java.util.*;

public class QuoteDao {
    private Connection con;

    public QuoteDao(Connection con) {
        this.con = con;
    }

    // This method fixes the red error in SubmitQuoteServlet
    public boolean saveQuote(Quote quote) {
        boolean result = false;
        String query = "INSERT INTO quotes (u_id, name, email, phone, product, quantity, note, file_name, file_path) VALUES (?,?,?,?,?,?,?,?,?)";
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
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

            if (pst.executeUpdate() > 0) result = true;
        } catch (SQLException e) { e.printStackTrace(); }
        return result;
    }

    public List<Quote> getAllQuotes() {
        List<Quote> list = new ArrayList<>();
        String query = "SELECT * FROM quotes ORDER BY created_at DESC";
        try (PreparedStatement ps = this.con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Quote q = new Quote();
                q.setQuoteId(rs.getInt("quote_id"));
                q.setUserId(rs.getInt("u_id"));
                q.setName(rs.getString("name"));
                q.setEmail(rs.getString("email"));
                q.setPhone(rs.getString("phone"));
                q.setProduct(rs.getString("product"));
                q.setQuantity(rs.getInt("quantity"));
                q.setNote(rs.getString("note"));
                q.setFileName(rs.getString("file_name"));
                q.setFilePath(rs.getString("file_path"));
                q.setStatus(rs.getString("status"));
                list.add(q);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean updateQuoteStatus(int quoteId, String newStatus) {
        String query = "UPDATE quotes SET status = ? WHERE quote_id = ?";
        try (PreparedStatement ps = this.con.prepareStatement(query)) {
            ps.setString(1, newStatus);
            ps.setInt(2, quoteId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}