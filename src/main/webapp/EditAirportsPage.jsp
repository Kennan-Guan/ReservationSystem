<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Airport</title>
	</head>
	<body>
		<h1>Edit Airport</h1>
		<!-- Need to create JSP file to implement edits and bring user to home page after clicking submit -->
		
		<form action = "editAirportActionHandling.jsp" method = "POST">
		
		Enter New Airport ID: <input type = "text" name = "newID" /><br/>
		<input type = "Submit" value = "Submit"><br/>
		<input type = "Button" name = "Home" value = "Home">	
		
		</form>
	</body>
</html>