<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Employee Directory Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="login-container">
        <div class="login-card">
            <div class="text-center mb-4">
                <div class="sidebar-brand text-primary mb-2">
                    <i class="fa-solid fa-address-book"></i> HR Portal
                </div>
                <div class="text-muted small">Employee Directory Management System</div>
            </div>
            
            <h4 class="fw-bold text-center mb-4 text-dark">Sign In</h4>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-custom mb-3" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="mb-3">
                    <label for="username" class="form-label form-label-custom">Username</label>
                    <input type="text" class="form-control form-control-custom w-100" id="username" name="username" placeholder="Enter username" required autofocus>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label form-label-custom">Password</label>
                    <input type="password" class="form-control form-control-custom w-100" id="password" name="password" placeholder="Enter password" required>
                </div>
                <button type="submit" class="btn btn-primary-custom w-100 py-2.5">
                    <i class="fa-solid fa-right-to-bracket me-2"></i> Sign In
                </button>
            </form>
            
            <div class="text-center mt-4 text-muted" style="font-size: 12px;">
                &copy; 2026 Employee Directory Portal. All rights reserved.
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
