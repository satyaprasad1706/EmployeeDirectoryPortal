package com.employee.controller;

import com.employee.dao.AdminDAO;
import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");
            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else if ("employee".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/employeeProfile");
            }
        } else {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 1. Try Admin login
        boolean isAdminValid = adminDAO.validateAdmin(username, password);

        if (isAdminValid) {
            HttpSession session = request.getSession(true);
            session.setAttribute("admin", username);
            session.setAttribute("role", "admin");
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // 2. Try Employee login (username is the employee email)
        Employee emp = employeeDAO.validateEmployee(username, password);
        if (emp != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("admin", emp.getEmpName());
            session.setAttribute("role", "employee");
            session.setAttribute("employee", emp);
            response.sendRedirect(request.getContextPath() + "/employeeProfile");
            return;
        }

        // 3. Login failed
        request.setAttribute("error", "Invalid username or password.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
