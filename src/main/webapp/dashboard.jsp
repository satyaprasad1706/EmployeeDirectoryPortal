<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Employee Directory Portal</title>
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
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">
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
                <h1 class="page-title mb-1">Dashboard Overview</h1>
                <p class="text-muted small mb-0">Key metrics and recent activity for your organization.</p>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <div class="position-relative">
                    <i class="fa-regular fa-bell fs-5 text-muted cursor-pointer"></i>
                    <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                </div>
                
                <div class="user-profile">
                    <!-- Default avatar using initials or a dummy image -->
                    <div class="employee-avatar bg-primary text-white">AD</div>
                    <div>
                        <div class="user-name">Administrator</div>
                        <div class="user-role">${sessionScope.admin}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Metrics Grid -->
        <div class="row g-4 mb-5">
            <!-- Total Employees -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">Total Employees</div>
                        <div class="stat-value"><c:out value="${totalEmployees}"/></div>
                        <div class="stat-desc text-success"><i class="fa-solid fa-arrow-trend-up"></i> +2.4% vs last month</div>
                    </div>
                    <div class="stat-icon icon-blue">
                        <i class="fa-solid fa-users"></i>
                    </div>
                </div>
            </div>
            
            <!-- Departments -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">Departments</div>
                        <div class="stat-value"><c:out value="${departmentCount}"/></div>
                        <div class="stat-desc">Across multiple locations</div>
                    </div>
                    <div class="stat-icon icon-brown">
                        <i class="fa-solid fa-sitemap"></i>
                    </div>
                </div>
            </div>
            
            <!-- New Hires -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">New Hires</div>
                        <div class="stat-value"><c:out value="${recentEmployees.size()}"/></div>
                        <div class="stat-desc">Recently registered</div>
                    </div>
                    <div class="stat-icon icon-grey">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                </div>
            </div>
            
            <!-- Active Status -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">Active Status</div>
                        <div class="stat-value"><c:out value="${activePercentage}"/>%</div>
                        <div class="stat-desc">
                            <div class="progress" style="height: 6px; width: 120px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: ${activePercentage}%" aria-valuenow="${activePercentage}" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    <div class="stat-icon icon-green">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Content Grid -->
        <div class="row g-4">
            <!-- Recent Activity -->
            <div class="col-12 col-lg-8">
                <div class="card border-0 shadow-sm" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <div class="card-header bg-white border-0 py-3 px-4 d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold mb-0">Recent Activity</h5>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-sm btn-link text-decoration-none">View All</a>
                    </div>
                    <div class="card-body p-4">
                        <c:choose>
                            <c:when test="${empty recentEmployees}">
                                <div class="text-center py-5">
                                    <i class="fa-solid fa-timeline text-muted fs-1 mb-3"></i>
                                    <p class="text-muted">No recent employee activities found.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="timeline">
                                    <c:forEach var="emp" items="${recentEmployees}">
                                        <div class="d-flex mb-4 gap-3 position-relative pb-2 align-items-start">
                                            <div class="btn btn-sm bg-primary bg-opacity-10 text-primary rounded-circle p-2 fs-6 flex-shrink-0" style="width: 38px; height: 38px; display: flex; align-items: center; justify-content: center;">
                                                <i class="fa-solid fa-user-plus"></i>
                                            </div>
                                            <div>
                                                <p class="mb-1 text-dark">
                                                    <strong><c:out value="${emp.empName}"/></strong> joined the 
                                                    <span class="text-primary fw-semibold"><c:out value="${emp.department}"/></span> department.
                                                </p>
                                                <div class="d-flex gap-3 small text-muted align-items-center">
                                                    <span>Email: <c:out value="${emp.email}"/></span>
                                                    <span>&bull;</span>
                                                    <span class="badge bg-success bg-opacity-10 text-success"><c:out value="${emp.status}"/></span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Sidebar Panel: Celebrations -->
            <div class="col-12 col-lg-4">
                <div class="card border-0 shadow-sm mb-4" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <div class="card-header bg-white border-0 py-3 px-4">
                        <h5 class="fw-bold mb-0"><i class="fa-solid fa-cake-candles text-danger me-2"></i>Upcoming Celebrations</h5>
                    </div>
                    <div class="card-body p-4">
                        <!-- Static Celebrations based on screenshot -->
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-3 border-bottom">
                            <div class="d-flex align-items-center gap-3">
                                <div class="employee-avatar bg-warning text-dark fw-bold">EB</div>
                                <div>
                                    <h6 class="mb-0 fw-bold">Emily Blunt</h6>
                                    <small class="text-muted">Birthday &bull; Oct 28</small>
                                </div>
                            </div>
                            <button class="btn btn-light btn-sm rounded-circle" style="width: 32px; height: 32px;"><i class="fa-solid fa-paper-plane text-muted fs-6"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-3 border-bottom">
                            <div class="d-flex align-items-center gap-3">
                                <div class="employee-avatar bg-info text-white fw-bold">JD</div>
                                <div>
                                    <h6 class="mb-0 fw-bold">John Doe</h6>
                                    <small class="text-muted">5 Year Work Anniversary</small>
                                </div>
                            </div>
                            <button class="btn btn-light btn-sm rounded-circle" style="width: 32px; height: 32px;"><i class="fa-solid fa-paper-plane text-muted fs-6"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-3">
                                <div class="employee-avatar bg-success text-white fw-bold">AS</div>
                                <div>
                                    <h6 class="mb-0 fw-bold">Alice Smith</h6>
                                    <small class="text-muted">Birthday &bull; Nov 2</small>
                                </div>
                            </div>
                            <button class="btn btn-light btn-sm rounded-circle" style="width: 32px; height: 32px;"><i class="fa-solid fa-paper-plane text-muted fs-6"></i></button>
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
