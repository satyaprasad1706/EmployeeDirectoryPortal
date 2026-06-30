<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Directory - Employee Directory Portal</title>
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
                <p class="text-muted small mb-0">Manage and view organizational structures.</p>
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

        <!-- Controls Row (Search, Filters, Add Employee) -->
        <div class="card border-0 shadow-sm mb-4" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/employees" method="GET" id="filterForm">
                    <div class="row g-3 align-items-center">
                        <!-- Department Filter -->
                        <div class="col-12 col-md-3 col-lg-2">
                            <select name="department" class="form-select form-control-custom py-2" onchange="document.getElementById('filterForm').submit();">
                                <option value="All" ${currentDepartment == 'All' ? 'selected' : ''}>All Departments</option>
                                <c:forEach var="dept" items="${departments}">
                                    <option value="${dept}" ${currentDepartment == dept ? 'selected' : ''}>${dept}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Status Filter -->
                        <div class="col-12 col-md-3 col-lg-2">
                            <select name="status" class="form-select form-control-custom py-2" onchange="document.getElementById('filterForm').submit();">
                                <option value="All" ${currentStatus == 'All' ? 'selected' : ''}>All Statuses</option>
                                <option value="Active" ${currentStatus == 'Active' ? 'selected' : ''}>Active</option>
                                <option value="On Leave" ${currentStatus == 'On Leave' ? 'selected' : ''}>On Leave</option>
                                <option value="Inactive" ${currentStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>

                        <!-- Search Bar -->
                        <div class="col-12 col-md-4 col-lg-4 ms-auto">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0 border-color"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                <input type="text" name="search" class="form-control form-control-custom border-start-0 py-2" placeholder="Search employees..." value="${currentSearch}">
                                <button type="submit" class="btn btn-secondary border-color" style="display:none;"></button>
                            </div>
                        </div>

                        <!-- Add Employee Button -->
                        <div class="col-12 col-md-2 col-lg-2 text-md-end">
                            <a href="${pageContext.request.contextPath}/addEmployee" class="btn btn-primary-custom py-2 px-3 w-100">
                                <i class="fa-solid fa-plus me-1"></i> Add Employee
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Directory Table -->
        <div class="custom-table-card">
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty employees}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-users-slash fs-2 mb-3 d-block text-muted"></i>
                                    No employees found matching the criteria.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="emp" items="${employees}">
                                <tr>
                                    <td>
                                        <div class="employee-info">
                                            <div class="employee-avatar">
                                                <!-- Extract initials for avatar -->
                                                <c:set var="names" value="${emp.empName}"/>
                                                <c:set var="initial" value="${names.substring(0, 1)}"/>
                                                ${initial}
                                            </div>
                                            <div>
                                                <div class="employee-name"><c:out value="${emp.empName}"/></div>
                                                <div class="employee-dept-sub">ID: <c:out value="${emp.empId}"/></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:out value="${emp.department}"/>
                                    </td>
                                    <td>
                                        <c:out value="${emp.email}"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${emp.status == 'Active'}">
                                                <span class="status-badge status-active">Active</span>
                                            </c:when>
                                            <c:when test="${emp.status == 'On Leave'}">
                                                <span class="status-badge status-on-leave">On Leave</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <div class="d-flex justify-content-end gap-2">
                                            <a href="${pageContext.request.contextPath}/updateEmployee?id=${emp.empId}" class="btn btn-sm btn-outline-secondary" title="Edit">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete('${emp.empId}', '${emp.empName}')" title="Delete">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
            <!-- Table Footer / Pagination -->
            <div class="d-flex justify-content-between align-items-center p-4 border-top bg-white">
                <div class="text-muted small">
                    Showing 1 to <c:out value="${employees.size()}"/> of <c:out value="${employees.size()}"/> entries
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-sm btn-outline-secondary" disabled><i class="fa-solid fa-chevron-left"></i></button>
                    <button class="btn btn-sm btn-outline-secondary" disabled><i class="fa-solid fa-chevron-right"></i></button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold" id="deleteModalLabel">Confirm Deletion</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body py-3">
            Are you sure you want to delete employee <strong id="deleteEmpName"></strong>? This action cannot be undone.
          </div>
          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-light" data-bs-contains="close" data-bs-dismiss="modal">Cancel</button>
            <form action="${pageContext.request.contextPath}/deleteEmployee" method="POST" id="deleteForm" style="display:inline;">
                <input type="hidden" name="id" id="deleteEmpId" value="">
                <button type="submit" class="btn btn-danger">Delete Employee</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id, name) {
            document.getElementById('deleteEmpName').innerText = name;
            document.getElementById('deleteEmpId').value = id;
            var myModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            myModal.show();
        }
    </script>
</body>
</html>
