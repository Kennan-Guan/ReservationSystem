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
	String button = request.getParameter("Create Account");
	if (button != null && button.equals("Create Account")){
		response.sendRedirect("CreateAccount.jsp");
	}
	
	try {

		String username = request.getParameter("username"); 
		String password = request.getParameter("password");
		String submitbutton = request.getParameter("submit");
		    // Check if username and password are empty
		 if (submitbutton != null && submitbutton.equals("")) {
		      if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
		          out.println("<p>Please fill in both username and password fields.</p>");
		          return;
		        }
		    }
		
		ApplicationDB db = new ApplicationDB();	
		Connection conn = db.getConnection();	
		Statement stmt_customer = conn.createStatement();
		Statement stmt_customerrep = conn.createStatement();
		Statement stmt_admin = conn.createStatement();
		//Check to see whether the details are correct. If correct, direct to the appropriate page based on account type
	    ResultSet rs_customer = stmt_customer.executeQuery("SELECT * FROM customer WHERE username='" + username + "'");
	    ResultSet rs_rep = stmt_customerrep.executeQuery("SELECT * FROM customerrep WHERE repusername='" + username + "'");
	    ResultSet rs_admin = stmt_admin.executeQuery("SELECT * FROM admin WHERE adminusername='" + username + "'");
	    if (rs_customer.next()){
	    	 ResultSet rs_customer_pass = stmt_customer.executeQuery("SELECT * FROM customer WHERE username='" + username + "' AND password='" + password + "'");
	    	 if (rs_customer_pass.next()) {
	             session.setAttribute("userType", "customer");
		    	 session.setAttribute("user", username); 
		         response.sendRedirect("CustomerLandingPage.jsp");
	 	    } else {
	    	     out.println("<a href='Login.jsp'> Invalid password, please try again</a>");
	    	}
	    } else if(rs_rep.next()) {
	    	ResultSet rs_customerrep_pass = stmt_customerrep.executeQuery("SELECT * FROM customerrep WHERE repusername='" + username + "' AND reppassword='" + password + "'");
	   	 	if (rs_customerrep_pass.next()) {
                session.setAttribute("userType", "customerrep");
		   	 	session.setAttribute("user", username); 
		        response.sendRedirect("CSRepLandingPage.jsp");
		    } else {
	   	        out.println("<a href='Login.jsp'> Invalid password, please try again</a>");
	   	    }    	
	    } else if(rs_admin.next()) {
	    	ResultSet rs_admin_pass = stmt_admin.executeQuery("SELECT * FROM admin WHERE adminusername='" + username + "' AND adminpassword='" + password + "'");
	   	 	if (rs_admin_pass.next()) {
                session.setAttribute("userType", "admin");
		   	 	session.setAttribute("user", username); 
		        response.sendRedirect("AdminLandingPage.jsp");
		    } else {
	   	        out.println("<a href='Login.jsp'> Invalid password, please try again</a>");
	   	    }    	
	    } else{
	    	out.println("The inputted user is not in the database: <a href='CreateAccount.jsp'>Create An Account</a> <a href='Login.jsp'>Try Again</a>");
	    }
	    
	} catch (Exception e) {
		out.print(e);
	}
%>

</body>
</html>