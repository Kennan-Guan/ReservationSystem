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
	try{
		String old_username = request.getParameter("oldUName");
		String new_username = request.getParameter("newUName"); 
		String new_password = request.getParameter("newPwd");
		String new_Fname = request.getParameter("newFname");
		String new_Lname = request.getParameter("newLname");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
	    
		stmt.executeUpdate("UPDATE Account SET username='" + new_username +
						"', password='" + new_password +
						"', fname='" + new_Fname +
						"', lname='" + new_Lname +
						"WHERE username='" + old_username + "'");
		con.close();
		out.print("Update Succeeded");
		response.sendRedirect("AdminLandingPage.jsp");
		
	} catch(Exception e){
		out.print(e);
		out.print("Update Failed");
	}
	
	
%>

</body>
</html>