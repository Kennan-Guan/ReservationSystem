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
		String new_username = request.getParameter("newUsername");
		String new_password = request.getParameter("newPassword");
		String new_fname = request.getParameter("newFname");
		String new_lname = request.getParameter("newLname");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
		PreparedStatement ps;
	    
		if (account_type.equals("customer")) {
			ps = con.prepareStatement("INSERT INTO customer(username, password, firstname, lastname) VALUES (?, ?, ?, ?)");

			ps.setString(1, new_username);
			ps.setString(2, new_password);
			ps.setString(3, new_fname);
			ps.setString(4, new_lname);
		} else if (account_type.equals("customer representative")) {
			ps = con.prepareStatement("INSERT INTO customerrep(repusername, reppassword, firstname, lastname) VALUES (?, ?, ?, ?)");
			
			ps.setString(1, new_username);
			ps.setString(2, new_password);
			ps.setString(3, new_fname);
			ps.setString(4, new_lname);
		} else {
			out.println("Make sure all fields are filled in. <a href='AdmingLandingPage.jsp'> Please try again </a>");
		}

		
		con.close();
		out.print("Account Added!");
		response.sendRedirect("AdminLandingPage.jsp");
		
	} catch(Exception e){
		out.print(e);
		out.print("Account Could Not be Completed");
		response.sendRedirect("AdminLandingPage.jsp");
	}
	
	
%>
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>