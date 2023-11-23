<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Customer Homepage</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to lead customer to next page based off of button clicked -->
		<!--  Note: when the ticket is made for a succesful reservation, the ticket info is stored in a request object called ticketDetails -->
		<!--  Note: when the ticket is made, we also store the ticket number in a request object called ticketNum -->
		<!--  Upon succesful booking, go to TicketDetailsPage to show ticket details -->
		<!--  Note: when there is no ticket available matching the criteria, the customer is brought to the joinwaitlist page -->
		<form action = "ReservationSelectionHandling.jsp" method = "POST">
		Airline ID:<input type = "text" name = "airlineID" /><br/>
		Flight No. <input type = "text" name = "flightNum" /><br/>
		Class (Note, there is a $100 premium for business class and a $200 premium for first class) <input type = "text" name = "flightClass"><br/>
		<input type = "Submit" value = "book">		
		
		</form>
	</body>
</html>