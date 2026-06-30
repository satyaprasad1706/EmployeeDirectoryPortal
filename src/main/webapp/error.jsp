<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Employee Directory Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container d-flex flex-column align-items-center justify-content-center min-vh-100 text-center">
        <div class="card shadow-sm border-0 p-5" style="max-width: 500px; border-radius: 16px;">
            <div class="text-danger mb-4">
                <i class="fa-solid fa-triangle-exclamation" style="font-size: 64px;"></i>
            </div>
            <h2 class="fw-bold mb-3 text-dark">Something Went Wrong</h2>
            <p class="text-muted mb-4">
                We encountered an unexpected error. Please check your request or return to the dashboard.
            </p>
            
            <!-- Diagnostic Info for Debugging -->
            <div class="text-start bg-light p-3 border rounded mb-4 text-break" style="font-size: 13px; font-family: monospace; max-width: 400px; margin: 0 auto;">
                <div class="fw-bold mb-1 border-bottom pb-1">Error Diagnostics:</div>
                <div><strong>Status Code:</strong> ${pageContext.errorData.statusCode}</div>
                <div><strong>Request URI:</strong> ${pageContext.errorData.requestURI}</div>
                <c:if test="${not empty pageContext.errorData.throwable}">
                    <div class="mt-2 text-danger">
                        <strong>Exception:</strong> ${pageContext.errorData.throwable.message}
                    </div>
                </c:if>
            </div>
            <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary-custom py-2.5 px-4">
                    <i class="fa-solid fa-house me-2"></i> Go to Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline-secondary py-2.5 px-4">
                    <i class="fa-solid fa-users me-2"></i> Employee Directory
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
