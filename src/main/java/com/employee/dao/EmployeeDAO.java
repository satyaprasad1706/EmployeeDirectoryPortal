package com.employee.dao;

import com.employee.model.Employee;
import com.employee.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    // Add new employee
    public boolean addEmployee(Employee employee) {
        String query = "INSERT INTO employee (emp_name, department, email, phone, salary, status, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, employee.getEmpName());
            ps.setString(2, employee.getDepartment());
            ps.setString(3, employee.getEmail());
            ps.setString(4, employee.getPhone());
            ps.setDouble(5, employee.getSalary());
            ps.setString(6, employee.getStatus());
            // Store hashed password (check if already hashed to prevent double-hashing)
            ps.setString(7, employee.getPassword().startsWith("$2a$") ? employee.getPassword() : com.employee.util.BCryptUtil.hashPassword(employee.getPassword()));
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        employee.setEmpId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all employees
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT * FROM employee ORDER BY emp_id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get employee by ID
    public Employee getEmployeeById(int empId) {
        String query = "SELECT * FROM employee WHERE emp_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractEmployee(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update employee
    public boolean updateEmployee(Employee employee) {
        String query = "UPDATE employee SET emp_name = ?, department = ?, email = ?, phone = ?, salary = ?, status = ?, password = ? WHERE emp_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, employee.getEmpName());
            ps.setString(2, employee.getDepartment());
            ps.setString(3, employee.getEmail());
            ps.setString(4, employee.getPhone());
            ps.setDouble(5, employee.getSalary());
            ps.setString(6, employee.getStatus());
            ps.setString(7, employee.getPassword().startsWith("$2a$") ? employee.getPassword() : com.employee.util.BCryptUtil.hashPassword(employee.getPassword()));
            ps.setInt(8, employee.getEmpId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete employee
    public boolean deleteEmployee(int empId) {
        String query = "DELETE FROM employee WHERE emp_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, empId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Search employees by ID, Name, Department, or status
    public List<Employee> searchEmployees(String keyword) {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT * FROM employee WHERE CAST(emp_id AS CHAR) LIKE ? OR emp_name LIKE ? OR department LIKE ? OR email LIKE ? ORDER BY emp_id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractEmployee(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Filter employees by department and/or status
    public List<Employee> filterEmployees(String department, String status) {
        List<Employee> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM employee WHERE 1=1");
        
        boolean hasDept = department != null && !department.isEmpty() && !department.equalsIgnoreCase("All");
        boolean hasStatus = status != null && !status.isEmpty() && !status.equalsIgnoreCase("All");
        
        if (hasDept) {
            query.append(" AND department = ?");
        }
        if (hasStatus) {
            query.append(" AND status = ?");
        }
        query.append(" ORDER BY emp_id ASC");
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {
            
            int index = 1;
            if (hasDept) {
                ps.setString(index++, department);
            }
            if (hasStatus) {
                ps.setString(index++, status);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractEmployee(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get total count of employees
    public int getTotalEmployeesCount() {
        String query = "SELECT COUNT(*) FROM employee";
        return getCount(query);
    }

    // Get active count of employees
    public int getActiveEmployeesCount() {
        String query = "SELECT COUNT(*) FROM employee WHERE status = 'Active'";
        return getCount(query);
    }

    // Get distinct department count
    public int getDepartmentCount() {
        String query = "SELECT COUNT(DISTINCT department) FROM employee WHERE department IS NOT NULL AND department <> ''";
        return getCount(query);
    }

    // Get list of unique departments
    public List<String> getUniqueDepartments() {
        List<String> list = new ArrayList<>();
        String query = "SELECT DISTINCT department FROM employee WHERE department IS NOT NULL AND department <> '' ORDER BY department ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("department"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    // Get recent employee additions
    public List<Employee> getRecentEmployees(int limit) {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT * FROM employee ORDER BY emp_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractEmployee(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper method to extract employee from ResultSet
    private Employee extractEmployee(ResultSet rs) throws SQLException {
        Employee employee = new Employee();
        employee.setEmpId(rs.getInt("emp_id"));
        employee.setEmpName(rs.getString("emp_name"));
        employee.setDepartment(rs.getString("department"));
        employee.setEmail(rs.getString("email"));
        employee.setPhone(rs.getString("phone"));
        employee.setSalary(rs.getDouble("salary"));
        employee.setStatus(rs.getString("status"));
        employee.setPassword(rs.getString("password"));
        return employee;
    }

    // Helper method to get count from simple query
    private int getCount(String query) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Validate employee credentials
    public Employee validateEmployee(String email, String password) {
        String query = "SELECT * FROM employee WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Employee emp = extractEmployee(rs);
                    if (com.employee.util.BCryptUtil.checkPassword(password, emp.getPassword())) {
                        return emp;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get stats for all departments dynamically
    public List<com.employee.model.Department> getDepartmentStats() {
        List<com.employee.model.Department> list = new ArrayList<>();
        
        // Define default departments from the screenshot
        String[] deptNames = {"Engineering", "Marketing", "Human Resources", "Sales", "Finance"};
        String[] deptHeads = {"Sarah Jenkins", "David Chen", "Amanda Foster", "Michael Torres", "Elena Rostova"};
        String[] deptIcons = {
            "fa-solid fa-code icon-blue",
            "fa-solid fa-bullhorn icon-brown",
            "fa-solid fa-users icon-grey",
            "fa-solid fa-chart-line icon-blue",
            "fa-solid fa-building-columns icon-green"
        };
        
        for (int i = 0; i < deptNames.length; i++) {
            String deptName = deptNames[i];
            int count = 0;
            String query = "SELECT COUNT(*) FROM employee WHERE department = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, deptName);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            list.add(new com.employee.model.Department(deptName, deptHeads[i], count, deptIcons[i]));
        }
        
        // Also look for any other dynamically added departments not in the default list
        String query = "SELECT DISTINCT department FROM employee WHERE department NOT IN ('Engineering', 'Marketing', 'Human Resources', 'Sales', 'Finance') AND department IS NOT NULL AND department <> ''";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String deptName = rs.getString("department");
                int count = 0;
                String countQuery = "SELECT COUNT(*) FROM employee WHERE department = ?";
                try (PreparedStatement ps2 = conn.prepareStatement(countQuery)) {
                    ps2.setString(1, deptName);
                    try (ResultSet rs2 = ps2.executeQuery()) {
                        if (rs2.next()) {
                            count = rs2.getInt(1);
                        }
                    }
                }
                list.add(new com.employee.model.Department(deptName, "Vacant", count, "fa-solid fa-sitemap icon-grey"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
}
