package com.employee.controller;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch metrics
        int totalEmployees = employeeDAO.getTotalEmployeesCount();
        int activeEmployees = employeeDAO.getActiveEmployeesCount();
        int departmentCount = employeeDAO.getDepartmentCount();
        List<Employee> recentEmployees = employeeDAO.getRecentEmployees(5);

        // Active Status percentage
        int activePercentage = 0;
        if (totalEmployees > 0) {
            activePercentage = (activeEmployees * 100) / totalEmployees;
        }

        // Set attributes
        request.setAttribute("totalEmployees", totalEmployees);
        request.setAttribute("activeEmployees", activeEmployees);
        request.setAttribute("departmentCount", departmentCount);
        request.setAttribute("recentEmployees", recentEmployees);
        request.setAttribute("activePercentage", activePercentage);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
