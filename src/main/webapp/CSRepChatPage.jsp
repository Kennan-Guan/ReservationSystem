<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>

<!-- NOTE: NEED TO HAVE FUNCTIONALITY SO THAT IF THE MOST RECENT CHAT WAS SENT BY THE CUSTOMER, THE RESPONDED FIELD IN THE TABLE IS N, 
ELSE HAVE IT BE Y -->
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Customer Service Rep Chat Page</title>
	</head>
	<body>
	
		<h1>Customers Chatting With</h1>
		<form action="CustomerChatSubmit.jsp" method="POST"> 
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected filters
			String entity = request.getParameter("customerChatReps");
			//Make a SELECT query from the table specified by the 'customerChatReps' parameter
			//NOTE: NEED TO ENTER TEXT OF QUERY BASED ON SQL SCHEMA
			String str = "SELECT  FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
		%>
		
		
		
		<table>
			<tr>
				<th> Name </th>
				<th> Responded </th>
				
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Name") %></td>
					<td><%= result.getString("Responded") %></td>
					
					
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
	Enter name of Customer to chat with: <input type = "text" name = "Rep"/>
	<!--  Go to ViewChatsPage and allow the rep to see chats and respond -->
	<input type = "submit" value = "apply"><br/>
	<input type = "button" name = "Home" value = "Return Home">
	
	</body>
</html>