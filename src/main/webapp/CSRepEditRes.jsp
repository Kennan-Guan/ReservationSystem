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
		String ticket_id = request.getParameter("ticketID");
		String edit_type = request.getParameter("editType"); 
		String new_info = request.getParameter("newInfo");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
		ResultSet ticket_details = stmt.executeQuery("SELECT * FROM tickets WHERE ticket_id=" + ticket_id);
	    
		
		if (ticket_id.equals("") || edit_type == null || new_info.equals("") || !ticket_details.next()) {
			out.print("Invalid ticket ID or empty field detected. Make sure all fields are filled out and valid!");
		} else {
			if (edit_type.equals("transfer")) {
				ResultSet user_details = stmt.executeQuery("SELECT firstname, lastname FROM customer WHERE username='" + new_info + "'");
				if(user_details.next()){
					stmt.executeUpdate("UPDATE tickets SET username='" + new_info + "', " + 
										"passenger_fname='" + user_details.getString("firstname") + "', " +
										"passenger_lname='" + user_details.getString("lastname") + "' " + 
										"WHERE ticket_id=" + ticket_id);
					out.print("Transfer Successful!");
				} else {
					out.print("Invalid username. Make sure the inputted customer has an account!");
				}
				
			} else if (edit_type.equals("upgrade")){
				ResultSet current_class = stmt.executeQuery("SELECT class, total_fare FROM tickets WHERE ticket_id=" + ticket_id);
				current_class.next();
				float new_fare = current_class.getFloat("total_fare"); 
				
				if(current_class.getString("class").equals("Economy") && new_info.equalsIgnoreCase("Business")) {
					new_fare += 100;
					stmt.executeUpdate("UPDATE tickets SET class='Business', total_fare=" + new_fare +"WHERE ticket_id=" + ticket_id);
					out.print("Upgrade Successful!");
				} else if(current_class.getString("class").equals("Economy") && new_info.equalsIgnoreCase("First")) {
					new_fare += 200;
					stmt.executeUpdate("UPDATE tickets SET class='First', total_fare=" + new_fare +"WHERE ticket_id=" + ticket_id);
					out.print("Upgrade Successful!");
				} else if(current_class.getString("class").equals("Business") && new_info.equalsIgnoreCase("First")) {
					new_fare += 100;
					stmt.executeUpdate("UPDATE tickets SET class='First', total_fare=" + new_fare +"WHERE ticket_id=" + ticket_id);
					out.print("Upgrade Successful!");
				} else {
					out.print("Invalid Upgrade. Economy may upgrade to Business or First. Business may only upgrade to First");
				}
				
				
				
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