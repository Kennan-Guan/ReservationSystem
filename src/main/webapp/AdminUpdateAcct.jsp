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
	    
		if (account_type.equals("customer")) {
			if (update_type.equals("username")) {
				stmt.executeUpdate("UPDATE customer SET username='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("password")) {
				stmt.executeUpdate("UPDATE customer SET password='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("firstName")) {
				stmt.executeUpdate("UPDATE customer SET firstname='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("lastName")) {
				stmt.executeUpdate("UPDATE customer SET lastname='" + new_info + "' WHERE username='" + old_username + "'");
			} else {
				out.println("Make sure all fields are filled in. <a href='AdmingLandingPage.jsp'> Please try again </a>");
			}
		} else if (account_type.equals("customer representative")) {
			if (update_type.equals("username")) {
				stmt.executeUpdate("UPDATE customerrep SET username='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("password")) {
				stmt.executeUpdate("UPDATE customerrep SET password='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("firstName")) {
				stmt.executeUpdate("UPDATE customerrep SET firstname='" + new_info + "' WHERE username='" + old_username + "'");
			} else if (update_type.equals("lastName")) {
				stmt.executeUpdate("UPDATE customerrep SET lastname='" + new_info + "' WHERE username='" + old_username + "'");
			} else {
				out.println("Make sure all fields are filled in. <a href='AdmingLandingPage.jsp'> Please try again </a>");
			}
		} else {
			out.println("Make sure all fields are filled in. <a href='AdmingLandingPage.jsp'> Please try again </a>");
		}
		
		con.close();
		out.print("Update Succeeded");
		response.sendRedirect("AdminLandingPage.jsp");
		
	} catch(Exception e){
		out.print(e);
		out.print("Update Failed");
		response.sendRedirect("AdminLandingPage.jsp");
	}
	
	
%>
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>