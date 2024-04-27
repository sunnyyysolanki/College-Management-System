package com.java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtils {
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/admindb";
        String user = "root";
        String password = "Yash@297";
        return DriverManager.getConnection(url, user, password);
    }
}
