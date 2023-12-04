<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Manage Airports</title>
	</head>
	<body>
		<h1>Select Action</h1>
		
		
		<form action = "ManAirportsActionHandling.jsp" method = "POST">
		Input airport ID: <input type = "text" name = "airportID"/><br/>
		<input type = "radio" id = "add" name = "Action" value = "Add">
		<label for = "add">Add </label>
		<input type = "radio" id = "del" name = "Action" value = "Delete">
		<label for = del>Delete </label>
		<input type = "radio" id = "edit" name = "Action" value = "Edit">
		<label for = "Edit">Edit </label><br/>
		
		<!-- Have functionality do the following: add the airport, delete the airport, or go to EditAirportPage.jsp -->
		<input type = "Submit" value = "book"><br/>
		<input type = "button" name ="Home" value = "Home">	
		
		</form>
	</body>
</html>