<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Sales Report</title>
	</head>
	<body>
	
		<h1>Sales Report</h1>
		
		<% 	
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	

			//Create a SQL statement
			Statement stmt_total_sales = con.createStatement();
			Statement stmt_num_sales = con.createStatement();
			Statement stmt_largest_sale = con.createStatement();
			
			//Get Filters
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			
			//Run the query against the database.
			ResultSet total_sales = stmt_total_sales.executeQuery("SELECT SUM(total_fare) FROM tickets WHERE MONTH(purchase_date)='" + month + "' AND YEAR(purchase_date)='" + year + "'");
			ResultSet num_sales = stmt_num_sales.executeQuery("SELECT COUNT(*) FROM tickets WHERE MONTH(purchase_date)='" + month + "' AND YEAR(purchase_date)='" + year + "'");
			ResultSet largest_sale = stmt_largest_sale.executeQuery("SELECT * FROM tickets WHERE MONTH(purchase_date)='" + month + "' AND YEAR(purchase_date)='" + year + 
																		"' AND total_fare=(SELECT MAX(total_fare) FROM tickets WHERE MONTH(purchase_date)='" + month + 
																		"' AND YEAR(purchase_date)='" + year +"')");
		
		%>
		
		<table>
			<tr>
				<th> Total Sales </th>
				<th> Number of Sales </th>
				<th> Largest Sale </th>
								
				
			</tr>
			<%
			//parse out the results
			while (total_sales.next() && num_sales.next() && largest_sale.next()) { %>
				<tr>    
					<td><%= total_sales.getString("Total Sales") %></td>
					<td><%= num_sales.getString("Number of Sales") %></td>
					<td><%= largest_sale.getString("Largest Sale") %></td>
									
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
	<a href="AdminLandingPage.jsp">Return Home</a><br/>
	
	
	</body>
</html>