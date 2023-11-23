<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cancellation Failure Page</title>
	</head>
	<body>
		<h1>Flight Could not be Canceled! Either you are not the ticketholder or the ticket is economy class</h1>
		<!-- Need to create JSP file to bring back to landing page -->
		<form action = "GoHome.jsp" method = "POST">
		<input type = "Submit" value = "Return Home">
		</form>
	</body>
</html>