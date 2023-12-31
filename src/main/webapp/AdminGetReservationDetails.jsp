<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
	try {
		String type = request.getParameter("checkFor");
		String identification = request.getParameter("identification");
	    
		if (type == null || identification.equals("")) {
			out.print("<br>Empty field detected. Make sure all fields are filled in!");
		} else { 
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement stmt = con.createStatement();
			String query;
			
			if (type.equals("flight")) {
				String[] flight_codes = identification.split("-");
				query = "SELECT c.firstname, c.lastname, f.departure_airport_id, f.departure_time, f.arrival_airport_id, f.arrival_time, t.class, tf.seat_number, t.total_fare " +
						"FROM tickets t JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
						"JOIN flight f ON (tf.flight_num = f.flight_num AND tf.airline_id = f.airline_id) " + 
						"JOIN customer c ON t.username = c.username " +
						"WHERE f.airline_id='" + flight_codes[0] + "' " + 
						"AND f.flight_num='" + flight_codes[1] + "'";
			} else  {
				query = "SELECT c.firstname, c.lastname, f.departure_airport_id, f.departure_time, f.arrival_airport_id, f.arrival_time, t.class, tf.seat_number, t.total_fare " +
						"FROM tickets t JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
						"JOIN flight f ON (tf.flight_num = f.flight_num AND tf.airline_id = f.airline_id) " + 
						"JOIN customer c ON t.username = c.username " +
						"WHERE c.username='" + identification + "'";
			}
			
			ResultSet result = stmt.executeQuery(query);
			
			%>
			<table>
			<tr>
				<th> Customer First Name </th>
				<th> Customer Last Name </th>
				<th> Departure Airport </th>
				<th> Departure Time </th>
				<th> Arrival Airport </th>
				<th> Arrival Time </th>
				<th> Seat Class </th>
				<th> Seat Number </th>	
				<th> Total Fare </th>
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("c.firstname") %></td>
					<td><%= result.getString("c.lastname") %></td>
					<td><%= result.getString("f.departure_airport_id") %></td>
					<td><%= result.getString("f.departure_time") %></td>
					<td><%= result.getString("f.arrival_airport_id") %></td>
					<td><%= result.getString("f.arrival_time") %></td>
					<td><%= result.getString("t.class") %></td>
					<td><%= result.getString("tf.seat_number") %></td>
					<td><%= result.getString("t.total_fare") %></td>				
				</tr>
			<% }
			%>
			</table>
			<%
			//close the connection.
			db.closeConnection(con);
			}
	} catch(Exception e){
		out.print(e);
	} %>
	
	<form action = "AdminLandingPage.jsp" method = "POST">
		<button type="submit">Return to Home Page</button>
	</form><br>	
</body>
</html>