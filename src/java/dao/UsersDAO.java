/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DatabaseConnection;
import model.Users;

/**
 *
 * @author vient
 */
import util.PasswordUtil;

public class UsersDAO {

    public boolean usernameExists(String username) throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean emailExists(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean createUser(Users user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO users (username, passwordhash, fullname, email, phone, address) VALUES (?, ?, ?, ?, ?, ?)";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, PasswordUtil.encodeString(user.getPassword()));
            stmt.setString(3, user.getFullname());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Users loginUser(String username, String password) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE Username = ? AND PasswordHash = ?";
        try ( Connection conn = DatabaseConnection.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, PasswordUtil.encodeString(password)); // mã hóa để so khớp với passwordhash
//            stmt.setString(2, password); 
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Users user = new Users();
                user.setUserID(rs.getInt("userID"));
                user.setUsername(rs.getString("username")); // không decode
                user.setPassword(rs.getString("passwordhash")); // tên đúng của cột
                user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname")); // đúng tên cột
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role")); // đã thêm role vào
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
