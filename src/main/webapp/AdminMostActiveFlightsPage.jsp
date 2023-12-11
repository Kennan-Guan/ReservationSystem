<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Most Active Flights</title>
	</head>
	<body>
	
		<h1>Most Active Flights</h1>
		<!-- Need to add functionality to filter results or go home based on button clicked-->
		<form action="MostActiveFlightsActions.jsp" method="POST"> 
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'activeFlights' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String query = "SELECT f.airline_id, f.flight_num, COUNT(*) AS tickets_sold " +
							"FROM flight f JOIN ticket_flights tf ON (f.airline_id = tf.airline_id AND f.flight_num = tf.flight_num) " + 
							"GROUP BY f.airline_id, f.flight_num ORDER BY tickets_sold DESC LIMIT 1";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
		
		%>
		
		
		
		<table>
			<tr>
				<th> Airline </th>
				<th> Flight Number </th>
				<th> Tickets Sold </th>
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Airline") %></td>
					<td><%= result.getString("Flight Number") %></td>
					<td><%= result.getInt("Tickets Sold") %></td>
					
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
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>
	
	</body>
</html>