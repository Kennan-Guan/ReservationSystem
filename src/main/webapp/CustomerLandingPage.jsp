<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
    </form><br>

    <!-- Reserve Flights Button -->
    <form action="FlightReservationPage.jsp" method="get">
        <button type="submit">Reserve Flights</button>
    </form><br>

    <!-- Cancel Existing Flights Button -->
    <form action="CancelFlightsPage.jsp" method="get">
        <button type="submit">Cancel Existing Flights</button>
    </form><br>

    <!-- View Flight History Button -->
    <form action="FlightHistory.jsp" method="get">
        <button type="submit">View Flight History</button>
    </form><br>

    <!-- View Upcoming Flights Button -->
    <form action="UpcomingFlightsPage.jsp" method="get">
        <button type="submit">View Upcoming Flights</button>
    </form><br>

    <!-- View Ticket Details Button -->
    <form action="TicketDetails.jsp" method="get">
        <button type="submit">View Ticket Details</button>
    </form><br>

    <!-- Chat with a Representative Button -->
    <form action="CustomerChatPage.jsp" method="get">
        <button type="submit">Chat with a Representative</button>
    </form><br>

    <!-- Logout Button -->
    <form action="LogOut.jsp" method="get">
        <button type="submit">Logout</button>
    </form><br>
<% 	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	ResultSet result = stmt.executeQuery("SELECT airline_id, flight_num FROM waitinglist WHERE waitlistAlert = TRUE AND username = '" + 
	session.getAttribute("user") + "';");
			%>
			
			
    <!-- Need to add functionality to send an alert when a flight a customer is on the waitlist for has a seat open up (must discuss) -->
    Wait list alerts: 
    <% if (!result.next()){
    	
    } else{
    	%>
    	<table>
			<tr>
				<th> Airline ID </th>
				<th> Flight Number </th>				
				
			</tr>
    	
    	<%while (result.next()) { %>
		<tr>    
			<td><%= result.getString("airline_id") %></td>
			<td><%= result.getString("flight_num") %></td>
		</tr>
		<% 
    } 
    }
    %>
</body>
</html>