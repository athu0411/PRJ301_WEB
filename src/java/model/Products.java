/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author vient
 */
    public class Products {
    private Integer productID;
    private String productName;
    private String description;
    private Double price;
    private Integer quantity;
    private String imgUrl;
    private Integer categoryID;

    public Products() {
    }

    public Products(Integer productID, String productName, String description, Double price, Integer quantity, String imgUrl, Integer categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.imgUrl = imgUrl;
        this.categoryID = categoryID;
    }
    
    public Products(String productName, String description, Double price, Integer quantity, String imgUrl, Integer categoryID) {
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.imgUrl = imgUrl;
        this.categoryID = categoryID;
    }

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Integer categoryID) {
        this.categoryID = categoryID;
    }
    
    
    
}
