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
	Statement stmt = conn.createStatement();
    
	//Check to see if username exists for an admin, customer, or customerrep
    ResultSet rs = stmt.executeQuery("SELECT * FROM customerrep WHERE username='" + username + "'");
    ResultSet rs2 = stmt.executeQuery("SELECT * FROM admin WHERE username='" + username + "'");
    ResultSet rs3 = stmt.executeQuery("SELECT * FROM customer WHERE username='" + username + "'");
    if (rs.next() || rs2.next() || rs3.next()) {
    	out.println("Username already exists, please <a href='CreateAccount.jsp'>try again</a>");
    } else {
    	int a = stmt.executeUpdate("INSERT INTO USERS VALUES('" + username + "', '" + password + "')");
        response.sendRedirect("Login.jsp");


    	
    }
%>

</body>
</html>