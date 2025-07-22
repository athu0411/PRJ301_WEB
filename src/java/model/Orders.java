/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.time.LocalDate;

/**
 *
 * @author vient
 */
public class Orders {
    private Integer orderID;
    private Integer userID;
    private Date orderDate;
    private Double totalAmout;
    private String status;

    public Orders() {
    }

    public Orders(Integer orderID, Integer userID, Date orderDate, Double totalAmout, String status) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalAmout = totalAmout;
        this.status = status;
    }
    
    public Orders(Integer userID, Date orderDate, Double totalAmout) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalAmout = totalAmout;
    }

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Double getTotalAmout() {
        return totalAmout;
    }

    public void setTotalAmout(Double totalAmout) {
        this.totalAmout = totalAmout;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
