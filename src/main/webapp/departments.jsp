<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments Overview - Employee Directory Portal</title>
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
                <a href="${pageContext.request.contextPath}/departments" class="nav-link active">
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
                <h1 class="page-title mb-1">Departments Overview</h1>
                <p class="text-muted small mb-0">Manage and view organizational structures.</p>
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

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="text-muted small">Overview of active departments.</div>
            <c:if test="${userRole == 'admin'}">
                <button class="btn btn-primary-custom py-2" data-bs-toggle="modal" data-bs-target="#addDeptModal">
                    <i class="fa-solid fa-plus me-1"></i> Add Department
                </button>
            </c:if>
        </div>

        <!-- Grid of Departments -->
        <div class="row g-4 mb-5">
            <c:forEach var="dept" items="${departmentsStats}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card h-100 border-0 shadow-sm p-4 d-flex flex-column justify-content-between" style="border-radius: 12px; border: 1px solid var(--border-color) !important; min-height: 250px;">
                        <div>
                            <!-- Header with Icon & Dots -->
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="stat-icon ${dept.iconClass.contains('blue') ? 'icon-blue' : dept.iconClass.contains('brown') ? 'icon-brown' : dept.iconClass.contains('green') ? 'icon-green' : 'icon-grey'}" style="width: 42px; height: 42px;">
                                    <i class="${dept.iconClass.split(' ')[0]} ${dept.iconClass.split(' ')[1]}"></i>
                                </div>
                                <i class="fa-solid fa-ellipsis text-muted cursor-pointer"></i>
                            </div>

                            <!-- Title -->
                            <h5 class="fw-bold text-dark mb-2"><c:out value="${dept.name}"/></h5>
                            
                            <!-- Description -->
                            <p class="text-muted mb-4 small">
                                <c:choose>
                                    <c:when test="${dept.name == 'Engineering'}">Core product development and technical infrastructure maintenance.</c:when>
                                    <c:when test="${dept.name == 'Marketing'}">Brand management, digital campaigns, and market research.</c:when>
                                    <c:when test="${dept.name == 'Human Resources'}">Talent acquisition, employee relations, and organizational development.</c:when>
                                    <c:when test="${dept.name == 'Sales'}">Revenue generation, account management, and client acquisitions.</c:when>
                                    <c:when test="${dept.name == 'Finance'}">Financial planning, payroll, and corporate accounting.</c:when>
                                    <c:otherwise>Operational management and general support services.</c:otherwise>
                                </c:choose>
                            </p>
                        </div>

                        <!-- Footer Details -->
                        <div class="border-top pt-3 d-flex flex-column gap-2" style="font-size: 13px;">
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Head of Dept</span>
                                <span class="fw-semibold text-dark"><c:out value="${dept.headOfDept}"/></span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Headcount</span>
                                <span class="badge bg-secondary bg-opacity-10 text-dark fw-bold px-2 py-1"><c:out value="${dept.headcount}"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Create Department Placeholder Card (matches screenshot) -->
            <c:if test="${userRole == 'admin'}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card h-100 border-0 shadow-sm p-4 d-flex flex-column align-items-center justify-content-center border-dashed cursor-pointer" 
                         style="border-radius: 12px; border: 2px dashed var(--border-color) !important; background-color: transparent; min-height: 250px;"
                         data-bs-toggle="modal" data-bs-target="#addDeptModal">
                        <div class="btn btn-light rounded-circle p-3 mb-3 text-muted fs-4">
                            <i class="fa-solid fa-plus"></i>
                        </div>
                        <h6 class="fw-bold text-dark mb-1">Create Department</h6>
                        <p class="text-muted small text-center px-4 mb-0">Setup a new organizational unit.</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Add Department Mock Modal -->
    <div class="modal fade" id="addDeptModal" tabindex="-1" aria-labelledby="addDeptModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold" id="addDeptModalLabel">Create Department</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body py-3">
            <div class="mb-3">
                <label for="newDeptName" class="form-label form-label-custom">Department Name</label>
                <input type="text" class="form-control form-control-custom w-100" id="newDeptName" placeholder="e.g. Operations">
            </div>
            <div class="mb-3">
                <label for="newDeptHead" class="form-label form-label-custom">Head of Department</label>
                <input type="text" class="form-control form-control-custom w-100" id="newDeptHead" placeholder="e.g. John Miller">
            </div>
          </div>
          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
            <button type="button" class="btn btn-primary-custom" data-bs-dismiss="modal" onclick="alert('Department created successfully (Simulation)!')">Create Department</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
