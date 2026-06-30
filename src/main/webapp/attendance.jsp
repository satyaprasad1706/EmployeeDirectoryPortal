<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance - Employee Directory Portal</title>
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
                <a href="${pageContext.request.contextPath}/attendance" class="nav-link active">
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
                <h1 class="page-title mb-1">
                    <c:choose>
                        <c:when test="${userRole == 'admin'}">Attendance Tracking</c:when>
                        <c:otherwise>My Attendance</c:otherwise>
                    </c:choose>
                </h1>
                <p class="text-muted small mb-0">Record and track daily attendance timesheets.</p>
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

        <!-- Attendance Stats Cards -->
        <div class="row g-4 mb-4">
            <div class="col-12 col-md-4">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">Present Days</div>
                        <div class="stat-value">18</div>
                        <div class="stat-desc">This month</div>
                    </div>
                    <div class="stat-icon icon-green">
                        <i class="fa-solid fa-calendar-day"></i>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">Late Days</div>
                        <div class="stat-value">2</div>
                        <div class="stat-desc text-danger"><i class="fa-solid fa-triangle-exclamation"></i> 10% Late rate</div>
                    </div>
                    <div class="stat-icon icon-brown">
                        <i class="fa-solid fa-clock-rotate-left"></i>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="stat-card">
                    <div>
                        <div class="stat-title">Avg Work Hours</div>
                        <div class="stat-value">8.2 hrs</div>
                        <div class="stat-desc">Per active day</div>
                    </div>
                    <div class="stat-icon icon-blue">
                        <i class="fa-solid fa-hourglass-half"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Clock In/Out Simulation -->
        <div class="row g-4">
            <div class="col-12 col-lg-5">
                <div class="card border-0 shadow-sm p-4 text-center h-100" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-clock text-primary me-2"></i>Punch Time</h5>
                    <div class="display-5 fw-bold text-dark mb-2" id="liveClock">00:00:00</div>
                    <div class="text-muted small mb-4" id="liveDate">Date loading...</div>
                    
                    <div class="d-flex flex-column gap-2 max-width-300 mx-auto w-75">
                        <button class="btn btn-primary-custom py-3 fw-bold" onclick="clockAction('In')">
                            <i class="fa-solid fa-right-to-bracket me-2"></i>Clock In
                        </button>
                        <button class="btn btn-outline-danger py-3 fw-bold" onclick="clockAction('Out')">
                            <i class="fa-solid fa-right-from-bracket me-2"></i>Clock Out
                        </button>
                    </div>
                    
                    <div class="alert alert-info mt-4 mb-0 py-2.5 small" role="alert">
                        <strong>Current Status:</strong> <span id="clockStatus">Not Clocked In</span>
                    </div>
                </div>
            </div>

            <!-- Attendance History Logs -->
            <div class="col-12 col-lg-7">
                <div class="card border-0 shadow-sm p-4 h-100" style="border-radius: 12px; border: 1px solid var(--border-color) !important;">
                    <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-history text-primary me-2"></i>Recent Log History</h5>
                    <div class="table-responsive">
                        <table class="table align-middle table-hover small">
                            <thead class="table-light">
                                <tr>
                                    <th>Date</th>
                                    <th>Clock In</th>
                                    <th>Clock Out</th>
                                    <th>Total Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Jun 30, 2026</td>
                                    <td>09:02 AM</td>
                                    <td>06:05 PM</td>
                                    <td>9.0 hrs</td>
                                    <td><span class="status-badge status-active">On Time</span></td>
                                </tr>
                                <tr>
                                    <td>Jun 29, 2026</td>
                                    <td>09:15 AM</td>
                                    <td>06:00 PM</td>
                                    <td>8.7 hrs</td>
                                    <td><span class="status-badge status-on-leave text-dark bg-warning bg-opacity-25">Late In</span></td>
                                </tr>
                                <tr>
                                    <td>Jun 26, 2026</td>
                                    <td>08:58 AM</td>
                                    <td>06:01 PM</td>
                                    <td>9.0 hrs</td>
                                    <td><span class="status-badge status-active">On Time</span></td>
                                </tr>
                                <tr>
                                    <td>Jun 25, 2026</td>
                                    <td>09:00 AM</td>
                                    <td>06:00 PM</td>
                                    <td>9.0 hrs</td>
                                    <td><span class="status-badge status-active">On Time</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Update live clock
        function updateClock() {
            const now = new Date();
            const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false });
            document.getElementById('liveClock').innerText = timeStr;
            
            const dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            document.getElementById('liveDate').innerText = now.toLocaleDateString('en-US', dateOptions);
        }
        setInterval(updateClock, 1000);
        updateClock();

        // Clock In/Out action Simulation
        function clockAction(action) {
            const time = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            if (action === 'In') {
                document.getElementById('clockStatus').innerHTML = `Clocked In at <strong>${time}</strong>`;
                alert('Clocked In successfully!');
            } else {
                document.getElementById('clockStatus').innerHTML = 'Not Clocked In';
                alert('Clocked Out successfully!');
            }
        }
    </script>
</body>
</html>
