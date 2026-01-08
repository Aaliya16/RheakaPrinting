package com.example.rheakaprinting.model;

public class Order extends Product {
    private int orderId;
    private int uId;
    private int quantity;
    private String date;
    private String status;
    private String shippingAddress;
    public Order() {
    }

    public Order(int orderId, int uId, int quantity, String date, String status, String shippingAddress) {
        this.orderId = orderId;
        this.uId = uId;
        this.quantity = quantity;
        this.date = date;
        this.status = status;
        this.shippingAddress = shippingAddress;
    }

    public Order(int uId, int quantity, String date, String shippingAddress) {
        this.uId = uId;
        this.quantity = quantity;
        this.date = date;
        this.shippingAddress = shippingAddress;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", uId=" + uId +
                ", quantity=" + quantity +
                ", date='" + date + '\'' +
                ", status='" + status + '\'' +
                ", shippingAddress='" + shippingAddress + '\'' + // <-- Tambah baris ini
                '}';
    }
}
