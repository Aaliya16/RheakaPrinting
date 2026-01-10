package com.example.rheakaprinting.model;

public class Cart extends Product {
    private int stock;
    private String variation;
    private String addon;
    private String designImage;

    public Cart() {
    }

    // Constructor
    public Cart(int id, int quantity, double price) {
        super.setId(id); // Guna setter dari Product
        super.setQuantity(quantity);
        super.setPrice(price);
    }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getVariation() { return variation; }
    public void setVariation(String variation) { this.variation = variation; }

    public String getAddon() { return addon; }
    public void setAddon(String addon) { this.addon = addon; }

    public String getDesignImage() { return designImage; }
    public void setDesignImage(String designImage) { this.designImage = designImage; }

    @Override
    public String toString() {
        return "Cart{" +
                "id=" + getId() +
                ", name='" + getName() + '\'' +
                ", price=" + getPrice() +
                ", quantity=" + getQuantity() +
                ", variation='" + variation + '\'' + // ✅ Penting untuk debug
                ", addon='" + addon + '\'' +         // ✅ Penting untuk debug
                '}';
    }
}
