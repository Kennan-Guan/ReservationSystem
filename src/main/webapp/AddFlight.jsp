<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter, com.cs336.pkg.ApplicationDB" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CS Rep Add Flight</title>
</head>
<body>

<%
if (request.getMethod().equals("POST")) {
    try {
   
    	 String flightNum = request.getParameter("flightNum");
         String airlineId = request.getParameter("airlineId");
         boolean isDomestic = request.getParameter("isDomestic") != null;
         String aircraftId = request.getParameter("aircraftId");
         String departureAirportId = request.getParameter("departureAirportId");
         String arrivalAirportId = request.getParameter("arrivalAirportId");
         String departureTime = request.getParameter("departureTime");
         String arrivalTime = request.getParameter("arrivalTime");
   

         float economyRate = Float.parseFloat(request.getParameter("economyRate"));
         int seatsRemaining = Integer.parseInt(request.getParameter("seatsRemaining"));
         
      


        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        
        out.println("<p>flightNum: " + flightNum + "</p>");
        out.println("<p>airlineId: " + airlineId + "</p>");
        out.println("<p>isDomestic: " + isDomestic + "</p>");
        out.println("<p>aircraftId: " + aircraftId + "</p>");
        out.println("<p>departureAirportId: " + departureAirportId + "</p>");
        out.println("<p>departureTime: " + departureTime + "</p>");
        out.println("<p>arrivalAirportId: " + arrivalAirportId + "</p>");
        out.println("<p>arrivalTime: " + arrivalTime + "</p>");
        out.println("<p>economyRate: " + economyRate + "</p>");
        out.println("<p>seatsRemaining: " + seatsRemaining + "</p>");

        String checkAirlineQuery = "SELECT * FROM airline WHERE airline_id = ?";
        try (PreparedStatement checkAirlineStmt = con.prepareStatement(checkAirlineQuery)) {
            checkAirlineStmt.setString(1, airlineId);
            ResultSet checkAirlineResult = checkAirlineStmt.executeQuery();

            if (!checkAirlineResult.next()) {
                out.println("<p>Error: Airline with ID " + airlineId + " does not exist. Please provide a valid airline ID.</p>");
            } else {
                String checkAircraftQuery = "SELECT * FROM aircraft WHERE aircraft_id = ?";
                try (PreparedStatement checkAircraftStmt = con.prepareStatement(checkAircraftQuery)) {
                    checkAircraftStmt.setString(1, aircraftId);
                    ResultSet checkAircraftResult = checkAircraftStmt.executeQuery();

                    if (!checkAircraftResult.next()) {
                        out.println("<p>Error: Aircraft with ID " + aircraftId + " does not exist. Please provide a valid aircraft ID.</p>");
                    } else {
                        String addFlightQuery = "INSERT INTO flight (flight_num, airline_id, is_domestic, aircraft_id, departure_airport_id, departure_time, arrival_airport_id, arrival_time, economy_rate, seats_remaining) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                        try (PreparedStatement pstmt = con.prepareStatement(addFlightQuery)) {
                            pstmt.setString(1, flightNum);
                            pstmt.setString(2, airlineId);
                            pstmt.setBoolean(3, isDomestic);
                            pstmt.setString(4, aircraftId);
                            pstmt.setString(5, departureAirportId);
                            pstmt.setString(6, "2023-12-13 10:00:00");
                            pstmt.setString(7, arrivalAirportId);
                            pstmt.setString(8, "2023-12-14 10:00:00");
                            pstmt.setFloat(9, 100);
                            pstmt.setInt(10, 200);
                            out.println("<p>Executing SQL query: " + pstmt.toString() + "</p>");


                            int rowsAffected = pstmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("<p>Flight added successfully!</p>");
                            } else {
                                out.println("<p>Error adding flight. Please try again.</p>");
                            }
                        }
                    }
                }
            }
        }

        db.closeConnection(con);
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>

<h1>CS Rep Add Flight</h1>

<form action="" method="post">
    <label for="flightNum">Flight Number:</label>
    <input type="text" name="flightNum" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" name="airlineId" required><br>

    <label for="isDomestic">Is Domestic:</label>
    <input type="checkbox" name="isDomestic"><br>

    <label for="aircraftId">Aircraft ID:</label>
    <input type="text" name="aircraftId" required><br>

    <label for="departureAirportId">Departure Airport ID:</label>
    <input type="text" name="departureAirportId" required><br>

    <label for="departureTime">Departure Time:</label>
    <input type="text" name="departureTime" required><br>

    <label for="arrivalAirportId">Arrival Airport ID:</label>
    <input type="text" name="arrivalAirportId" required><br>

    <label for="arrivalTime">Arrival Time:</label>
    <input type="text" name="arrivalTime" required><br>

    <label for="economyRate">Economy Rate:</label>
    <input type="number" name="economyRate" step="0.01" required><br>

    <label for="seatsToAdd">Seats To Add:</label>
    <input type="number" name="seatsToAdd" required><br>

    <input type="submit" value="Add Flight">
</form>


<a href="CSRepManageFlights.jsp">Go Back</a>

</body>
</html>
