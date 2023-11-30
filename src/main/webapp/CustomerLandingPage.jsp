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
		<form action = "CustomerSelectionHandling.jsp" method = "POST">
		<!-- Take the user to BrowseFlights.jsp -->
		<input type = "Button" name = "BrowseFlights" value = "Browse Flights"><br/>
		<!-- Take the user to FlightReservationPage.jsp -->
		<input type = "Button" name = "ReserveFlights" value = "Reserve Flights"><br/>
		<!-- Send user to CancelFlgihtsPage.jsp -->
		<input type = "Button" name = "CancelFlights" value = "Cancel Existing Flight"><br/>
		<!-- Take user to FlightHistory.jsp -->
		<input type = "Button" name = "ViewHistory" value = "View Flight History"><br/>
		<!-- Take user to UpcomingFlightsPage.jsp -->
		<input type = "Button" name = "ViewUpcoming" value = "View Upcoming Flights"><br/>
		<!-- Take user to TicketDetailsPage.jsp -->
		<input type = "Button" name = "ViewTicketDeets" value = "View Ticket Details"><br/>
		<!--  Take user to JONTOADD -->
		<input type = "Button" name = "RepChat" value = "Chat with a Representative"><br/>
		<!-- Log out -->
		<input type = "Button" name = "LogOut" value = "Logout"><br/>
		<!-- Need to add functionality to send an alert when a flight a customer is on the waitlist for has a seat open up (must discuss) -->
		Wait list alerts: 
		</form>
	</body>
</html>