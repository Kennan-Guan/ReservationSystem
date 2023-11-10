<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
	<title>Logout</title>
	</head>
	<body>
<%

session.invalidate();
response.sendRedirect("Login.jsp");
 
%>
	</body>
</html>