/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.Orders;
import util.DatabaseConnection;

/**
 *
 * @author vient
 */
public class OrderDAO {

    public boolean addOrder(Orders order) throws SQLException, ClassNotFoundException {
        boolean result = false;
        String sql = "INSERT INTO Orders (UserID, OrderDate, TotalAmount) VALUES (?, ?, ?)";

        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, order.getUserID());
            stmt.setDate(2, order.getOrderDate()); // java.util.Date -> java.sql.Date
            stmt.setDouble(3, order.getTotalAmout());

            result = stmt.executeUpdate() > 0;
        }

        return result;
    }

    public int getOrderID(int userID, Date orderDate, double totalAmount) throws SQLException, ClassNotFoundException {
        int orderID = -1;
        String sql = "SELECT OrderID FROM Orders WHERE UserID = ? AND OrderDate = ? AND TotalAmount = ?";

        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.setDate(2, orderDate); // java.sql.Date
            stmt.setDouble(3, totalAmount);

            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    orderID = rs.getInt("OrderID");
                }
            }
        }

        return orderID;
    }

    public int addOrderAndReturnID(Orders order) throws Exception {
        int orderID = -1;
        String sql = "INSERT INTO Orders(userID, orderDate, totalAmount) VALUES (?, ?, ?)";

        try (
                 Connection conn = DatabaseConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserID());
            ps.setDate(2, order.getOrderDate());
            ps.setDouble(3, order.getTotalAmout());

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Thêm đơn hàng thất bại, không có dòng nào bị ảnh hưởng.");
            }

            try ( ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    orderID = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Không thể lấy orderID tự động tăng.");
                }
            }
        }

        return orderID;
    }

}
