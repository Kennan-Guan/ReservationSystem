 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Ticket Details</title>
	</head>
	<body>
	
		<h1>Ticket Details</h1>
		
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String ticketNum = request.getParameter("ticketNum");
			
			if(ticketNum.equals("")){
				out.println("Please make sure to enter a valid Ticket ID! Go back and try again.");
			}
			//Make a SELECT query from the table specified by the 'ticketDetails' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT f.airline_id, f.flight_num, f.departure_airport_id, f.arrival_airport_id, f.departure_time, tf.seat_number, t.class " +
                    	 "FROM flight f " +
                    	 "JOIN ticket_flights tf ON (f.flight_num = tf.flight_num AND f.airline_id = tf.airline_id)" +
                    	 "JOIN tickets t ON tf.ticket_id = t.ticket_id " +
                    	 "WHERE tf.ticket_id = '" + ticketNum + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		<div class="marginTable"  data-count="5">
			<%=ticketNum%>
		</div>
		<table>
			<tr>
				<th> Airline </th>
				<th> Flight Number </th>
				<th> Origin Airport </th>
				<th> Destination Airport </th>
				<th> Departure Datetime </th>
				<th> Seat Number </th>
				<th> Seat Class </th>				
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("f.airline_id") %></td>
					<td><%= result.getString("f.flight_num") %></td>
					<td><%= result.getString("f.departure_airport_id") %></td>
					<td><%= result.getString("f.arrival_airport_id") %></td>
					<td><%= result.getTimestamp("f.departure_time") %></td>
					<td><%= result.getInt("tf.seat_number") %></td>
					<td><%= result.getString("t.class") %></td>					
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
		<form action = "CustomerLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		
		</form><br>
	
	
	</body>
</html>  