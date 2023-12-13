<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Top Customer</title>
	</head>
	<body>
	
		<h1>Top Customer</h1>
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'topCustomer' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT c.firstname, c.lastname, SUM(total_fare) as total_revenue FROM tickets t JOIN customer c ON t.username = c.username GROUP BY c.firstname, c.lastname ORDER BY SUM(total_fare) DESC LIMIT 1";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		<table>
			<tr>
				<th> First Name </th>
				<th> Last Name </th>
				<th> Total Revenue Generated </th>				
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("c.firstname") %></td>
					<td><%= result.getString("c.lastname") %></td>
					<td><%= result.getFloat("total_revenue")%></td>
									
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