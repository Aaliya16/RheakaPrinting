package com.example.rheakaprinting.model;

public class Cart extends Product {
    // Variable 'id', 'name', 'price', 'quantity' dah ada dalam Product (Parent).
    // JANGAN declare semula di sini.

    private String variation; // Untuk simpan Product Type/Size
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

    // --- GETTERS & SETTERS (Hanya untuk variable baru) ---
    // Getter Setter untuk ID, Name, Price tak perlu tulis sini sebab Product dah ada.

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