<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Browse Flights</title>
	</head>
	<body>
		<h1>Browse Flights</h1>
		<!-- Need to add functionality to send user to FlightResults.jsp and show matching flights -->
		<!-- Note: when creating the conditions for the mysql query, please store them as a string in a request object called "flightCrit" -->
		<form action="BrowseFlights.jsp" method="POST"> 
		<input type="radio" id = "1wsd" name="tickerType" value="One Way Set Date"> 
		<label for="1wsd">1 Way Set Date</label> 
		<input type="radio" id = "1wfd" name="tickerType" value="One Way Flex Date">
		<label for="1wfd">1 Way Flex Date</label> 
		<input type="radio" id = "2wsd" name="tickerType" value="Two Way Set Date"> 
		<label for="2wsd">2 Way Set Date</label>
		<input type="radio" id = "2wfd" name="tickerType" value="Two Way Flex Date">
		<label for="2wfd">2 Way Flex Date</label><br/>
		Departing Airport Code: <input type="text" name="DepartingCode"/> <br/>
		Arriving Airport Code: <input type="text" name="ArrivingCode"/> <br/>
		Date (mm/dd/yyyy format): <input type = "text" name = "FlightDate"/><br/>		
		<input type = "Submit" value = "See Flights"><br/>
		<input type = "Button" name = "GoBack" value = "Go Back">
		</form>
	</body>
</html>