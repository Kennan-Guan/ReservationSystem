<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Waitlist</title>
	</head>
	<body>
	
		<h1>Waitlist</h1>
		<!-- Need to add functionality to go home when button is pushed -->
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String airline_id = request.getParameter("airlineID");
			String flight_num = request.getParameter("flightNum");
			
			
			if (airline_id.equals("") || flight_num.equals("")) {
				out.print("Empty fields detected. Make sure all fields are filled in!");
			} else {
				//Make a SELECT query from the table specified by the 'waitList' parameter
				//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
				String str = "SELECT username FROM waitinglist WHERE airline_id='" + airline_id + "' AND flight_num='" + flight_num + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
			
				%>
				
				<table>
					<tr>
						<th>Name</th>
						
										
						
					</tr>
					<%
					//parse out the results
					while (result.next()) { %>
						<tr>    
							<td><%= result.getString("Name") %></td>
							
											
						</tr>
						
	
					<% }
					//close the connection.
					db.closeConnection(con);
					%>
				</table>	
			<%}
			
		} catch (Exception e) {
			out.print(e);
		}%>
	<br/>
		<form action = "CSRepLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>
	</body>
</html>