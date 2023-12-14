<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CS Rep Delete Flight</title>
</head>
<body>

<%
if (request.getMethod().equals("POST")) {
    try {
        String flightNum = request.getParameter("flightNum");
        String airlineId = request.getParameter("airlineId");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String checkFlightQuery = "SELECT * FROM flight WHERE flight_num=? AND airline_id=?";
        try (PreparedStatement checkFlightStmt = con.prepareStatement(checkFlightQuery)) {
            checkFlightStmt.setString(1, flightNum);
            checkFlightStmt.setString(2, airlineId);
            ResultSet checkFlightResult = checkFlightStmt.executeQuery();

            if (!checkFlightResult.next()) {
                out.println("<p>Error: Flight with Number " + flightNum + " and Airline ID " + airlineId + " does not exist. Please provide valid details.</p>");
            } else {
                String deleteFlightQuery = "DELETE FROM flight WHERE flight_num=? AND airline_id=?";
                try (PreparedStatement deleteFlightStmt = con.prepareStatement(deleteFlightQuery)) {
                    deleteFlightStmt.setString(1, flightNum);
                    deleteFlightStmt.setString(2, airlineId);

                    int rowsAffected = deleteFlightStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p>Flight deleted successfully!</p>");
                    } else {
                        out.println("<p>Error deleting flight. Please check the provided details and try again.</p>");
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

<h1>CS Rep Delete Flight</h1>

<form action="" method="post">
    <label for="flightNum">Flight Number:</label>
    <input type="text" name="flightNum" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" name="airlineId" required><br>

    <input type="submit" value="Delete Flight">
</form>

<a href="CSRepManageFlights.jsp">Go Back</a>

</body>
</html>
