package com.example.rheakaprinting.model;

public class Order extends Product {
    private int orderId;
    private int uId;
    // quantity dah ada dalam Product, tapi kalau nak override takpa
    private String date;
    private String status;
    private String shippingAddress;
    private double totalAmount;
    private String phoneNumber;

    // ✅ TAMBAH INI
    private String paymentMethod;

    public Order() {
    }

    // Constructor Updated
    public Order(int orderId, int uId, int quantity, String date, String status, String shippingAddress, double totalAmount, String paymentMethod) {
        this.orderId = orderId;
        this.uId = uId;
        this.setQuantity(quantity); // Dari Product
        this.date = date;
        this.status = status;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
    }

    // --- GETTERS & SETTERS BARU ---

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    // --- GETTERS & SETTERS LAMA ---

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUid() { return uId; }
    public void setUid(int uId) { this.uId = uId; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", date='" + date + '\'' +
                ", status='" + status + '\'' +
                ", address='" + shippingAddress + '\'' +
                ", payment='" + paymentMethod + '\'' + // ✅ Update toString
                ", total=" + totalAmount +
                '}';
    }
}