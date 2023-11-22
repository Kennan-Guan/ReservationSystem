<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Flights</title>
	</head>
	<body>
		<h1>Flights</h1>
		<!-- Need to add functionality to show resulting flights and allow user to filter results -->
		
		<form action="ShowFlights.jsp" method="POST"> 
		
		<table>
			<tr>
				<th> Airline </th>
				<th> Flight No. </th>
				<th> Departure Time </th>
				<th> Arrival Time </th>
				<th> Departure Date </th>
				<th> Seats Remaining </th>
				<th> Price </th>
				<th> Flight Duration </th>
				<th> Number of Stops </th>
			</tr>
		</table>
		</form>
	</body>
</html>