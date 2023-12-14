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
		
		if (ticketId.equals("")){
			out.println("Please make sure to enter a valid Ticket ID! Go back and try again.");
		} else {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			Statement stmtCheck = con.createStatement();
			Statement stmtUpdate = con.createStatement();
			Statement stmtDelete = con.createStatement();
			Statement stmtAlert = con.createStatement();
			// Check to see if ticketId matches the owner and if ticket is business/first
			ResultSet getTicket = stmt.executeQuery("SELECT t.username, t.seat_class, tf.flight_num, tf.airline_id " +
	                								"FROM tickets t " +
	                								"INNER JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
	               									"WHERE t.ticket_id = '" + ticketId + "'");
			if (getTicket.next()) {
				 String username = getTicket.getString("username");
	             String seatClass = getTicket.getString("seat_class");
	             String flightNum = getTicket.getString("flight_num");
	             String airlineId = getTicket.getString("airline_id");
	             // Check to see if user matches username on ticket, and if ticket is business/first class
	             if (username.equals(session.getAttribute("user")) && ("first".equals(seatClass) || "business".equals(seatClass))) {
	            	 // Update seats_remaining on flight
	           		stmtUpdate.executeUpdate("UPDATE flights SET seats_remaining = seats_remaining + 1 WHERE airline_id = '" + airlineId + "' AND flight_num = '" + flightNum + "'");
	            	 // Delete ticket from tickets table
	           		stmtDelete.executeUpdate("DELETE FROM tickets WHERE ticket_id = '" + ticketId + "'");
	            	 // Check if waitinglist exists
	    			ResultSet waitinglistResult = stmtCheck.executeQuery("SELECT username FROM waitinglist WHERE airline_id = '" + airlineId + "' AND flight_num = '" + flightNum + "'");
	            	
	            	while (waitinglistResult.next()){
	            		String waitinglistUsername = waitinglistResult.getString("username");
	            		
	            		stmtAlert.executeUpdate("UPDATE waitinglist SET waitlistAlert = true WHERE username = '" + waitinglistUsername + "' AND airline_id = '" + airlineId + "' AND flight_num = '" + flightNum + "'");
	            	
	            	} response.sendRedirect("CancelSuccessPage.jsp");
	         	} else {
	            	 response.sendRedirect("CancelFailPage.jsp");
	             }
			}
			db.closeConnection(con);
		}
	} catch (Exception e){
			out.print(e);
		}
	
%>	
		<form action = "CustomerLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>  