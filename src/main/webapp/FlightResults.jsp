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
		<!-- Need to add functionality to filter results (which would return to this page but with a different set of query results displayed)
		, go back to BrowseFlights.jsp, or go to CustomerLandingPage.jsp --> 
		
		<% try {
			//Set up variables to store userinputs for first sort, departure sort
			String sort1 = request.getParameter("sort1");
			String minPrice1 = request.getParameter("minprice1");
			String maxPrice1 = request.getParameter("maxprice1");
			String airline1 = request.getParameter("airline1");
			String minTakeoff1 = request.getParameter("minTakeoff1");
			String maxTakeoff1 = request.getParameter("maxTakeoff1");
			String minArrival1 = request.getParameter("minArrival1");
			String maxArrival1 = request.getParameter("maxArrival1");
			
			//Set up variables to store userinputs for second sort, arrival sort
			String sort2 = request.getParameter("sort2");
			String minPrice2 = request.getParameter("minprice2");
			String maxPrice2 = request.getParameter("maxprice2");
			String maxStops2 = request.getParameter("maxstops2");
			String airline2 = request.getParameter("airline2");
			String minTakeoff2 = request.getParameter("minTakeoff2");
			String maxTakeoff2 = request.getParameter("maxTakeoff2");
			String minArrival2 = request.getParameter("minArrival2");
			String maxArrival2 = request.getParameter("maxArrival2");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Need to add functionality to store and accept query results as parameter
			String entity = request.getParameter("resultsQuery");
			String query = "SELECT * FROM resultsQuery WHERE 1=1";
			
			// IF statements to process the first filters
			if (minPrice1 != null && !minPrice1.isEmpty()){
				query += " AND resultsQuery.economy_rate >= '" + minPrice1 + "'"; // Table name and attributes are PLACEHOLDERS
			}
			
			if (maxPrice1 != null && !maxPrice1.isEmpty()){
				query += " AND resultsQuery.economy_rate <= '" + maxPrice1 + "'";
			}
			
			if (maxStops1 != null && !maxStops1.isEmpty()){
				query += " AND resultsQuery.maxStops <= '" + maxStops1 + "'";
			}
			
			if (airline1 != null && !airline1.isEmpty()){
				query += " AND resultsQuery.airline == '" + airline1 + "'";
			}
			
			if (minTakeoff1 != null && !minTakeoff1.isEmpty()){
				query += " AND resultsQuery.departure_time >= '" + minTakeoff1 + "'";
			}
			
			if (maxTakeoff1 != null && !maxTakeoff1.isEmpty()){
				query += " AND resultsQuery.departure_time <= '" + maxTakeoff1 + "'";
			}
			
			if (minArrival1 != null && !minArrival1.isEmpty()){
				query += " AND resultsQuery.arrival_time >= '" + minArrival1 + "'";
			}
			
			if (maxArrival1 != null && !maxArrival1.isEmpty()){
				query += " AND resultsQuery.arrival_time <= '" + maxArrival1 + "'";
			}
			
			if (sort1 != null && !sort1.isEmpty()){
				query += " ORDER BY '" + sort1 + "' ASC";
			}
			
			// IF statements to process the second filters
			if (minPrice2 != null && !minPrice2.isEmpty()){
				query += " AND resultsQuery.economy_rate >= '" + minPrice2 + "'"; // Table name and attributes are PLACEHOLDERS
			}
			
			if (maxPrice2 != null && !maxPrice2.isEmpty()){
				query += " AND resultsQuery.economy_rate <= '" + maxPrice2 + "'";
			}
			
			if (maxStops2 != null && !maxStops2.isEmpty()){
				query += " AND resultsQuery.maxStops <= '" + maxStops2 + "'";
			}
			
			if (airline2 != null && !airline2.isEmpty()){
				query += " AND resultsQuery.airline == '" + airline2 + "'";
			}
			
			if (minTakeoff2 != null && !minTakeoff2.isEmpty()){
				query += " AND resultsQuery.departure_time >= '" + minTakeoff2 + "'";
			}
			
			if (maxTakeoff2 != null && !maxTakeoff2.isEmpty()){
				query += " AND resultsQuery.departure_time <= '" + maxTakeoff2 + "'";
			}
			
			if (minArrival2 != null && !minArrival2.isEmpty()){
				query += " AND resultsQuery.arrival_time >= '" + minArrival2 + "'";
			}
			
			if (maxArrival2 != null && !maxArrival2.isEmpty()){
				query += " AND resultsQuery.arrival_time <= '" + maxArrival2 + "'";
			}
			
			if (sort2 != null && !sort2.isEmpty()){
				query += " ORDER BY '" + sort2 + "' ASC";
			}
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		
		<table>
			<tr>
				<th> Airline </th>
				<th> Flight Number </th>
				<th> Departure Time </th>
				<th> Arrival Time </th>
				<th> Departure Date </th>
				<th> Seats Remaining </th>
				<th> Price </th>
				<th> Flight Duration </th>
				<th> Number of Stops </th>
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Airline") %></td>
					<td><%= result.getString("Flight Number") %></td>
					<td><%= result.getString("Departure Time") %></td>
					<td><%= result.getString("Arrival Time") %></td>
					<td><%= result.getString("Departure Date") %></td>
					<td><%= result.getString("Seats Remaining") %></td>
					<td><%= result.getString("Price") %></td>
					<td><%= result.getString("Flight Duration") %></td>
					<td><%= result.getString("Number of Stops") %></td>
					
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
	
	<form action="CustomerLandingPage.jsp" method="get">
        <button type="submit">Return Home</button>
    </form><br> 
	<input type = "button" name = "Home" value = "Return Home"><br/>
	<input type = "button" name = "Back" value = "Back"><br/>
	<input type = "submit" value = "apply">
	
	</body>
</html> 