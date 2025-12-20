package com.example.rheakaprinting.model;

public class Product {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private String description;
    private String category;
    private int stock;


  public Product(int id, String name, double price, int quantity, String description, String category, int stock) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.quantity = quantity;
    this.description = description;

    this.category = category;
    this.stock = stock;

}

public String getName() { return name; }
public double getPrice() { return price; }

}
