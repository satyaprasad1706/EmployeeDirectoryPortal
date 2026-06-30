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

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {
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

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/employees");
            return;
        }

        try {
            int empId = Integer.parseInt(idStr.trim());
            Employee employee = employeeDAO.getEmployeeById(empId);
            if (employee == null) {
                response.sendRedirect(request.getContextPath() + "/employees");
                return;
            }

            // Split name into first and last name for editing
            String fullName = employee.getEmpName();
            String firstName = "";
            String lastName = "";
            if (fullName != null) {
                int spaceIndex = fullName.indexOf(' ');
                if (spaceIndex != -1) {
                    firstName = fullName.substring(0, spaceIndex);
                    lastName = fullName.substring(spaceIndex + 1);
                } else {
                    firstName = fullName;
                }
            }

            request.setAttribute("employee", employee);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.getRequestDispatcher("/updateEmployee.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/employees");
        }
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
        String idStr = request.getParameter("empId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String department = request.getParameter("department");
        String salaryStr = request.getParameter("salary");
        String status = request.getParameter("status");

        if (idStr == null || idStr.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "ID, First Name, Last Name, and Email are required.");
            // Reload the employee to display in the form again
            doGet(request, response);
            return;
        }

        try {
            int empId = Integer.parseInt(idStr.trim());
            double salary = 0.0;
            if (salaryStr != null && !salaryStr.trim().isEmpty()) {
                salary = Double.parseDouble(salaryStr.trim());
            }

            String empName = firstName.trim() + " " + lastName.trim();
            Employee employee = new Employee(empId, empName, department, email, phone, salary, status);

            boolean success = employeeDAO.updateEmployee(employee);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/employees");
            } else {
                request.setAttribute("error", "Failed to update employee.");
                request.setAttribute("employee", employee);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.getRequestDispatcher("/updateEmployee.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid formats for ID or salary.");
            doGet(request, response);
        }
    }
}
