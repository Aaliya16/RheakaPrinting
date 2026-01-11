package com.example.rheakaprinting.model;

//Base model representing a product in the catalog
public class Product {
    private int id;
    private String name;
    private String category;
    private double price;
    private String image;
    private int quantity; //typically used for user-selected quantity
    private String description;
    private int stock; // physical stock available in the warehouse

    public Product() {
    }

    //Parameterized constructor for product initialization.
    public Product(int id, String name, String category, double price, String image, int quantity, String description, int stock) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.image = image;
        this.quantity = quantity;
        this.description = description;
        this.stock = stock;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() { return quantity; }

    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getDescription() {return description; }

    public void setDescription(String description) { this.description = description; }

    public int getStock() { return stock; }

    public void setStock(int stock) { this.stock = stock; }
}

