<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Revenue Generator</title>
	</head>
	<body>
	
		<h1>Revenue Generator</h1>
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String report_type = request.getParameter("revGeneratorReport");
			String identification = request.getParameter("revenueGeneratorId");
			//Make a SELECT query from the table specified by the 'revGeneratorReport' parameter
			String query;
			
			if (report_type.equals("airline")) {
				query = "SELECT SUM(total_fare), COUNT(*) FROM airline JOIN tickets ON airline.airline_id = tickets.airline_id WHERE airline_id='" + identification + "'";
			} else if (report_type.equals("flight")) {
				query = "SELECT SUM(total_fare), COUNT(*) FROM flight JOIN tickets ON flight.flight_id = tickets.flight_id WHERE flight_id='" + identification + "'";
			} else {
				query = "SELECT SUM(total_fare), COUNT(*) FROM customer JOIN tickets ON customer.username = tickets.username WHERE username='" + identification + "'";
			}
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
		
		%>
		
		
		<table>
			<tr>
				<th> Revenue </th>
				<th> Num Sales </th>	
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Revenue") %></td>
					<td><%= result.getString("Num Sales") %></td>
									
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
	
	<%} catch (Exception e) {
			out.print(e);
		}%>
	<br/>
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
	
	
	</body>
</html>