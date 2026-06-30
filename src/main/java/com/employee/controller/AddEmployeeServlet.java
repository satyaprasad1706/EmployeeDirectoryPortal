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

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {
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

        request.getRequestDispatcher("/addEmployee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String department = request.getParameter("department");
        String salaryStr = request.getParameter("salary");
        String status = request.getParameter("status");

        // Simple validation
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "First Name, Last Name, and Email are required.");
            request.getRequestDispatcher("/addEmployee.jsp").forward(request, response);
            return;
        }

        double salary = 0.0;
        try {
            if (salaryStr != null && !salaryStr.trim().isEmpty()) {
                salary = Double.parseDouble(salaryStr.trim());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid salary format.");
            request.getRequestDispatcher("/addEmployee.jsp").forward(request, response);
            return;
        }

        String empName = firstName.trim() + " " + lastName.trim();
        Employee employee = new Employee(empName, department, email, phone, salary, status);

        boolean success = employeeDAO.addEmployee(employee);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/employees");
        } else {
            request.setAttribute("error", "Failed to add employee. Email might already exist.");
            request.getRequestDispatcher("/addEmployee.jsp").forward(request, response);
        }
    }
}
