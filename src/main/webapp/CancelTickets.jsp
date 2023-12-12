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
		String ticketId = request.getParameter("ticketId");
		String username = (String) session.getAttribute("user");
		
		if (ticketId.equals("")){
			out.println("Please make sure to enter a valid Ticket ID! Go back and try again.");
		}
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		Statement stmtDelete = con.createStatement();
		// Check to see if ticketId matches the owner and if ticket is business/first
		ResultSet result = stmt.executeQuery("SELECT * FROM tickets t WHERE t.ticket_id ='" + ticketId + "'AND t.username = '" + username + "'AND t.class IN ('business', 'first')");
		if (result.next()) {
			// If the ticket exists, owned by user, is business/first, delete and send to appropriate pages
			stmtDelete.executeUpdate("DELETE FROM tickets WHERE ticket_id ='" + ticketId + "'AND username = '" + username + "'");
			response.sendRedirect("CancelSuccessPage.jsp");
		} else {
			response.sendRedirect("CancelFailPage.jsp");
		} 
		db.closeConnection(con);
		} catch (Exception e){
			out.print(e);
		}
		
%>	

</body>
</html>  