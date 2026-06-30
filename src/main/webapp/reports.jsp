<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics - Employee Directory Portal</title>
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
                <a href="${pageContext.request.contextPath}/employees" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/reports" class="nav-link active">
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
                <h1 class="page-title mb-1">Reports & Analytics</h1>
                <p class="text-muted small mb-0">Visual analysis and organizational data trends.</p>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div class="position-relative">
                    <i class="fa-regular fa-bell fs-5 text-muted cursor-pointer"></i>
                </div>
                
                <div class="user-profile">
                    <div class="employee-avatar bg-primary text-white">AD</div>
                    <div>
                        <div class="user-name">Administrator</div>
                        <div class="user-role">${sessionScope.role == 'admin' ? 'Administrator' : 'Employee'}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Analytical Cards Grid -->
        <div class="row g-4">
            <!-- Salary Distribution -->
            <div class="col-12 col-lg-6">
                <div class="card border-0 shadow-sm p-4 h-100" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-money-bill-trend-up text-primary me-2"></i>Departmental Salary Budget Allocation</h5>
                    
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1 small">
                            <span class="text-muted">Engineering</span>
                            <span class="fw-bold text-dark">$450,000 (45%)</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-primary" role="progressbar" style="width: 45%" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1 small">
                            <span class="text-muted">Marketing</span>
                            <span class="fw-bold text-dark">$180,000 (18%)</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 18%" aria-valuenow="18" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1 small">
                            <span class="text-muted">Sales</span>
                            <span class="fw-bold text-dark">$220,000 (22%)</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 22%" aria-valuenow="22" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>

                    <div class="mb-0">
                        <div class="d-flex justify-content-between mb-1 small">
                            <span class="text-muted">Human Resources</span>
                            <span class="fw-bold text-dark">$150,000 (15%)</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-danger" role="progressbar" style="width: 15%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Active / Inactive Employee Ratios -->
            <div class="col-12 col-lg-6">
                <div class="card border-0 shadow-sm p-4 h-100" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-users-gear text-primary me-2"></i>Status Distribution Rates</h5>
                    
                    <div class="d-flex align-items-center gap-4 mb-4">
                        <div class="flex-shrink-0 bg-light rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-user-check text-success fs-3"></i>
                        </div>
                        <div class="flex-grow-1">
                            <div class="fw-bold mb-1">Active Staff Rate (92%)</div>
                            <p class="text-muted small mb-0">Employees currently working or ready to take up operations.</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-center gap-4 mb-4">
                        <div class="flex-shrink-0 bg-light rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-user-clock text-warning fs-3"></i>
                        </div>
                        <div class="flex-grow-1">
                            <div class="fw-bold mb-1">On-Leave Rate (5%)</div>
                            <p class="text-muted small mb-0">Employees currently on medical, sick, or annual holiday leaves.</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-center gap-4">
                        <div class="flex-shrink-0 bg-light rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-user-xmark text-danger fs-3"></i>
                        </div>
                        <div class="flex-grow-1">
                            <div class="fw-bold mb-1">Inactive Rate (3%)</div>
                            <p class="text-muted small mb-0">Resigned, terminated, or retired staff members.</p>
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
