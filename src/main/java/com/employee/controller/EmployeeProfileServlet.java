package com.employee.controller;

import com.employee.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/employeeProfile")
public class EmployeeProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"employee".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        Employee emp = (Employee) session.getAttribute("employee");
        request.setAttribute("emp", emp);
        request.getRequestDispatcher("/employeeProfile.jsp").forward(request, response);
    }
}
