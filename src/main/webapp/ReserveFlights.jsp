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
    
    String airlineIds = request.getParameter(airlineIDs);
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
             try (PreparedStatement stmt = con.prepareStatement(str)) {
                 for (int i = 0; i < airlineIdsArray.length; i++) {
                     stmt.setString(1, airlineIdsArray[i].trim());
                     stmt.setString(2, flightNumsArray[i].trim());
                     stmt.setString(3, flightClass);

                     stmt.addBatch();
                 }

                 int[] addRows = stmt.executeBatch();

                 // Check if all rows were inserted successfully
                 boolean allInserted = true;
                 for (int row : addRows) {
                     if (row <= 0) {
                         allInserted = false;
                         break;
                     }
                 }

                 if (allInserted) {
%>
                     <p>Tickets reserved successfully!</p>
<%
                 } else {
%>
                     <p>Failed to reserve one or more tickets. Please check your input and try again.</p>
<%
                 }
             } db.closeConnection(con);
        } 
        
		<br/>
		<form action = "CustomerLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		
		
		</form><br>
		</form>
        	
        } 
    } catch (Exception e){
		out.print(e);
	}

%>	

</body>
</html> 
    