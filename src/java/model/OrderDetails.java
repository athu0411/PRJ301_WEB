/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author vient
 */
public class OrderDetails {
    private Integer orderDetailsID;
    private Integer orderID;
    private Integer productID;
    private Integer quantity;
    private Double price;

    public OrderDetails() {
    }

    public OrderDetails(Integer orderDetailsID, Integer orderID, Integer productID, Integer quantity, Double price) {
        this.orderDetailsID = orderDetailsID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.price = price;
    }
    
    public OrderDetails(Integer orderID, Integer productID, Integer quantity, Double price) {
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.price = price;
    }

    public Integer getOrderDetailsID() {
        return orderDetailsID;
    }

    public void setOrderDetailsID(Integer orderDetailsID) {
        this.orderDetailsID = orderDetailsID;
    }

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
    
    
}
