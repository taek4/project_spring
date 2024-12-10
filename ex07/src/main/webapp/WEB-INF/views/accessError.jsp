<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied</title>
</head>
<body>
    <h1>Access Denied Page</h1>

    <h2>
        <c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() != null ? SPRING_SECURITY_403_EXCEPTION.getMessage() : 'You do not have permission to access this page.'}"/>
    </h2>
    <h2>
        <c:out value="${msg != null ? msg : 'Please contact the administrator for more details.'}"/>
    </h2>
</body>
</html>
