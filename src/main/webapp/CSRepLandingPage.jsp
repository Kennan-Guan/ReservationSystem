<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>CS Rep Homepage</title>
	</head>
	<body>
		<h2>Reservations</h2>
		<!-- Need to create JSP file to lead CS Rep to next page based off of button clicked -->
		<!-- Go to InputCustomerForResPage.jsp -->
		<form action = "CSRepMakeRes.jsp" method = "POST">
       		Enter Customer's UserName: <input type="text" name="username"/> <br/>
       		Airline IDs (please separate entries by a semicolon): <input type = "text" name = "airlineIDs" /><br/>
			Flight Number (please separate entries by a semicolon): <input type = "text" name = "flightNums" /><br/>
			Class (Note, there is a $100 premium for business class and a $200 premium for first class)<br/>
			<select name="class" size=1>
				<option value="economy">Economy Class</option>
				<option value="business">Business Class</option>
				<option value="first">First Class</option>
			</select>&nbsp;<br>
			<button type="submit">Make Flight Reservation</button>
		</form><br>
		<!--  Go to EditRes.jsp -->
		<form action = "CSRepEditRes.jsp" method = "POST">
			
			<button type="submit">Edit Flight Reservation</button>
		</form><br>
		<!-- Go to CSRepChatPage.jsp -->
		<h2>Chat</h2>
	    <form action="CSRepChatPage.jsp" method="POST"> <!-- Specify the action URL -->
	        <input type="submit" name="Chat" value="Customer Chats">
	    </form>
	    <h2>Manage</h2>
		<!-- Go to ManageAircraftsPage.jsp -->
		<form action = "CSRepManageAircrafts.jsp" method = "POST">
			<button type="submit">Manage Aircrafts</button>
		</form><br>
		<!-- Go to ManageAirportsPage.jsp -->
		<form action = "CSRepManageAirports.jsp" method = "POST">
			<button type="submit">Manage Airports</button>
		</form><br>
		<!-- Go to ManageFlights.jsp -->
		<form action = "CSRepManageFlights.jsp" method = "POST">
			<button type="submit">Manage Flights</button>
		</form><br>
		<!-- Go To GetWaitList.jsp -->
		<h2>Information</h2>
		<form action = "CSRepGetWaitList.jsp" method = "POST">
			<button type="submit">Get Wait List</button>
		</form><br>
		<!-- Go to SubmitAirportForFlightsPage.jsp -->
		<form action = "CSRepGetFlights.jsp" method = "POST">
			<button type="submit">Get Flights</button>
		</form><br>
		<form action = "LogOut.jsp" method = "POST">
			<button type="submit">Logout</button>
		</form><br>	
	</body>
</html>