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
		String username = request.getParameter("username");
		String airline_id = request.getParameter("airlineIDs"); 
		String flight_num = request.getParameter("flightNums");
		String seat_class = request.getParameter("class");

	    
		if (username.equals("") || airline_id.equals("") || flight_num.equals("") || seat_class == null) {
			out.print("Empty field detected. Make sure all fields are filled in!");
		} else {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rs1 = stmt.executeQuery("SELECT seats_remaining FROM flight WHERE flight_num='" + flight_num + "' AND airline_id='" + airline_id + "'");
			rs1.next();
			int seats_remaining = rs1.getInt("seats_remaining");
			if (seats_remaining > 0) { 
				ResultSet rs2 = stmt.executeQuery("SELECT economy_rate, seats_remaining FROM flight WHERE flight_num='" + flight_num + "' AND airline_id='" + airline_id + "'"); //need attribute name for seats available
				rs2.next();
				PreparedStatement ps = con.prepareStatement("INSERT INTO tickets(username, purchase_datetime, total_fare, class) VALUES (?, ?, ?, ?)");
						
				ps.setString(1, username);
				ps.setTimestamp(2, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
				float total_rate = rs2.getFloat("economy_rate");
				if (seat_class.equals("business")){ 
					total_rate += 100;
				} else if (seat_class.equals("first")){ 
					total_rate += 200;
				}
				ps.setFloat(3, total_rate);
				ps.setString(4, seat_class);
				ps.executeUpdate();
			
			
				ResultSet rs3 = stmt.executeQuery("SELECT ticket_id FROM tickets WHERE username='" + username + "' ORDER BY ticket_id DESC");
				rs3.next();
				int ticket_id = rs3.getInt("ticket_id");
				ps = con.prepareStatement("INSERT INTO ticket_flights(ticket_id, flight_num, airline_id, seat_number) VALUES (?, ?, ?, ?)");
				ps.setInt(1, ticket_id);
				ps.setString(2, flight_num);
				ps.setString(3, airline_id);
				ps.setInt(4, seats_remaining);
				ps.executeUpdate();
				
				
				stmt.executeUpdate("UPDATE flight SET seats_remaining=" + (seats_remaining - 1) + " WHERE flight_num='" + flight_num + "' AND airline_id='" + airline_id + "'");
				out.print("Reservation Confirmed!");
			} else {
				out.print("No more seats available!");
			}
		
			
			
			con.close();
		}

		
	} catch(Exception e){
		out.print(e);
		out.print("<br>Reservation Failed");
	}
	
	
%>
		<form action = "CSRepLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		</form><br>	
</body>
</html>