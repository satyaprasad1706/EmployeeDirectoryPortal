package com.employee.controller;

import com.employee.dao.AdminDAO;
import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;
import com.employee.util.BCryptUtil;
import com.employee.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/settings")
public class SettingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = (String) session.getAttribute("role");

        if (newPassword == null || newPassword.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Passwords cannot be empty.");
            request.getRequestDispatcher("/settings.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/settings.jsp").forward(request, response);
            return;
        }

        String hashed = BCryptUtil.hashPassword(newPassword);
        boolean success = false;

        try (Connection conn = DBConnection.getConnection()) {
            if ("admin".equals(role)) {
                String username = (String) session.getAttribute("admin");
                String sql = "UPDATE admin SET password = ? WHERE username = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, hashed);
                    ps.setString(2, username);
                    success = ps.executeUpdate() > 0;
                }
            } else if ("employee".equals(role)) {
                Employee emp = (Employee) session.getAttribute("employee");
                String sql = "UPDATE employee SET password = ? WHERE emp_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, hashed);
                    ps.setInt(2, emp.getEmpId());
                    success = ps.executeUpdate() > 0;
                    if (success) {
                        emp.setPassword(hashed);
                        session.setAttribute("employee", emp); // update session object
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (success) {
            request.setAttribute("success", "Password updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update password. Try again.");
        }

        request.getRequestDispatcher("/settings.jsp").forward(request, response);
    }
}
