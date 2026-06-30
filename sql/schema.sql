-- Create Database
CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

-- Admin Table
CREATE TABLE IF NOT EXISTS admin (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

-- Employee Table
CREATE TABLE IF NOT EXISTS employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    salary DOUBLE,
    status VARCHAR(20) DEFAULT 'Active',
    password VARCHAR(255) NOT NULL DEFAULT '$2a$12$K.lC03/vKk4H6XqX4w1nU.mCtf.dGjRkYvUjD8w9BfN9D3pG1i.1q'
);

-- Seed admin user with default username 'admin' and password 'admin123' (BCrypt hashed)
INSERT INTO admin (username, password) 
VALUES ('admin', '$2a$12$.YIQ1edYfSxw7sOj.Vni4ez0oXfF8U72m59LEKKuJYxNhqY6tQBeG')
ON DUPLICATE KEY UPDATE password=VALUES(password);
