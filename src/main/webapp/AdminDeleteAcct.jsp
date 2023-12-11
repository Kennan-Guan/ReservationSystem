<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
	try {
		String account_type = request.getParameter("account");
		String username = request.getParameter("deletedUsername");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
	    
		if (account_type == null || username.equals("")) {
			out.print("Emtpy Field Detected. Make sure all fields are filled out!");
		} else if (account_type.equals("customer")) {
			stmt.executeUpdate("DELETE FROM customer WHERE username='" + username + "'");
			out.print("Deletion Succeeded");
		} else if (account_type.equals("customer representative")) {
			stmt.executeUpdate("DELETE FROM customerrep WHERE username='" + username + "'");
			out.print("Deletion Succeeded");
		} 
		
		con.close();
		
		
	} catch(Exception e){
		out.print(e);
		out.print("<br>Deletion Failed");
	}
	
	
%>
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>