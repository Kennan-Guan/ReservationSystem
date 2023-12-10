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

    <!-- Browse Flights Button -->
    <form action="BrowseFlights.jsp" method="get">
        <button type="submit">Browse Flights</button>
    </form>

    <!-- Reserve Flights Button -->
    <form action="ReserveFlights.jsp" method="get">
        <button type="submit">Reserve Flights</button>
    </form>

    <!-- Cancel Existing Flights Button -->
    <form action="CancelFlightsPage.jsp" method="get">
        <button type="submit">Cancel Existing Flights</button>
    </form>

    <!-- View Flight History Button -->
    <form action="FlightHistory.jsp" method="get">
        <button type="submit">View Flight History</button>
    </form>

    <!-- View Upcoming Flights Button -->
    <form action="UpcomingFlights.jsp" method="get">
        <button type="submit">View Upcoming Flights</button>
    </form>

    <!-- View Ticket Details Button -->
    <form action="TicketDetailsPage.jsp" method="get">
        <button type="submit">View Ticket Details</button>
    </form>

    <!-- Chat with a Representative Button -->
    <form action="CustomerChatPage.jsp" method="get">
        <button type="submit">Chat with a Representative</button>
    </form>

    <!-- Logout Button -->
    <form action="LogOut.jsp" method="get">
        <button type="submit">Logout</button>
    </form>

    <!-- Need to add functionality to send an alert when a flight a customer is on the waitlist for has a seat open up (must discuss) -->
    Wait list alerts: 
</body>
</html>