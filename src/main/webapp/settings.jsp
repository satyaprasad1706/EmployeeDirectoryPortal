<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - Employee Directory Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

    <c:set var="userRole" value="${sessionScope.role}"/>

    <!-- Sidebar -->
    <div class="sidebar">
        <div>
            <div class="sidebar-brand">HR Portal</div>
            <c:choose>
                <c:when test="${userRole == 'admin'}">
                    <div class="sidebar-subtitle">Enterprise Management</div>
                </c:when>
                <c:otherwise>
                    <div class="sidebar-subtitle">Employee Portal</div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <ul class="nav-menu">
            <c:choose>
                <c:when test="${userRole == 'admin'}">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                            <i class="fa-solid fa-chart-pie"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/employees" class="nav-link">
                            <i class="fa-solid fa-users"></i> Employees
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/employeeProfile" class="nav-link">
                            <i class="fa-solid fa-user-tie"></i> My Profile
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/departments" class="nav-link">
                    <i class="fa-solid fa-sitemap"></i> Departments
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/attendance" class="nav-link">
                    <c:choose>
                        <c:when test="${userRole == 'admin'}">
                            <i class="fa-solid fa-calendar-check"></i> Attendance
                        </c:when>
                        <c:otherwise>
                            <i class="fa-solid fa-calendar-check"></i> My Attendance
                        </c:otherwise>
                    </c:choose>
                </a>
            </li>
            <c:if test="${userRole == 'admin'}">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/reports" class="nav-link">
                        <i class="fa-solid fa-chart-line"></i> Reports
                    </a>
                </li>
            </c:if>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/settings" class="nav-link active">
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
                <h1 class="page-title mb-1">Account Settings</h1>
                <p class="text-muted small mb-0">Modify security settings and account details.</p>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div class="position-relative">
                    <i class="fa-regular fa-bell fs-5 text-muted cursor-pointer"></i>
                </div>
                
                <div class="user-profile">
                    <div class="employee-avatar bg-primary text-white">
                        <c:set var="initial" value="${sessionScope.admin.substring(0, 1)}"/>
                        ${initial}
                    </div>
                    <div>
                        <div class="user-name">${sessionScope.admin}</div>
                        <div class="user-role">${userRole == 'admin' ? 'Administrator' : 'Employee'}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Password Modification Card -->
            <div class="col-12 col-md-6">
                <div class="card border-0 shadow-sm p-4" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-key text-primary me-2"></i>Change Password</h5>
                    <p class="text-muted small mb-4">Ensure your account is using a secure password to prevent unauthorized access.</p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-custom mb-3 py-2.5 small" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-custom mb-3 py-2.5 small" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> ${success}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/settings" method="POST">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label form-label-custom">New Password</label>
                            <input type="password" class="form-control form-control-custom w-100" id="newPassword" name="newPassword" placeholder="Enter new password" required>
                        </div>
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label form-label-custom">Confirm Password</label>
                            <input type="password" class="form-control form-control-custom w-100" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary-custom w-100 py-2.5 fw-bold">
                            <i class="fa-solid fa-save me-2"></i>Save Changes
                        </button>
                    </form>
                </div>
            </div>

            <!-- Profile Info Metadata -->
            <div class="col-12 col-md-6">
                <div class="card border-0 shadow-sm p-4 h-100" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-shield-halved text-primary me-2"></i>Security Policy</h5>
                    <ul class="text-muted small px-3 mb-4" style="line-height: 1.8;">
                        <li>Passwords must be at least 8 characters long.</li>
                        <li>Avoid reuse of passwords from other internal software systems.</li>
                        <li>Session timeouts automatically invalidate active sessions after 30 minutes of inactivity.</li>
                        <li>Database credentials are encrypted using industry-standard **Blowfish/BCrypt** algorithms.</li>
                    </ul>
                    
                    <div class="alert alert-secondary mb-0 p-3 bg-light rounded" style="font-size: 13px;">
                        <strong>Authentication Level:</strong> 
                        <br>
                        Authenticated as <span class="badge bg-primary bg-opacity-10 text-primary uppercase">${userRole}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
