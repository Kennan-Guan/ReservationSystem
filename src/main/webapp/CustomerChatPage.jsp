<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Customer Chat Page</title>
	</head>
	<body>
	
		<h1>Reps with existing chats</h1>
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
		</form>
	
	<%} catch (Exception e) {
			out.print(e);
		}%>
	<br/>
	<!-- Note: make it so that if the customer wants to start a new chat, the next screen opens a chat with a random representative (can be one 
	they've worked with before or one they've never worked with) -->
	<input type = "button" name = "newChat" value = "Start New Chat">
	Enter name of representative for existing chat: <input type = "text" name = "Rep"/>
	<!--  Go to ViewChatsPage if they're looking at an existing chat -->
	<input type = "submit" value = "apply"><br/>
	<input type = "button" name = "Home" value = "Return Home">
	
	</body>
</html>