<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upcoming Flights</title>
	</head>
	<body>
	
		<h1>Upcoming Flights</h1>
		<!-- Need to add functionality to send user to next page based on button clicked-->
		
		<% try {
			String username = (String) session.getAttribute("username");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			//Make a SELECT query from the table specified by the 'customerUpcoming' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT t.ticket_id, t.purchase_datetime, t.total_fare " +
                    	 "FROM tickets t " +
                    	 "JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
                    	 "JOIN flight f ON tf.flight_num = f.flight_num " +
                    	 "WHERE f.departure_time >= CURRENT_DATE AND t.username = '" + username + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		<table>
			<tr>
				<th> Ticket Number </th>
				<th> Purchase Date </th>
				<th> Purchase Price </th>			
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("t.ticket_id") %></td>
					<td><%= result.getString("t.purchase_datetime") %></td>
					<td><%= result.getString("t.total_fare") %></td>
									
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