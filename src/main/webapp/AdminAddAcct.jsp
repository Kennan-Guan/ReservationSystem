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
		
	    
		if (account_type == null || new_username.equals("") || new_password.equals("") || new_fname.equals("") || new_lname.equals("")) {
			out.println("Empty Field Detected. Make sure all fields are filled in!");
		} else if (account_type.equals("customer")) {
			PreparedStatement ps = con.prepareStatement("INSERT INTO customer(username, password, firstname, lastname) VALUES (?, ?, ?, ?)");

			ps.setString(1, new_username);
			ps.setString(2, new_password);
			ps.setString(3, new_fname);
			ps.setString(4, new_lname);
			out.println("Account Added!");
		
			ps.executeUpdate();
		} else {
			PreparedStatement ps = con.prepareStatement("INSERT INTO customerrep(repusername, reppassword, firstname, lastname) VALUES (?, ?, ?, ?)");
			
			ps.setString(1, new_username);
			ps.setString(2, new_password);
			ps.setString(3, new_fname);
			ps.setString(4, new_lname);
			ps.executeUpdate();
			
			ps = con.prepareStatement("INSERT IGNORE INTO chat_customer_rep(repusername) VALUES (?)");
	        ps.setString(1, new_username);
	        ps.executeUpdate();
	        
	        ps = con.prepareStatement("INSERT INTO all_usernames(username) VALUES (?)");
	        ps.setString(1, new_username);
	        ps.executeUpdate(); 
			
			out.println("Account Added!");

		}	
		
        
		con.close();
		
		
	} catch(Exception e){
		out.println(e);
		out.println("<br>Account Could Not be Added");
	}
	
	
%>
		<form action = "AdminLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>