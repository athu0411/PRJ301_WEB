/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.DatabaseConnection;

/**
 *
 * @author vient
 */
public class OrderDetailDAO {
    public boolean addOrderDetail(int orderID, String productID, int quantity, double price)
        throws SQLException, ClassNotFoundException {
    boolean result = false;
    String sql = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";

    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, orderID);
        stmt.setString(2, productID);
        stmt.setInt(3, quantity);
        stmt.setDouble(4, price);

        result = stmt.executeUpdate() > 0;
    }

    return result;
}

}
