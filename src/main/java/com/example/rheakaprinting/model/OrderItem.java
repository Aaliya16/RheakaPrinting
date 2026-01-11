package com.example.rheakaprinting.model;

public class OrderItem {
    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private double price;
    private String variation;
    private String addon;
    private String designImage;

    // Default Constructor
    public OrderItem() {}

    // Getters and Setters - These fix the "Cannot resolve method" errors
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getVariation() { return variation; }
    public void setVariation(String variation) { this.variation = variation; }

    public String getAddon() { return addon; }
    public void setAddon(String addon) { this.addon = addon; }

    public String getDesignImage() { return designImage; }
    public void setDesignImage(String designImage) { this.designImage = designImage; }
}
