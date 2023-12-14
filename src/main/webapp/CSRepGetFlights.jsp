<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Airports</title>
</head>
<body>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    String airportsQuery = "SELECT airport_id FROM airport";
    try (PreparedStatement airportsStmt = con.prepareStatement(airportsQuery)) {
        ResultSet airportsResult = airportsStmt.executeQuery();
%>

<form action="#" method="get">
    <label for="airportId">Select Airport:</label>
    <select name="airportId" id="airportId">
        <% 
        String selectedAirportId = request.getParameter("airportId");
        while (airportsResult.next()) { 
            String airportIdValue = airportsResult.getString("airport_id");
        %>
            <option value="<%= airportIdValue %>" 
                <% if (airportIdValue.equals(selectedAirportId)) { %>
                    selected="selected"
                <% } %>
            >
                <%= airportIdValue %>
            </option>
        <% } %>
    </select>
    <input type="submit" value="Submit">
</form>



<%
    }
    
    String airportId = request.getParameter("airportId");

    if (airportId != null && !airportId.isEmpty()) {
        String departingFlightsQuery = "SELECT flight_num, airline_id, departure_time, arrival_airport_id, arrival_time FROM flight WHERE departure_airport_id = ?";
        try (PreparedStatement departingStmt = con.prepareStatement(departingFlightsQuery)) {
            departingStmt.setString(1, airportId);
            ResultSet departingResult = departingStmt.executeQuery();
%>

            <h2>Departing Flights from Airport <%= airportId %></h2>
            <table border="1">
                <tr>
                    <th>Flight Number</th>
                    <th>Airline ID</th>
                    <th>Departure Time</th>
                    <th>Arrival Airport</th>
                    <th>Arrival Time</th>
                    
                </tr>
                <% while (departingResult.next()) { %>
                    <tr>
                        <td><%= departingResult.getString("flight_num") %></td>
                        <td><%= departingResult.getString("airline_id") %></td>
                        <td><%= departingResult.getString("departure_time") %></td>
                        <td><%= departingResult.getString("arrival_airport_id") %></td>
                        <td><%= departingResult.getString("arrival_time") %></td>
                    </tr>
                <% } %>
            </table>

<%
        }

        String arrivingFlightsQuery = "SELECT flight_num, airline_id, arrival_time, departure_airport_id, departure_time FROM flight WHERE arrival_airport_id = ?";
        try (PreparedStatement arrivingStmt = con.prepareStatement(arrivingFlightsQuery)) {
            arrivingStmt.setString(1, airportId);
            ResultSet arrivingResult = arrivingStmt.executeQuery();
%>

            <h2>Arriving Flights at Airport <%= airportId %></h2>
            <table border="1">
                <tr>
                    <th>Flight Number</th>
                    <th>Airline ID</th>
                    <th>Arrival Time</th>
                    <th>Departure Airport</th>
                    <th>Departure Time</th>
                </tr>
                <% while (arrivingResult.next()) { %>
                    <tr>
                        <td><%= arrivingResult.getString("flight_num") %></td>
                        <td><%= arrivingResult.getString("airline_id") %></td>
                        <td><%= arrivingResult.getString("arrival_time") %></td>
                        <td><%= arrivingResult.getString("departure_airport_id") %></td>
                        <td><%= arrivingResult.getString("departure_time") %></td>
                    </tr>
                <% } %>
            </table>

<%
        }
    }

    db.closeConnection(con);

} catch (Exception e) {
    out.print(e);
}
%>

<form action="CSRepLandingPage.jsp">
    <input type="submit" value="Go Home">
</form>

</body>
</html>
