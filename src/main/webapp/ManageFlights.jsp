<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Manage Flights</title>
	</head>
	<body>
		<h1>Select Action</h1>
		
		
		<form action = "ManFlightsActionHandling.jsp" method = "POST">
		Input airline ID: <input type = "text" name = "airlineID"/><br/>
		Input Flight Num: <input type = "text" name = "flightNum"/><br/>
		Input aircraft ID: <input type = "text" name = "aircraftID"/><br/>
		Domestic or International <input type = "radio" id = "dom" name = "type" value = "Domestic">
		<label for = "dom">Domestic </label>
		<input type = "radio" id = "int" name = "type" value = "International">
		<label for = int>International </label><br/>
		Departure Airport ID: <input type = "text" name = "deptID"/><br/>
		Arrival Airport ID: <input type = "text" name = "arrID"/><br/>
		Departure Time: <input type = "text" name = "deptTime"/><br/>
		Arrival Time: <input type = "text" name = "arrTime"/><br/>
		<input type = "radio" id = "add" name = "Action" value = "Add">
		<label for = "add">Add </label>
		<input type = "radio" id = "del" name = "Action" value = "Delete">
		<label for = del>Delete </label>
		<input type = "radio" id = "edit" name = "Action" value = "Edit">
		<label for = "Edit">Edit </label><br/>
		<!-- Have functionality do the following: add the flight, delete the flight, or edit the flight with the inputted details -->
		<!-- Note: if deleting flight, the CS Rep only needs to enter the airline ID and Flight Num. If editing it, they only need to
		enter the airline ID, Flight Num, and values for the attributes they are changing- all others can be left blank -->
		<input type = "Submit" value = "book"><br/>
		<input type = "button" name ="Home" value = "Home">	
		
		</form>
	</body>
</html>