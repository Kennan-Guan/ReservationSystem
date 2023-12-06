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
	String username = request.getParameter("username"); 
	String password = request.getParameter("password");
	
	ApplicationDB db = new ApplicationDB();	
	Connection conn = db.getConnection();	
	Statement stmt = conn.createStatement();
	//Check to see whether the details are correct. If correct, direct to the appropriate page based on account type
    ResultSet rs_customer_user = stmt.executeQuery("SELECT * FROM customer WHERE username='" + username + "'");
    ResultSet rs_customerrep_user = stmt.executeQuery("SELECT * FROM customerrep WHERE username='" + username + "'");
    ResultSet rs_admin_user = stmt.executeQuery("SELECT * FROM admin WHERE username='" + username + "'");
    if (rs_customer_user.next()){
    	 ResultSet rs_customer_pass = stmt.executeQuery("SELECT * FROM customer WHERE username='" + username + "' AND password='" + password + "'");
    	 if (rs_customer_pass.next()) {
	    	 session.setAttribute("user", username); 
	         response.sendRedirect("CustomerLandingPage.jsp");
 	    } else {
    	     out.println("<a href='Login.jsp'> Invalid password, please try again</a>");
    	}
    } else if(rs_customerrep_user.next()) {
    	ResultSet rs_customerrep_pass = stmt.executeQuery("SELECT * FROM customerrep WHERE username='" + username + "' AND password='" + password + "'");
   	 	if (rs_customerrep_pass.next()) {
	   	 	session.setAttribute("user", username); 
	        response.sendRedirect("CSRepLandingPage.jsp");
	    } else {
   	        out.println("<a href='Login.jsp'> Invalid password, please try again</a>");
   	    }    	
    } else if(rs_admin_user.next()) {
    	ResultSet rs_admin_pass = stmt.executeQuery("SELECT * FROM admin WHERE username='" + username + "' AND password='" + password + "'");
   	 	if (rs_admin_pass.next()) {
	   	 	session.setAttribute("user", username); 
	        response.sendRedirect("AdminLandingPage.jsp");
	    } else {
   	        out.println("<a href='Login.jsp'> Invalid password, please try again</a>");
   	    }    	
    } else{
    	out.println("The inputted user is not in the database: <a href='CreateAccount.jsp'>Create An Account</a>");
    }
%>

</body>
</html>