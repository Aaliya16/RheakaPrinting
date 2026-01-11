package com.example.rheakaprinting.model;
import java.sql.*;

//Utility class to manage mySQL database connectivity
public class DbConnection {
    //Establish and returns a connection to the local mySQL database.
    public static Connection getConnection() {
        try{
            //load the mySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            //connect using a database url, username and password
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rheaka_db","root","1234");
            return con;
        }catch(Exception e){
            //Log connection failures for debugging
            System.err.println("❌ Database Connection Error: " + e.getMessage());
            return null;
        }
    }
}
