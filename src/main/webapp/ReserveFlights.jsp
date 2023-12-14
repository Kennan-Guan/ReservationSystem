<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserve Flights</title>
</head>
<body>

<%
    try {
    
    String airlineIds = request.getParameter(airlineIds);
    String flightNums = request.getParameter(flightNums);
    String flightClass = request.getParameter(flightClass);
  
    //Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
    
    if(airlineIds.isEmpty() || flightNums.isEmpty() || flightClass.isEmpty()){
%>    
    <p> Please fill out all fields. </p>
<%   
    } else {
    	String[] airlineIdsArray = airlineIds.split(";");
        String[] flightNumsArray = flightNums.split(";");
        
        if (airlineIdsArray.length != flightNumsArray.length) {
        	%>
        	                    <p>Invalid input. Number of airline IDs and flight numbers must match.</p>
        	<%
        } else {
        	 String str = "INSERT INTO tickets (airline_id, flight_num, flightClass) VALUES (?, ?, ?)";
        	 String str2=  "UPDATE flight SET seats_remaining = seats_remaining - 1 WHERE airline_id = ? AND flight_num = ? and seats_remaining > 0";
             try (PreparedStatement stmt = con.prepareStatement(str);
            	  PreparedStatement stmt2 = con.prepareStatement(str2)) {
         
                 for (int i = 0; i < airlineIdsArray.length; i++) {
                     String airlineId = airlineIdsArray[i].trim();
                     String flightNum = flightNumsArray[i].trim();
					 
                     // Check if there are seats available
                     String checkSeats = "SELECT seats_remaining FROM flight WHERE airline_id = ? AND flight_num = ?";
                     try (PreparedStatement checkSeatsStmt = con.prepareStatement(checkSeats)){
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
                    	 } else {
                    		 // Seats not available, send to JoinWaitlist.jsp          		 
%>
                             <p>The flight you requested (Airline ID: <%= airlineId %>, Flight Number: <%= flightNum %>) is currently full.</p>
                             <form action="JoinWaitlist.jsp" method="POST">
                                 <input type="hidden" name="airlineId" value="<%= airlineId %>">
                                 <input type="hidden" name="flightNum" value="<%= flightNum %>">
                                 <input type="submit" value="Join Waitlist">
                             </form>
                             
                             <form action = "CustomerLandingPage.jsp" method = "POST">
							<button type="submit">Return to Home Page</button>
							</form>
<%
                    	 }
                     }
                 }

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
                	 PreparedStatement checkWaitlistStmt = connection.prepareStatement(checkWaitlist);
                	        for (int i = 0; i < airlineIdArray.length; i++) {
                	            String airlineId = airlineIdArray[i].trim();
                	            String flightNum = flightNumArray[i].trim();

                	            checkWaitlistStmt.setString(1, airlineId);
                	            checkWaitlistStmt.setString(2, flightNum);
                	            ResultSet waitlistResult = checkWaitlistStmt.executeQuery();

                	            while (waitlistResult.next()) {
                	                String waitlistUsername = waitlistResult.getString("username");

                	                // Remove the user from the waitlist for the specific flight
                	                String removeFromWaitlistQuery = "DELETE FROM waitinglist WHERE username = ? AND airline_id = ? AND flight_num = ?";
                	                PreparedStatement removeFromWaitlistStatement = connection.prepareStatement(removeFromWaitlistQuery);
                	                removeFromWaitlistStatement.setString(1, waitlistUsername);
                	                removeFromWaitlistStatement.setString(2, airlineId);
                	                removeFromWaitlistStatement.setString(3, flightNum);

                	                removeFromWaitlistStatement.executeUpdate();
%>
                     <p>Tickets reserved successfully!</p>
<%
                 } else {
%>
                     <p>Failed to reserve one or more tickets. Please check your input and try again.</p>

                 <%}
             }
        } 
    } db.closeConnection(con);
    } catch (Exception e) {
		out.print(e); %>
	
       
		<br/>
		<form action = "CustomerLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		
		
		</form><br>

</body>
</html> 
    