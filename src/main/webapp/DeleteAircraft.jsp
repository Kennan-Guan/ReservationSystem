<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CS Rep Delete Aircraft</title>
</head>
<body>

<%
if (request.getMethod().equals("POST")) {
    try {
        String aircraftId = request.getParameter("aircraftId");
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
                // Airline exists, proceed to delete the aircraft
                String deleteAircraftQuery = "DELETE FROM aircraft WHERE aircraft_id = ? AND airline_id = ?";
                try (PreparedStatement deleteAircraftStmt = con.prepareStatement(deleteAircraftQuery)) {
                    deleteAircraftStmt.setString(1, aircraftId);
                    deleteAircraftStmt.setString(2, airlineId);

                    int rowsAffected = deleteAircraftStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p>Aircraft deleted successfully!</p>");
                    } else {
                        out.println("<p>Error deleting aircraft. Please check the provided details and try again.</p>");
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

<h1>CS Rep Delete Aircraft</h1>

<form action="" method="post">
    <label for="aircraftId">Aircraft ID:</label>
    <input type="text" name="aircraftId" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" name="airlineId" required><br>

    <input type="submit" value="Delete Aircraft">
</form>

<a href="CSRepManageAircrafts.jsp">Go Back</a>

</body>
</html>
