package com.employee;

import com.employee.dao.AdminDAO;
import com.employee.model.Admin;
import com.employee.util.DBConnection;
import org.junit.BeforeClass;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.Assert.*;
import static org.junit.Assume.assumeTrue;

public class AdminDAOTest {

    private static AdminDAO adminDAO;
    private static boolean dbAvailable = false;

    @BeforeClass
    public static void setUp() {
        adminDAO = new AdminDAO();
        // Check if database is reachable before running tests (so that they don't break Jenkins if MySQL is down)
        try (Connection conn = DBConnection.getConnection()) {
            dbAvailable = conn != null;
        } catch (SQLException e) {
            System.out.println("Warning: Database not available for AdminDAOTest. Skipping tests.");
        }
    }

    @Test
    public void testValidateAdmin_Success() {
        assumeTrue("Database is not available, skipping test.", dbAvailable);
        
        // Seeding database with a temp test user if not exists
        Admin testAdmin = new Admin("testadmin_junit", "pass123");
        adminDAO.addAdmin(testAdmin);

        boolean isValid = adminDAO.validateAdmin("testadmin_junit", "pass123");
        assertTrue("Admin login validation should be successful", isValid);
    }

    @Test
    public void testValidateAdmin_Failure() {
        assumeTrue("Database is not available, skipping test.", dbAvailable);
        
        boolean isValid = adminDAO.validateAdmin("non_existent_admin", "invalid_password");
        assertFalse("Admin validation should fail for non-existent admin", isValid);
    }
}
