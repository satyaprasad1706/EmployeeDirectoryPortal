<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Employee Directory Portal</title>
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
            <div class="sidebar-subtitle">Employee Portal</div>
        </div>
        
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employeeProfile" class="nav-link active">
                    <i class="fa-solid fa-user-tie"></i> My Profile
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/departments" class="nav-link">
                    <i class="fa-solid fa-sitemap"></i> Departments
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/attendance" class="nav-link">
                    <i class="fa-solid fa-calendar-check"></i> My Attendance
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
                <h1 class="page-title mb-1">My Personal Profile</h1>
                <p class="text-muted small mb-0">View your employment records and details.</p>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div class="position-relative">
                    <i class="fa-regular fa-bell fs-5 text-muted cursor-pointer"></i>
                </div>
                
                <div class="user-profile">
                    <div class="employee-avatar bg-primary text-white">
                        <c:set var="initial" value="${emp.empName.substring(0, 1)}"/>
                        ${initial}
                    </div>
                    <div>
                        <div class="user-name"><c:out value="${emp.empName}"/></div>
                        <div class="user-role">Employee</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Card Layout -->
        <div class="row g-4">
            <!-- Profile Overview Card -->
            <div class="col-12 col-lg-4">
                <div class="card border-0 shadow-sm text-center p-4" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <div class="d-flex justify-content-center mb-3">
                        <div class="employee-avatar bg-primary text-white fs-1" style="width: 100px; height: 100px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            ${initial}
                        </div>
                    </div>
                    <h3 class="fw-bold mb-1"><c:out value="${emp.empName}"/></h3>
                    <p class="text-primary fw-medium mb-3"><c:out value="${emp.department}"/></p>
                    
                    <c:choose>
                        <c:when test="${emp.status == 'Active'}">
                            <span class="status-badge status-active px-3 py-1.5 mb-2">Active Employee</span>
                        </c:when>
                        <c:when test="${emp.status == 'On Leave'}">
                            <span class="status-badge status-on-leave px-3 py-1.5 mb-2">On Leave</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-inactive px-3 py-1.5 mb-2">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="border-top mt-4 pt-3 text-start">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Employee ID:</span>
                            <span class="fw-bold text-dark"><c:out value="${emp.empId}"/></span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Status:</span>
                            <span class="fw-bold text-dark"><c:out value="${emp.status}"/></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Details Card -->
            <div class="col-12 col-lg-8">
                <div class="card border-0 shadow-sm p-4" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold mb-4 border-bottom pb-2 text-dark"><i class="fa-solid fa-address-card text-primary me-2"></i>Employment Details</h5>
                    
                    <div class="row g-4 mb-4">
                        <div class="col-12 col-md-6">
                            <label class="text-muted small d-block mb-1">Full Name</label>
                            <div class="p-3 bg-light rounded text-dark fw-medium"><c:out value="${emp.empName}"/></div>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="text-muted small d-block mb-1">Email Address</label>
                            <div class="p-3 bg-light rounded text-dark fw-medium"><c:out value="${emp.email}"/></div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-12 col-md-6">
                            <label class="text-muted small d-block mb-1">Phone Number</label>
                            <div class="p-3 bg-light rounded text-dark fw-medium">
                                <c:choose>
                                    <c:when test="${empty emp.phone}">N/A</c:when>
                                    <c:otherwise><c:out value="${emp.phone}"/></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="text-muted small d-block mb-1">Assigned Department</label>
                            <div class="p-3 bg-light rounded text-dark fw-medium"><c:out value="${emp.department}"/></div>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-12 col-md-6">
                            <label class="text-muted small d-block mb-1">Annual Salary</label>
                            <div class="p-3 bg-light rounded text-dark fw-bold">$<c:out value="${emp.salary}"/></div>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="text-muted small d-block mb-1">Access Credentials</label>
                            <div class="p-3 bg-light rounded text-muted small">
                                Username: <strong><c:out value="${emp.email}"/></strong>
                                <br>
                                To change your password, go to <a href="${pageContext.request.contextPath}/settings" class="text-primary text-decoration-none">Settings</a>.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
