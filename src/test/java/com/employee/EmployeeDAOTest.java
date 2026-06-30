package com.employee;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;
import com.employee.util.DBConnection;
import org.junit.BeforeClass;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assume.assumeTrue;

public class EmployeeDAOTest {

    private static EmployeeDAO employeeDAO;
    private static boolean dbAvailable = false;

    @BeforeClass
    public static void setUp() {
        employeeDAO = new EmployeeDAO();
        try (Connection conn = DBConnection.getConnection()) {
            dbAvailable = conn != null;
        } catch (SQLException e) {
            System.out.println("Warning: Database not available for EmployeeDAOTest. Skipping tests.");
        }
    }

    @Test
    public void testEmployeeCRUD() {
        assumeTrue("Database is not available, skipping test.", dbAvailable);

        // 1. Create (Add)
        Employee emp = new Employee("Junit Tester", "Engineering", "junit.test@company.com", "123-456", 50000.0, "Active");
        boolean isAdded = employeeDAO.addEmployee(emp);
        assertTrue("Employee should be added successfully", isAdded);
        assertTrue("Employee ID should be generated", emp.getEmpId() > 0);

        // 2. Read (Get by ID)
        Employee retrieved = employeeDAO.getEmployeeById(emp.getEmpId());
        assertNotNull("Retrieved employee should not be null", retrieved);
        assertEquals("Name should match", "Junit Tester", retrieved.getEmpName());

        // 3. Update
        retrieved.setEmpName("Junit Tester Updated");
        retrieved.setStatus("On Leave");
        boolean isUpdated = employeeDAO.updateEmployee(retrieved);
        assertTrue("Employee should be updated successfully", isUpdated);

        Employee updated = employeeDAO.getEmployeeById(emp.getEmpId());
        assertEquals("Name should be updated", "Junit Tester Updated", updated.getEmpName());
        assertEquals("Status should be updated", "On Leave", updated.getStatus());

        // 4. Search
        List<String> depts = employeeDAO.getUniqueDepartments();
        assertNotNull("Departments list should not be null", depts);

        List<Employee> searchResults = employeeDAO.searchEmployees("Junit Tester");
        assertTrue("Search should return at least 1 result", searchResults.size() > 0);

        // 5. Delete
        boolean isDeleted = employeeDAO.deleteEmployee(emp.getEmpId());
        assertTrue("Employee should be deleted successfully", isDeleted);

        Employee deleted = employeeDAO.getEmployeeById(emp.getEmpId());
        assertNull("Deleted employee should not be found", deleted);
    }
}
