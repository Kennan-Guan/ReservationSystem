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
		String old_username = request.getParameter("accountName"); 
		String update_type = request.getParameter("updateType");
		String new_info = request.getParameter("newInfo");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
	    
		
		if (account_type == null || old_username.equals("") || update_type == null || new_info.equals("")) {
			out.print("Empty Field Detected. Make sure all fields are filled out!");
		} else if (account_type.equals("customer")) {
			if (update_type.equals("username")) {
				stmt.executeUpdate("UPDATE customer SET username='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("password")) {
				stmt.executeUpdate("UPDATE customer SET password='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("firstName")) {
				stmt.executeUpdate("UPDATE customer SET firstname='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("lastName")) {
				stmt.executeUpdate("UPDATE customer SET lastname='" + new_info + "' WHERE username='" + old_username + "'");
			} 
			out.print("<br>Update Succeeded");
		} else if (account_type.equals("customer representative")) {
			if (update_type.equals("username")) {
				stmt.executeUpdate("UPDATE customerrep SET repusername='" + new_info + "' WHERE repusername='" + old_username + "'");
			} else if (update_type.equals("password")) {
				stmt.executeUpdate("UPDATE customerrep SET reppassword='" + new_info + "' WHERE repusername='" + old_username + "'");
			} else if (update_type.equals("firstName")) {
				stmt.executeUpdate("UPDATE customerrep SET firstname='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("lastName")) {
				stmt.executeUpdate("UPDATE customerrep SET lastname='" + new_info + "' WHERE username='" + old_username + "'");
			} 
			out.print("<br>Update Succeeded");
		}
		
		con.close();

		
	} catch(Exception e){
		out.print(e);
		out.print("<br>Update Failed");
	}
	
	
%>
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>