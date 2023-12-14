<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Join Waitlist</title>
</head>
<body>

<%
    try {
    // Grab parameters and username
    String username = (String) session.getAttribute("waitlistUser");
    String airlineId = (String) session.getAttribute("airlineId");
    String flightNum = (String) session.getAttribute("flightNum");
    
    //Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		
	//Create a SQL statement
	String str = "INSERT INTO waitinglist (username, airline_id, flight_num) VALUES (?, ?, ?)";
		PreparedStatement stmt = con.prepareStatement(str);
		stmt.setString(1, username);
		stmt.setString(2, airlineId);
		stmt.setString(3, flightNum);
	
		int success = stmt.executeUpdate();
	
			if (success > 0) {
        	out.print(username +" haas been added to the waitlist for the flight (Airline ID: " + airlineId + ", Flight Number:  " + flightNum + "). They will be notified if a seat becomes available.");
			}
		 db.closeConnection(con);
    } catch (Exception e) {
			out.print(e);
		}%>
		
		<form action = "CSRepLandingPage.jsp" method = "POST">
		<button type="submit">Return to Home Page</button>
		</form>
		
</body>
</html> 