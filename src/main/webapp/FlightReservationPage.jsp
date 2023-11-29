<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Flight Reservation Page</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to lead user to next page based off of button clicked -->
		<!--  Note: when the ticket is made for a succesful reservation, the ticket info is stored in a request object called ticketDetails -->
		<!--  Note: when the ticket is made, we also store the ticket number in a request object called ticketNum -->
		<!--  Upon succesful booking, go to TicketDetailsPage to show ticket details -->
		<!--  Note: when there is no ticket available matching the criteria, the user is brought to the joinwaitlist page -->
		<form action = "ReservationSelectionHandling.jsp" method = "POST">
		Airline IDs (please separate entries by a semicolon): <input type = "text" name = "airlineIDs" /><br/>
		Flight Number (please separate entries by a semicolon): <input type = "text" name = "flightNums" /><br/>
		Class (Note, there is a $100 premium for business class and a $200 premium for first class) <input type = "text" name = "flightClass"><br/>
		<input type = "Submit" value = "book">		
		
		</form>
	</body>
</html>