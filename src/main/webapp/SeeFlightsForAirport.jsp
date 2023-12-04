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
		<!-- Need to add functionality to go home when button is pushed -->
		<form action="GoHome.jsp" method="POST"> 
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String entity = request.getParameter("flightList");
			//Make a SELECT query from the table specified by the 'flightList' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT  FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		<table>
			<tr>
				<th> Airline</th>
				<th> Flight Num</th>
				
								
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Airline") %></td>
					<td><%= result.getString("Flight Num") %></td>
					
									
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
	<input type = "submit" value = "Home"><br/>
	
	
	</body>
</html>