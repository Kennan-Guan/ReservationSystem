<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CS Rep Edit Flight</title>
</head>
<body>

<%
if (request.getMethod().equals("POST")) {
    try {
        String flightNum = request.getParameter("flightNum");
        String airlineId = request.getParameter("airlineId");
        double economyRate = Double.parseDouble(request.getParameter("economyRate"));
        int seatsRemaining = Integer.parseInt(request.getParameter("seatsRemaining"));
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String checkAirlineQuery = "SELECT * FROM airline WHERE airline_id = ?";
        try (PreparedStatement checkAirlineStmt = con.prepareStatement(checkAirlineQuery)) {
            checkAirlineStmt.setString(1, airlineId);
            ResultSet checkAirlineResult = checkAirlineStmt.executeQuery();

            if (!checkAirlineResult.next()) {
                out.println("<p>Error: Airline with ID " + airlineId + " does not exist. Please provide a valid airline ID.</p>");
            } else {
                String updateFlightQuery = "UPDATE flight SET economy_rate=?, seats_remaining=?, departure_time=?, arrival_time=? " +
                                           "WHERE flight_num=? AND airline_id=?";
                try (PreparedStatement updateFlightStmt = con.prepareStatement(updateFlightQuery)) {
                    updateFlightStmt.setDouble(1, economyRate);
                    updateFlightStmt.setInt(2, seatsRemaining);
                    updateFlightStmt.setString(3, departureTime);
                    updateFlightStmt.setString(4, arrivalTime);
                    updateFlightStmt.setString(5, flightNum);
                    updateFlightStmt.setString(6, airlineId);

                    int rowsAffected = updateFlightStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p>Flight updated successfully!</p>");
                    } else {
                        out.println("<p>Error updating flight. Please check the provided details and try again.</p>");
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

<h1>CS Rep Edit Flight</h1>

<form action="" method="post">
    <label for="flightNum">Flight Number:</label>
    <input type="text" name="flightNum" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" name="airlineId" required><br>

    <label for="economyRate">New Economy Rate:</label>
    <input type="number" step="0.01" name="economyRate" required><br>

    <label for="seatsRemaining">New Seats Remaining:</label>
    <input type="number" name="seatsRemaining" required><br>

    <label for="departureTime">New Departure Time:</label>
    <input type="datetime-local" name="departureTime" required><br>

    <label for="arrivalTime">New Arrival Time:</label>
    <input type="datetime-local" name="arrivalTime" required><br>

    <input type="submit" value="Edit Flight">
</form>

<a href="CSRepManageFlights.jsp">Go Back</a>

</body>
</html>
