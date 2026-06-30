<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee - Employee Directory Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <div>
            <div class="sidebar-brand">HR Portal</div>
            <div class="sidebar-subtitle">Enterprise Management</div>
        </div>
        
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                    <i class="fa-solid fa-chart-pie"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employees" class="nav-link active">
                    <i class="fa-solid fa-users"></i> Employees
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/departments" class="nav-link">
                    <i class="fa-solid fa-sitemap"></i> Departments
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/attendance" class="nav-link">
                    <i class="fa-solid fa-calendar-check"></i> Attendance
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/reports" class="nav-link">
                    <i class="fa-solid fa-chart-line"></i> Reports
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/settings" class="nav-link">
                    <i class="fa-solid fa-gear"></i> Settings
                </a>
            </li>
        </ul>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger">
                <i class="fa-solid fa-right-from-bracket text-danger"></i> Logout
            </a>
        </div>
    </div>

    <!-- Main Wrapper -->
    <div class="main-wrapper">
        <!-- Top Bar -->
        <div class="top-bar">
            <div>
                <h1 class="page-title mb-1">Employee Directory</h1>
                <p class="text-muted small mb-0">Update information for an existing employee record.</p>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div class="position-relative">
                    <i class="fa-regular fa-bell fs-5 text-muted cursor-pointer"></i>
                    <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                </div>
                
                <div class="user-profile">
                    <div class="employee-avatar bg-primary text-white">AD</div>
                    <div>
                        <div class="user-name">Administrator</div>
                        <div class="user-role">${sessionScope.admin}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Form Card -->
        <div class="form-card">
            <h2 class="form-title">Edit Employee</h2>
            <p class="form-subtitle">Modify the employee's details and save the changes.</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-custom mb-4" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/updateEmployee" method="POST">
                <!-- Hidden Field for Employee ID -->
                <input type="hidden" name="empId" value="${employee.empId}">

                <div class="row g-4 mb-4">
                    <!-- First Name -->
                    <div class="col-12 col-md-6">
                        <label for="firstName" class="form-label form-label-custom">First Name</label>
                        <input type="text" class="form-control form-control-custom w-100" id="firstName" name="firstName" value="${firstName}" required>
                    </div>
                    
                    <!-- Last Name -->
                    <div class="col-12 col-md-6">
                        <label for="lastName" class="form-label form-label-custom">Last Name</label>
                        <input type="text" class="form-control form-control-custom w-100" id="lastName" name="lastName" value="${lastName}" required>
                    </div>
                </div>

                <!-- Email Address -->
                <div class="mb-4">
                    <label for="email" class="form-label form-label-custom">Email Address</label>
                    <input type="email" class="form-control form-control-custom w-100" id="email" name="email" value="${employee.email}" required>
                </div>

                <div class="row g-4 mb-4">
                    <!-- Department -->
                    <div class="col-12 col-md-6">
                        <label for="department" class="form-label form-label-custom">Department</label>
                        <select class="form-select form-control-custom w-100" id="department" name="department" required>
                            <option value="Engineering" ${employee.department == 'Engineering' ? 'selected' : ''}>Engineering</option>
                            <option value="Product Design" ${employee.department == 'Product Design' ? 'selected' : ''}>Product Design</option>
                            <option value="Marketing" ${employee.department == 'Marketing' ? 'selected' : ''}>Marketing</option>
                            <option value="Human Resources" ${employee.department == 'Human Resources' ? 'selected' : ''}>Human Resources</option>
                            <option value="Sales" ${employee.department == 'Sales' ? 'selected' : ''}>Sales</option>
                            <option value="Finance" ${employee.department == 'Finance' ? 'selected' : ''}>Finance</option>
                        </select>
                    </div>
                    
                    <!-- Job Title (Not in DB, for UI match) -->
                    <div class="col-12 col-md-6">
                        <label for="jobTitle" class="form-label form-label-custom">Job Title</label>
                        <input type="text" class="form-control form-control-custom w-100" id="jobTitle" name="jobTitle" placeholder="e.g. Senior Product Designer">
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <!-- Date of Joining -->
                    <div class="col-12 col-md-6">
                        <label for="doj" class="form-label form-label-custom">Date of Joining</label>
                        <input type="date" class="form-control form-control-custom w-100" id="doj" name="doj">
                    </div>
                    
                    <!-- Employee Status -->
                    <div class="col-12 col-md-6">
                        <label for="status" class="form-label form-label-custom">Employee Status</label>
                        <select class="form-select form-control-custom w-100" id="status" name="status" required>
                            <option value="Active" ${employee.status == 'Active' ? 'selected' : ''}>Active</option>
                            <option value="On Leave" ${employee.status == 'On Leave' ? 'selected' : ''}>On Leave</option>
                            <option value="Inactive" ${employee.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="row g-4 mb-5">
                    <!-- Phone Number -->
                    <div class="col-12 col-md-6">
                        <label for="phone" class="form-label form-label-custom">Phone Number</label>
                        <input type="text" class="form-control form-control-custom w-100" id="phone" name="phone" value="${employee.phone}" placeholder="e.g. +1 555-0199">
                    </div>
                    
                    <!-- Salary -->
                    <div class="col-12 col-md-6">
                        <label for="salary" class="form-label form-label-custom">Salary</label>
                        <input type="number" step="0.01" class="form-control form-control-custom w-100" id="salary" name="salary" value="${employee.salary}" placeholder="e.g. 75000">
                    </div>
                </div>

                <!-- Form Footer Actions -->
                <div class="d-flex justify-content-end gap-3 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline-secondary px-4 py-2">Cancel</a>
                    <button type="submit" class="btn btn-primary-custom px-4 py-2">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
