package com.example.rheakaprinting.dao;

import com.example.rheakaprinting.model.Order;
import com.example.rheakaprinting.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    // 1. Isytiharkan variable Connection
    private Connection con;

    // 2. Buat Constructor untuk terima Connection
    public OrderDao(Connection con) {
        this.con = con;
    }

    // Method untuk dapatkan senarai order bagi user tertentu
    public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM orders WHERE u_id=? ORDER BY order_id DESC";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Order order = new Order();

                // Ambil data produk menggunakan ProductDao
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");

                // ERROR FIXED: Guna method yang betul 'getProductById'
                Product product = productDao.getProductById(pId);

                order.setOrderId(rs.getInt("order_id"));
                order.setId(pId);

                // Pastikan product wujud sebelum ambil nama/kategori
                if(product != null) {
                    order.setName(product.getName());
                    order.setCategory(product.getCategory());
                    // Harga = Harga Unit * Kuantiti Order
                    order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                }

                order.setQuantity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));

                // ERROR POTENTIAL: Pastikan column 'status' wujud dalam DB orders
                // Kalau tak wujud, buang baris ni atau tambah column dalam DB
                // order.setStatus(rs.getString("status"));

                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean updateOrderStatus(int orderId, String status) {
        try {
            String query = "UPDATE orders SET status=? WHERE order_id=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, status);
            pst.setInt(2, orderId);
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
