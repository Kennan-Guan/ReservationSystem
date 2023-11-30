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
		<form action="UpcomingFlightsActionHandling.jsp" method="POST"> 
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String entity = request.getParameter("customerUpcoming");
			//Make a SELECT query from the table specified by the 'customerUpcoming' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT  FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		
		<table>
			<tr>
				<th> Ticket Number </th>
				<th> Purchase Date </th>
				<th> Purchase price </th>			
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Ticket Number") %></td>
					<td><%= result.getString("Purchase Date") %></td>
					<td><%= result.getString("Purchase Price") %></td>
									
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
	<!--  Go to landing page -->
	<input type = "button" name = "Home" value = "Return Home"><br/>
	<!-- Go to SubmitTickerForDetails.jsp -->
	<input type = "text" name = "TicketDeets" value = "View Ticket Details">
	
	
	</body>
</html>