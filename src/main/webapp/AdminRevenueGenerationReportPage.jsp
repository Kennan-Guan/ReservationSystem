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
	
		<h1>Revenue Generation</h1>
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String report_type = request.getParameter("RevReportFor");
			String identification = request.getParameter("revenueGeneratorId");
			//Make a SELECT query from the table specified by the 'revGeneratorReport' parameter
			String query;
			
			if (report_type.equals("airline")) {
				query = "SELECT SUM(total_fare) AS Revenue, COUNT(*) AS Number_of_Sales FROM airline a JOIN tickets t ON a.airline_id = t.airline_id WHERE a.airline_id='" + identification + "'";
			} else if (report_type.equals("flight")) {
				query = "SELECT SUM(total_fare) AS Revenue, COUNT(*) AS Number_of_Sales FROM flight f JOIN tickets t ON (f.flight_num = t.flight_num AND f.airline_id = t.airline_id) WHERE f.flight_num='" + identification + "'";
			} else {
				query = "SELECT SUM(total_fare) AS Revenue, COUNT(*) AS Number_of_Sales FROM customer c JOIN tickets t ON c.username = t.username WHERE c.username='" + identification + "'";
			}
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
		
		%>
		
		
		<table>
			<tr>
				<th> Revenue </th>
				<th> Number of Sales </th>	
				
			</tr>
			<%
			//parse out the results	
			while (result.next()) { %>
				<tr>    
					<td><%= result.getFloat("Revenue") %></td>
					<td><%= result.getInt("Number_of_Sales") %></td>
									
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