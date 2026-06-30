package com.employee.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        Properties props = new Properties();
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new RuntimeException("db.properties not found in classpath");
            }
            props.load(in);
            driver = props.getProperty("db.driver");
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            
            // Load driver
            Class.forName(driver);
            
            // Run automatic database migrations
            runMigrations();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Error initializing database configuration: " + e.getMessage(), e);
        }
    }

    private static void runMigrations() {
        String defaultEmpHash = "$2a$12$9d6y6gzCQH63XXOdY70NAuH9G8C9yMpHktM8M8J/1VoxPmqBP6/p."; // password123
        String defaultAdminHash = "$2a$12$.YIQ1edYfSxw7sOj.Vni4ez0oXfF8U72m59LEKKuJYxNhqY6tQBeG"; // admin123
        
        String alterQuery = "ALTER TABLE employee ADD COLUMN password VARCHAR(255) NOT NULL DEFAULT '" + defaultEmpHash + "'";
        String updateEmpQuery = "UPDATE employee SET password = ?";
        String updateAdminQuery = "UPDATE admin SET password = ? WHERE username = 'admin' AND password NOT LIKE '$2a$%'";

        try (Connection conn = getConnection()) {
            // 1. Alter employee table
            try (PreparedStatement ps = conn.prepareStatement(alterQuery)) {
                ps.executeUpdate();
                System.out.println("Database migration: Added password column to employee table.");
            } catch (SQLException e) {
                // Ignore error 1060 (Duplicate column name)
                if (e.getErrorCode() != 1060) {
                    System.out.println("Warning: Database migration alter query failed: " + e.getMessage());
                }
            }

            // 2. Set default hashed password for employees who have unhashed or old default passwords
            try (PreparedStatement ps = conn.prepareStatement(updateEmpQuery)) {
                ps.setString(1, defaultEmpHash);
                int count = ps.executeUpdate();
                if (count > 0) {
                    System.out.println("Database migration: Updated " + count + " employee passwords to default BCrypt hash.");
                }
            }

            // 3. Migrate admin password from plain text to BCrypt if necessary
            try (PreparedStatement ps = conn.prepareStatement(updateAdminQuery)) {
                ps.setString(1, defaultAdminHash);
                int count = ps.executeUpdate();
                if (count > 0) {
                    System.out.println("Database migration: Migrated admin password to BCrypt hash.");
                }
            }

        } catch (SQLException e) {
            System.out.println("Warning: Database migration process failed: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
