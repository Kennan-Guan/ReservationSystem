<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reserve Flights</title>
</head>
<body>

<%
    try {
    
    String airlineIds = request.getParameter("airlineIDs");
    String flightNums = request.getParameter("flightNums");
    String flightClass = request.getParameter("flightClass");
  
    //Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
    
    if(airlineIds.isEmpty() || flightNums.isEmpty() || flightClass.isEmpty()){
    
    	out.print("Please fill out all fields.");

    } else {
    	String[] airlineIdsArray = airlineIds.split(";");
        String[] flightNumsArray = flightNums.split(";");
        
        if (airlineIdsArray.length != flightNumsArray.length) {
        	
       		out.print("Invalid input. Number of airline IDs and flight numbers must match");
        	
        } else {
        	String str = "INSERT INTO tickets (airline_id, flight_num, flightClass) VALUES (?, ?, ?)";
        	String str2=  "UPDATE flight SET seats_remaining = seats_remaining - 1 WHERE airline_id = ? AND flight_num = ? and seats_remaining > 0";
            PreparedStatement stmt = con.prepareStatement(str);
            PreparedStatement stmt2 = con.prepareStatement(str2);
         
                 for (int i = 0; i < airlineIdsArray.length; i++) {
                    String airlineId = airlineIdsArray[i].trim();
                    String flightNum = flightNumsArray[i].trim();
					 
                   // Check if there are seats available
                   	String checkSeats = "SELECT seats_remaining FROM flight WHERE airline_id = ? AND flight_num = ?";
                   	PreparedStatement checkSeatsStmt = con.prepareStatement(checkSeats);
                  	checkSeatsStmt.setString(1, airlineId);
                	checkSeatsStmt.setString(2, flightNum);
                	ResultSet result = checkSeatsStmt.executeQuery();
                  	 
                  	// If seats available, make reservation and update seats_remaining
                  	if(result.next() && result.getInt("seats_remaining") > 0){
                  		stmt.setString(1, airlineId);
                  		stmt.setString(2, flightNum);
                  		stmt.setString(3, flightClass);
                  		stmt.addBatch();
                  		 
                  		stmt2.setString(1, airlineId);
                  		stmt2.setString(2, flightNum);
                  		stmt2.addBatch();
                  		
                  		int[] addRows = stmt.executeBatch();
                        int[] updateRows = stmt2.executeBatch();

                        // Check if all rows were inserted successfully
                        boolean inserted = true;
                        boolean updated = true;
                        for (int row : addRows) {
                            if (row <= 0) {
                                inserted = false;
                                break;
                            }
                        }
                        for (int row : updateRows){
	                       	 if (row <= 0){
	                       		 updated = false;
	                       		 break;
	                       	 }
                        }

                        if (inserted && updated) {
	                       	 String checkWaitlist = "SELECT username FROM waitinglist WHERE airline_id = ? AND flight_num = ?";
	                       	 PreparedStatement checkWaitlistStmt = con.prepareStatement(checkWaitlist);
	
              	            checkWaitlistStmt.setString(1, airlineId);
              	            checkWaitlistStmt.setString(2, flightNum);
              	            ResultSet waitlistResult = checkWaitlistStmt.executeQuery();

              	            while (waitlistResult.next()) {
              	                String waitlistUsername = waitlistResult.getString("username");

              	                // Remove the user from the waitlist for the specific flight
              	                String removeFromWaitlistQuery = "DELETE FROM waitinglist WHERE username = ? AND airline_id = ? AND flight_num = ?";
              	                PreparedStatement removeFromWaitlistStatement = con.prepareStatement(removeFromWaitlistQuery);
              	                removeFromWaitlistStatement.setString(1, waitlistUsername);
              	                removeFromWaitlistStatement.setString(2, airlineId);
              	                removeFromWaitlistStatement.setString(3, flightNum);

              	                removeFromWaitlistStatement.executeUpdate();
                    	     }
                   				out.print("Tickets reserved successfully!");
                    	} else {
                           out.print("Failed to reserve one or more tickets. Please check your input and try again.");
                        	} 
                  	} else {
                  		session.setAttribute("airlineID", airlineId);
                  		session.setAttribute("flightNum", flightNum);
                        response.sendRedirect("ReserveFlightsRedirect.jsp");
                  	}
                 }
        }
    }
                 
   	db.closeConnection(con);
  } catch (Exception e) {
		out.print(e); 
	}
		
%>
	
       
		<br/>
		<form action = "CustomerLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		
		
		</form><br>

</body>
</html> 
    