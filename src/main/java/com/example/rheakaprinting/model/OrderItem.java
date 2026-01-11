package com.example.rheakaprinting.model;

//Stores specific details for printing such as variations and custom design.
public class OrderItem {
    private int id;
    private int orderId; // link to 'orders' table
    private int productId; // link to the 'products' table
    private int quantity;
    private double price; // price at the time of purchase
    private String variation;
    private String addon;
    private String designImage; //path to the uploaded design file

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


    public String getDesignImage() { return designImage; }
    public void setDesignImage(String designImage) { this.designImage = designImage; }
}
