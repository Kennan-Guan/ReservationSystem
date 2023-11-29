<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Reservation</title>
	</head>
	<body>
		<h1>Edit Reservation</h1>
		<!-- Need to create JSP file to implement edits -->
		
		<form action = "editResActionHandling.jsp" method = "POST">
		Enter Ticket Number: <input type = "text" name = "ticketNum" /><br/>
		Enter New Airline IDs (please separate entries by a semicolon): <input type = "text" name = "airlineIDs" /><br/>
		Enter New Flight Numbers (please separate entries by a semicolon): <input type = "text" name = "flightNums" /><br/>
		New Class Class <input type = "text" name = "flightClass"><br/>
		<input type = "Button" name = "Home" value = "Home"> <br/>
		<input type = "Submit" value = "Submit">	
		
		</form>
	</body>
</html>