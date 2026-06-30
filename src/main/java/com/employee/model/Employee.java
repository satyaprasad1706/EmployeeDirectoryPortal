package com.employee.model;

public class Employee {
    private int empId;
    private String empName;
    private String department;
    private String email;
    private String phone;
    private double salary;
    private String status; // Active, On Leave, Inactive
    private String password;

    // Constructors
    public Employee() {
    }

    public Employee(String empName, String department, String email, String phone, double salary, String status) {
        this.empName = empName;
        this.department = department;
        this.email = email;
        this.phone = phone;
        this.salary = salary;
        this.status = status;
        this.password = "$2a$12$9d6y6gzCQH63XXOdY70NAuH9G8C9yMpHktM8M8J/1VoxPmqBP6/p."; // default: password123
    }

    public Employee(String empName, String department, String email, String phone, double salary, String status, String password) {
        this.empName = empName;
        this.department = department;
        this.email = email;
        this.phone = phone;
        this.salary = salary;
        this.status = status;
        this.password = password;
    }

    public Employee(int empId, String empName, String department, String email, String phone, double salary, String status) {
        this.empId = empId;
        this.empName = empName;
        this.department = department;
        this.email = email;
        this.phone = phone;
        this.salary = salary;
        this.status = status;
        this.password = "$2a$12$9d6y6gzCQH63XXOdY70NAuH9G8C9yMpHktM8M8J/1VoxPmqBP6/p."; // default: password123
    }

    public Employee(int empId, String empName, String department, String email, String phone, double salary, String status, String password) {
        this.empId = empId;
        this.empName = empName;
        this.department = department;
        this.email = email;
        this.phone = phone;
        this.salary = salary;
        this.status = status;
        this.password = password;
    }

    // Getters and Setters
    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
