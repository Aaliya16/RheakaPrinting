package com.example.rheakaprinting.model;

//order model extending Prpduct to represent a confirmed purchase transaction.
public class Order extends Product {
    private int orderId;
    private int uId;
    private int quantity;
    private String date;
    private String status;
    private String shippingAddress;
    private double totalAmount;
    private String phoneNumber;
    private String paymentMethod;
    private String email;

    public Order() {
    }

    // Constructor Updated
    public Order(int orderId, int uId, int quantity, String date, String status, String shippingAddress, double totalAmount, String paymentMethod) {
        this.orderId = orderId;
        this.uId = uId;
        this.setQuantity(quantity);
        this.date = date;
        this.status = status;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
    }

    //GETTERS AND SETTERS
    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUid() {
        return uId;
    }

    public void setUid(int uId) {
        this.uId = uId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", date='" + date + '\'' +
                ", status='" + status + '\'' +
                ", address='" + shippingAddress + '\'' +
                ", payment='" + paymentMethod + '\'' +
                ", total=" + totalAmount +
                ", email='" + email + '\'' +
                '}';
    }
}