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
		<!-- Take the user to BrowseFlights.jsp -->
		<a href="BrowseFlights.jsp">Browse Flights</a>
		<!-- Take the user to FlightReservationPage.jsp -->
		<a href="ReserveFlights.jsp">Reserve Flights</a>
		<!-- Send user to CancelFlightssPage.jsp -->
		<a href="CancelFlightsPage.jsp">Cancel Existing Flights</a>
		<!-- Take user to FlightHistory.jsp -->
		<a href="FlightHistory.jsp">View Flight History</a>
		<!-- Take user to UpcomingFlightsPage.jsp -->
		<a href="UpcomingFlights.jsp">View Upcoming Flights</a>
		<!-- Take user to TicketDetailsPage.jsp -->
		<a href="TicketDetailsPage.jsp">View Ticket Details</a>
		<!--  Take user to CustomerChatPage.jsp -->
		<a href="CustomerChatPage.jsp">Chat with a Representative</a>
		<!-- Log out -->
		<a href="Logout.jsp">Logout</a>
		<!-- Need to add functionality to send an alert when a flight a customer is on the waitlist for has a seat open up (must discuss) -->
		Wait list alerts: 
	</body>
</html>