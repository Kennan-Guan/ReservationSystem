<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Flights</title>
	</head>
	<body>
	
		<h1>Flights</h1>
		<!-- Need to add functionality to filter results (which would return to this page but with a different set of query results displayed)
		, go back to BrowseFlights.jsp, or go to CustomerLandingPage.jsp -->
		<form action="FlightResActionHandling.jsp" method="POST"> 
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String entity = request.getParameter("flightCrit");
			//Make a SELECT query from the table specified by the 'flightCrit' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT  FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		
		<table>
			<tr>
				<th> Airline </th>
				<th> Flight Number </th>
				<th> Departure Time </th>
				<th> Arrival Time </th>
				<th> Departure Date </th>
				<th> Seats Remaining </th>
				<th> Price </th>
				<th> Flight Duration </th>
				<th> Number of Stops </th>
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Airline") %></td>
					<td><%= result.getString("Flight Number") %></td>
					<td><%= result.getString("Departure Time") %></td>
					<td><%= result.getString("Arrival Time") %></td>
					<td><%= result.getString("Departure Date") %></td>
					<td><%= result.getString("Seats Remaining") %></td>
					<td><%= result.getString("Price") %></td>
					<td><%= result.getString("Flight Duration") %></td>
					<td><%= result.getString("Number of Stops") %></td>
					
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		</form>
	
	<%} catch (Exception e) {
			out.print(e);
		}%>
	<br/>
	Sort By: <input type = "radio" id = "price" name = "sort" value = "Price">
	<label for="price">Price</label> 
	<input type = "radio" id = "takeoff" name = "sort" value = "Take off time">
	<label for="takeoff">Take off time</label> 
	<input type = "radio" id = "landing" name = "sort" value = "Landing">
	<label for="landing">Landing Time</label> 
	<input type = "radio" id = "duration" name = "sort" value = "Duration">
	<label for="duration">Duration</label> <br/>
	Filter By: <br/>
	min price: <input type = "text" placeholder = 0 name = "minprice"/><br/>
	max price: <input type = "text" placeholder = 999999 name = "maxprice"/><br/>
	max num stops: <input type = "text" name = "maxstops"/><br/>
	airline: <input type = "text" name = "airline"/><br/>
	min takeoff time: <input type = "text" name = "minTakeoff"/><br/>
	max takeoff time: <input type = "text" name = "maxTakeoff"/><br/>
	min arrival time: <input type = "text" name = "minArrival"/><br/>
	max arrival time: <input type = "text" name = "maxArrival"/><br/>
	<input type = "button" name = "Home" value = "Return Home"><br/>
	<input type = "button" name = "Back" value = "Back"><br/>
	<input type = "submit" value = "apply">
	
	</body>
</html>