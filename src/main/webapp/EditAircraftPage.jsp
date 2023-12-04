<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Aircraft</title>
	</head>
	<body>
		<h1>Edit Aircraft</h1>
		<!-- Need to create JSP file to implement edits and bring user to home page after clicking submit -->
		
		<form action = "editAircraftActionHandling.jsp" method = "POST">
		Enter New Number of Seats: <input type = "text" name = "numSeats" /><br/>
		Enter New Flight Days: <input type = "text" name = "flightDays" /><br/>
		Enter New Domestic/International : <input type = "text" name = "domOrInt" /><br/>
		Enter New Airline ID: <input type = "text" name = "newAirline" /><br/>
		<input type = "Submit" value = "Submit"><br/>
		<input type = "Button" name = "Home" value = "Home">	
		
		</form>
	</body>
</html>