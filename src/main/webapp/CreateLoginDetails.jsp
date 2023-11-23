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
    
    ResultSet rs;
    
    rs = stmt.executeQuery("SELECT * FROM USERS WHERE username='" + username + "'");
    if (rs.next()) {
    	out.println("Username already exists, please <a href='CreateAccount.jsp'>try again</a>");
    } else {
    	int a = stmt.executeUpdate("INSERT INTO USERS VALUES('" + username + "', '" + password + "')");
    	
    	
    	session.setAttribute("user", username); 
        response.sendRedirect("Successful.jsp");


    	
    }
%>

</body>
</html>