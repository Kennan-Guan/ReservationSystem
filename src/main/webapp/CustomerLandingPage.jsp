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
		<input type = "Button" name = "BrowseFlights" value = "Browse Flights"><br/>
		<input type = "Button" name = "ReserveFlights" value = "Reserve Flights"><br/>
		<input type = "Button" name = "CancelFlights" value = "Cancel Existing Flight"><br/>
		<input type = "Button" name = "ViewHistory" value = "View Flight History"><br/>
		<input type = "Button" name = "ViewUpcomong" value = "View Upcoming Flights"><br/>
		<input type = "Button" name = "ViewTicketDeets" value = "View Ticket Details"><br/>
		<input type = "Button" name = "RepChat" value = "Chat with a Representative"><br/>
		<input type = "Button" name = "LogOut" value = "Logout">
		<!-- Need to add functionality to send an alert when a flight a customer is on the waitlist for has a seat open up (must discuss) -->
		Wait list alerts: 
		</form>
	</body>
</html>