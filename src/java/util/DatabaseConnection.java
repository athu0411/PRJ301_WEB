package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/ClothingStore";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "12345";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=ClothingStore";
        conn = DriverManager.getConnection(url, USERNAME, PASSWORD);
        return conn;
    }
}
