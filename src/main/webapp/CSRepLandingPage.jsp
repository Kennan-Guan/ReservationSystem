<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>CS Rep Homepage</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to lead CS Rep to next page based off of button clicked -->
		<form action = "CSRepSelectionHandling.jsp" method = "POST">
		<!-- Go to  -->
		<input type = "Button" name = "MakeReservation" value = "Make Flight Reservation"><br/>	
		<input type = "Button" name = "EditReservation" value = "Edit Flight Reservation"><br/>
		<!-- Make chat functionality -->
		<input type = "Button" name = "Chat" value = "Customer Chats"><br/>
		<input type = "Button" name = "ManageAircrafts" value = "Manage Aircrafts"><br/>
		<input type = "Button" name = "ManageAirports" value = "Manage Airports"><br/>
		<input type = "Button" name = "ManageFlights" value = "Manage Flights"><br/>
		<input type = "Button" name = "GetWaitingList" value = "Get Waiting List"><br/>
		<input type = "Button" name = "GetFlights" value = "Get Flights"><br/>
		<input type = "Button" name = "LogOut" value = "Logout">
		</form>
	</body>
</html>