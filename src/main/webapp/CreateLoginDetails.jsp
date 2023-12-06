<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<title>Creating Login Details</title>

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
	Statement stmt_customer = conn.createStatement();
	Statement stmt_rep = conn.createStatement();
	Statement stmt_admin = conn.createStatement();
    
	//Check to see if username exists for an admin, customer, or customerrep
    ResultSet rs_customer = stmt_customer.executeQuery("SELECT * FROM customer WHERE username='" + username + "'");
    ResultSet rs_rep = stmt_rep.executeQuery("SELECT * FROM customerrep WHERE repusername='" + username + "'");
    ResultSet rs_admin = stmt_admin.executeQuery("SELECT * FROM admin WHERE adminusername='" + username + "'");
    if (rs_customer.next() || rs_rep.next() || rs_admin.next()) {
    	out.println("Username already exists, please <a href='CreateAccount.jsp'>try again</a>");
    } else {
    	stmt_customer.executeUpdate("INSERT INTO customer VALUES('" + username + "', '" + password + "')");
    	response.sendRedirect("Login.jsp");
    }
%>

</body>
</html>