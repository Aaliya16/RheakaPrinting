package com.example.rheakaprinting.model;
import java.sql.*;
public class DbConnection {
    public static Connection getConnection() {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rheaka_db","root","");
            return con;
        }catch(Exception e){
            System.out.print(e);
            return null;
        }
    }
}
