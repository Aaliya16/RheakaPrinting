package com.example.rheakaprinting.model;

//Cart model extending product to include session-specific data.
public class Cart extends Product {
    private int stock;
    private String designImage;

    //Constructor for basic cart item initialization.
    public Cart() {
    }

    // Constructor
    public Cart(int id, int quantity, double price) {
        super.setId(id); // Guna setter dari Product
        super.setQuantity(quantity);
        super.setPrice(price);
    }

    // Getters and Setters
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getDesignImage() { return designImage; }
    public void setDesignImage(String designImage) { this.designImage = designImage; }

    @Override
    public String toString() {
        return "Cart{" +
                "id=" + getId() +
                ", name='" + getName() + '\'' +
                ", price=" + getPrice() +
                ", quantity=" + getQuantity() +
                '}';
    }
}
