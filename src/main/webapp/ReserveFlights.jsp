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
    
    String username = (String) session.getAttribute("user");
    String airlineIds = request.getParameter("airlineIDs");
    String flightNums = request.getParameter("flightNums");
    String flightClass = request.getParameter("flightClass");
  
    //Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
    
    if(airlineIds.isEmpty() || flightNums.isEmpty() || flightClass.isEmpty()){
    
    	out.print("Please fill out all fields.");

    } else {
    	String[] airlineIdsArray = airlineIds.split(";");
        String[] flightNumsArray = flightNums.split(";");
        
        if (airlineIdsArray.length != flightNumsArray.length) {
        	
       		out.print("Invalid input. Number of airline IDs and flight numbers must match");
        	
        } else {
        	
					
        	String str = "INSERT INTO tickets (username, purchase_datetime, total_fare, class, passenger_fname, passenger_lname) VALUES (?, ?, ?, ?, ?, ?)";
        	String str2=  "UPDATE flight SET seats_remaining = seats_remaining - 1 WHERE airline_id = ? AND flight_num = ? and seats_remaining > 0"; 
            PreparedStatement pStmt = con.prepareStatement(str);
            PreparedStatement pStmt2 = con.prepareStatement(str2);
            PreparedStatement pStmt3 = con.prepareStatement("INSERT INTO ticket_flights(ticket_id, flight_num, airline_id, seat_number) VALUES (?, ?, ?, ?)");
         
                 for (int i = 0; i < airlineIdsArray.length; i++) {
                    String airlineId = airlineIdsArray[i].trim();
                    String flightNum = flightNumsArray[i].trim();
                    
                    ResultSet rs2 = stmt.executeQuery("SELECT firstname, lastname FROM customer WHERE username='" + username +"'");
        			rs2.next();
        			String firstname = rs2.getString("firstname");
        			String lastname = rs2.getString("lastname");
        			ResultSet rs3 = stmt.executeQuery("SELECT economy_rate, seats_remaining FROM flight WHERE flight_num='" + flightNum + "' AND airline_id='" + airlineId + "'"); //need attribute name for seats available
        			rs3.next();
        			float total_rate = rs3.getFloat("economy_rate");
					 
                   // Check if there are seats available
                   	String checkSeats = "SELECT seats_remaining FROM flight WHERE airline_id = ? AND flight_num = ?";
                   	PreparedStatement checkSeatsStmt = con.prepareStatement(checkSeats);
                  	checkSeatsStmt.setString(1, airlineId);
                	checkSeatsStmt.setString(2, flightNum);
                	ResultSet result = checkSeatsStmt.executeQuery();
                  	 
                  	// If seats available, make reservation and update seats_remaining
                  	if(result.next() && result.getInt("seats_remaining") > 0){
                  		pStmt.setString(1, username);
        				pStmt.setTimestamp(2, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
        				if (flightClass.equals("Business")){ 
        					total_rate += 100;
        				} else if (flightClass.equals("First")){ 
        					total_rate += 200;
        				}
        				pStmt.setFloat(3, total_rate);
        				pStmt.setString(4, flightClass);
        				pStmt.setString(5, firstname);
        				pStmt.setString(6, lastname);
        				pStmt.executeUpdate();
        				
        				ResultSet rs4 = stmt.executeQuery("SELECT ticket_id FROM tickets WHERE username='" + username + "' ORDER BY ticket_id DESC");
        				rs4.next();
        				int ticket_id = rs4.getInt("ticket_id");
        				
        			
        				pStmt3.setInt(1, ticket_id);
        				pStmt3.setString(2, flightNum);
        				pStmt3.setString(3, airlineId);
        				pStmt3.setInt(4, result.getInt("seats_remaining"));
        				pStmt3.executeUpdate();
                  		 
                  		pStmt2.setString(1, airlineId);
                  		pStmt2.setString(2, flightNum);
                  		pStmt2.executeUpdate();
                  	
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
                   				out.print("Tickets reserved successfully!");
                    	}
                  	} else {
                  		session.setAttribute("airlineID", airlineId);
                  		session.setAttribute("flightNum", flightNum);
                        response.sendRedirect("JoinWaitlist.jsp");
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
    