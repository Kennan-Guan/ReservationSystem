<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Manage Aircraft</title>
	</head>
	<body>
		<h1>Select Action</h1>
		
		
		<form action = "ManAircraftActionHandling.jsp" method = "POST">
		Input airline ID: <input type = "text" name = "airlineID"/><br/>
		Input aircraft ID: <input type = "text" name = "aircraftID"/><br/>
		<input type = "radio" id = "add" name = "Action" value = "Add">
		<label for = "add">Add </label>
		<input type = "radio" id = "del" name = "Action" value = "Delete">
		<label for = del>Delete </label>
		<input type = "radio" id = "edit" name = "Action" value = "Edit">
		<label for = "Edit">Edit </label><br/>
		
		<!-- Have functionality do the following: add the aircraft, delete the aircraft, or go to EditAircraftPage.jsp -->
		<input type = "Submit" value = "book"><br/>
		<input type = "button" name ="Home" value = "Home">	
		
		</form>
	</body>
</html>