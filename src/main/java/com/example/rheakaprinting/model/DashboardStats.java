package com.example.rheakaprinting.model;

public class DashboardStats {
    private int totalOrders;
    private int pendingQuotes;
    private int totalCustomers;
    private double totalRevenue;

    public DashboardStats(int totalOrders, int pendingQuotes, int totalCustomers, double totalRevenue) {
        this.totalOrders = totalOrders;
        this.pendingQuotes = pendingQuotes;
        this.totalCustomers = totalCustomers;
        this.totalRevenue = totalRevenue;
    }

    public int getTotalOrders() { return totalOrders; }
    public int getPendingQuotes() { return pendingQuotes; }
    public int getTotalCustomers() { return totalCustomers; }
    public double getTotalRevenue() { return totalRevenue; }
}