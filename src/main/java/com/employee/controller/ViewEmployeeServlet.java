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

@WebServlet("/employees")
public class ViewEmployeeServlet extends HttpServlet {
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

        String search = request.getParameter("search");
        String department = request.getParameter("department");
        String status = request.getParameter("status");

        List<Employee> list;

        // Determine list to fetch based on search & filters
        if (search != null && !search.trim().isEmpty()) {
            list = employeeDAO.searchEmployees(search.trim());
            // Clear department and status filters if search is active
            department = "All";
            status = "All";
        } else if ((department != null && !department.equalsIgnoreCase("All")) || 
                   (status != null && !status.equalsIgnoreCase("All"))) {
            list = employeeDAO.filterEmployees(department, status);
        } else {
            list = employeeDAO.getAllEmployees();
            department = "All";
            status = "All";
        }

        // Get unique departments for the dropdown list
        List<String> uniqueDepartments = employeeDAO.getUniqueDepartments();

        // Set request attributes
        request.setAttribute("employees", list);
        request.setAttribute("departments", uniqueDepartments);
        request.setAttribute("currentSearch", search != null ? search : "");
        request.setAttribute("currentDepartment", department != null ? department : "All");
        request.setAttribute("currentStatus", status != null ? status : "All");

        request.getRequestDispatcher("/employees.jsp").forward(request, response);
    }
}
