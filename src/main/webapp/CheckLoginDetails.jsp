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
    ResultSet rs1;
    rs1 = stmt.executeQuery("SELECT * FROM USERS WHERE username='" + username + "'");
    if (rs1.next()){
    	 ResultSet rs2;
    	    rs2 = stmt.executeQuery("SELECT * FROM USERS WHERE username='" + username + "' AND password='" + password + "'");
    	    if (rs2.next()) {
    	    	session.setAttribute("user", username); 
    	        response.sendRedirect("Successful.jsp");
 	    } else {
    	        out.println("<a href='Login.jsp'> Invalid password try again bro</a>");
    	    }
    }
    else{
    	out.println("user not in db <a href='CreateAccount.jsp'>Create An Account</a>");
    }
%>

</body>
</html>