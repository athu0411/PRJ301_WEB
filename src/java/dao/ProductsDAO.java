/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Products;
import util.DatabaseConnection;

/**
 *
 * @author vient
 */
public class ProductsDAO {

    public boolean addProduct(Products product) throws SQLException, ClassNotFoundException {
        boolean result = false;
        String sql = "INSERT INTO products (ProductName, Description, Price, Quantity, ImageURL, CategoryID) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getQuantity());
            stmt.setString(5, product.getImgUrl());
            stmt.setInt(6, product.getCategoryID());

            result = stmt.executeUpdate() > 0;
        }
        return result;
    }

    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        boolean result = false;
        String sql = "DELETE FROM products WHERE ProductID = ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            result = stmt.executeUpdate() > 0;
        }
        return result;
    }

    public Products getProductById(int productId) throws SQLException, ClassNotFoundException {
        Products result = null;
        String sql = "SELECT ProductID, ProductName, Description, Price, Quantity, ImageURL, CategoryID FROM Products WHERE ProductID = ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Products foundProduct = new Products();
                foundProduct.setProductID(rs.getInt("ProductID"));
                foundProduct.setProductName(rs.getString("ProductName"));
                foundProduct.setDescription(rs.getString("Description"));
                foundProduct.setPrice(rs.getDouble("Price"));
                foundProduct.setQuantity(rs.getInt("Quantity"));
                foundProduct.setImgUrl(rs.getString("ImageURL"));
                foundProduct.setCategoryID(rs.getInt("CategoryID"));
                result = foundProduct;
            }
        }
        return result;
    }

    public boolean updateProduct(Products product) throws SQLException, ClassNotFoundException {
        boolean result = false;
        String sql = "UPDATE FROM Products set ProductName = ?, Description = ?, Price = ?, Quantity = ?, ImageURL = ?, CategoryID = ? WHERE ProductID = ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getQuantity());
            stmt.setString(5, product.getImgUrl());
            stmt.setInt(6, product.getCategoryID());

            result = stmt.executeUpdate() > 0;
        }
        return result;
    }

    public ArrayList<Products> getAllProducts() throws SQLException, ClassNotFoundException {
        ArrayList<Products> productList = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName, Description, Price, Quantity, ImageURL, CategoryID FROM Products";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Products product = new Products();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setImgUrl(rs.getString("ImageURL"));
                product.setCategoryID(rs.getInt("CategoryID"));
                productList.add(product);
            }
        }
        return productList;
    }

    public List<Products> searchProductsByName(String keyword) throws SQLException, ClassNotFoundException {
        List<Products> resultList = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName, Description, Price, Quantity, ImageURL, CategoryID "
                + "FROM Products WHERE ProductName LIKE ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Products product = new Products();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setImgUrl(rs.getString("ImageURL"));
                product.setCategoryID(rs.getInt("CategoryID"));
                resultList.add(product);
            }
        }
        return resultList;
    }

    public List<Products> getProductsByPage(int page, int pageSize) throws SQLException, ClassNotFoundException {
        List<Products> pagedList = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName, Description, Price, Quantity, ImageURL, CategoryID "
                + "FROM Products "
                + "ORDER BY ProductID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; 

        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            int offset = (page - 1) * pageSize;
            stmt.setInt(1, offset);
            stmt.setInt(2, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Products product = new Products();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setImgUrl(rs.getString("ImageURL"));
                product.setCategoryID(rs.getInt("CategoryID"));
                pagedList.add(product);
            }
        }

        return pagedList;
    }

    public int getTotalProductCount() throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) AS total FROM Products";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

}
