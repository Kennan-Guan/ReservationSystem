<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CS Rep Edit Aircraft</title>
</head>
<body>

<%
if (request.getMethod().equals("POST")) {
    try {
        String aircraftId = request.getParameter("aircraftId");
        int seats = Integer.parseInt(request.getParameter("seats"));
        String airlineId = request.getParameter("airlineId");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Check if the airline exists
        String checkAirlineQuery = "SELECT * FROM airline WHERE airline_id = ?";
        try (PreparedStatement checkAirlineStmt = con.prepareStatement(checkAirlineQuery)) {
            checkAirlineStmt.setString(1, airlineId);
            ResultSet checkAirlineResult = checkAirlineStmt.executeQuery();

            if (!checkAirlineResult.next()) {
                // Airline does not exist, display an error message
                out.println("<p>Error: Airline with ID " + airlineId + " does not exist. Please provide a valid airline ID.</p>");
            } else {
                // Airline exists, proceed to update the aircraft
                String updateAircraftQuery = "UPDATE aircraft SET seats = ? WHERE aircraft_id = ? AND airline_id = ?";
                try (PreparedStatement updateAircraftStmt = con.prepareStatement(updateAircraftQuery)) {
                    updateAircraftStmt.setInt(1, seats);
                    updateAircraftStmt.setString(2, aircraftId);
                    updateAircraftStmt.setString(3, airlineId);

                    int rowsAffected = updateAircraftStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p>Aircraft updated successfully!</p>");
                    } else {
                        out.println("<p>Error updating aircraft. Please check the provided details and try again.</p>");
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

<h1>CS Rep Edit Aircraft</h1>

<form action="" method="post">
    <label for="aircraftId">Aircraft ID:</label>
    <input type="text" name="aircraftId" required><br>

    <label for="seats">New Number of Seats:</label>
    <input type="number" name="seats" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" name="airlineId" required><br>

    <input type="submit" value="Edit Aircraft">
</form>

<a href="CSRepManageAircrafts.jsp">Go Back</a>

</body>
</html>
