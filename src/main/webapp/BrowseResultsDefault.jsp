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
		// accept userinputs from BrowseResults.jsp and stores them into variables
		String flightType = request.getParameter("tickerType");
		String dept_airport = request.getParameter("DepartingCode");
		String arr_airport = request.getParameter("ArrivingCode"); 
		String date = request.getParameter("FlightDate");
		String min_date = ("");
		String max_date = ("");
		Boolean flexible = true;
		String str = ("");
		String str2 = ("");
		// set up connection to database
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		
	    
		// check for empty inputs
		if (flightType == null || departingCode.equals("") || arrivingCode.equals("") || flightDate.equals("")) {
			out.print("Empty Field Detected. Make sure all fields are filled out!");
			//checking tickers, see if customer wants one way or two way, queries change depending
		} else if (flightType.equals("One Way Set Date")) {
			flexible = false;
			//writing some basic query, Jon feel free to replace with your query maker
			str = "SELECT * FROM flight f" +
				  "WHERE f.departure_airport_id = '" + departingCode + "' AND f.arrival_airport_id = '" + arrivingCode + "' AND " + whatever you want Jon "";
	
		} else if (flightType.equals("One Way Flex Date")) {
			//writing some basic query again
			str = "SELECT * FROM flight f" +
				  "WHERE f.departure_airport_id = '" + departingCode + "' AND f.arrival_airport_id = '" + arrivingCode + "' AND " + whatever you want Jon "";
			
		} else if (flightType.equals("Two Way Set Date")) {
			flexible = false;
			//writing 2 queries that you can replace with Jon's algo, one to produce table for way there and one for way back
			str = "SELECT * FROM flight f" +
				  "WHERE f.departure_airport_id = '" + departingCode + "' AND f.arrival_airport_id = '" + arrivingCode + "' AND " + whatever you want Jon "";
			str2 = "SELECT * FROM flight f" +
				   "WHERE f.departure_airport_id = '" + arrivingCode + "' AND f.arrival_airport_id = '" + departingCode + "' AND " + whatever you want Jon "";		
					
		} else if (flightType.equals("Two Way Flex Date")) {
			//writing some basic queries again
			str = "SELECT * FROM flight f" +
				  "WHERE f.departure_airport_id = '" + departingCode + "' AND f.arrival_airport_id = '" + arrivingCode + "' AND " + whatever you want Jon "";
			str2 = "SELECT * FROM flight f" +
				   "WHERE f.departure_airport_id = '" + arrivingCode + "' AND f.arrival_airport_id = '" + departingCode + "' AND " + whatever you want Jon "";
		}
		
		if (flexible){
			min_date = date.minusDays(3);
            max_date = date.plusDays(4);
		} else {
			min_date = date;
            max_date = date.plusDays(1);
		}
		
		ResultSet result = stmt.executeQuery(str);
		
		// NEED TO ADD TABLE, AND IF STATEMENT FOR SECOND TABLE IF TWO WAY SELECTED
		
		
		
		con.close();

		
	} catch(Exception e){
		out.print(e);
	}
	
	
%>
</body>
</html> 