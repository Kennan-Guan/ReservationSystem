<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Chats Page</title>
	</head>
	<body>
	
		<h1>Chats</h1>
		<!-- Need to add functionality to filter results or go home based on button clicked-->
		<form action="ChatInter.jsp" method="POST"> 
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String entity = request.getParameter("chatDisplay");
			//Make a SELECT query from the table specified by the 'activeFlights' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT  FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		
		<table>
			<tr>
				<th> Chats </th>
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Chat") %></td>
					
					
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
	
	
	Enter New message: <input type = "text" name = "Msg"/>
	<input type = "submit" value = "apply"><br/>

	Search Chat By keyword: <input type = "text" name = "keyword"/>
	<!--  Upon clicking, return to this page but now display all chats with this keyword only -->
	<input type = "button" name = "Search" value = "Search">
	
	<input type = "button" name = "Home" value = "Return Home">
	
	</body>
</html>