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
		String ticket_num = request.getParameter("ticketNum");
		String edit_type = request.getParameter("editType"); 
		String new_info = request.getParameter("newInfo");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
	    
		
		if (ticket_num.equals("") || edit_type == null || new_info.equals("")) {
			out.print("Empty Field Detected. Make sure all fields are filled out!");
		} else {
			if (edit_type.equals("airlineIDs")) {
				stmt.executeUpdate("UPDATE ticket_flights SET airline_id='" + new_info + "' WHERE ticket_id=" + ticket_num + "");
			} else if (edit_type.equals("flightNums")) {
				stmt.executeUpdate("UPDATE ticket_flights SET flight_num='" + new_info + "' WHERE ticket_id=" + ticket_num + "");
			} else if (edit_type.equals("flightClass")){
				stmt.executeUpdate("UPDATE tickets SET class='" + new_info + " 'WHERE ticket_id=" + ticket_num + "");
			}
		}
		
		con.close();

		
	} catch(Exception e){
		out.print(e);
		out.print("<br>Update Failed");
	}
	
	
%>
		<form action = "CSRepLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>