<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%if ((session.getAttribute("user") == null)) {%>
	You are not logged in, pls login brooooo
	<br />
	<a href="Login.jsp">Please Login</a>
	<%} else {%>Welcome
	<%=session.getAttribute("user")%>
	<a href="LogOut.jsp">Log out</a>
	<%}
%>
</body>
</html>