<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CS Rep Add Aircraft</title>
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

        String addAircraftQuery = "INSERT INTO aircraft (aircraft_id, seats, airline_id) VALUES (?, ?, ?)";

        try (PreparedStatement pstmt = con.prepareStatement(addAircraftQuery)) {
            pstmt.setString(1, aircraftId);
            pstmt.setInt(2, seats);
            pstmt.setString(3, airlineId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p>Aircraft added successfully!</p>");
            } else {
                out.println("<p>Error adding aircraft. Please try again.</p>");
            }
        }

        db.closeConnection(con);
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>

<h1>CS Rep Add Aircraft</h1>

<form action="" method="post">
    <label for="aircraftId">Aircraft ID:</label>
    <input type="text" name="aircraftId" required><br>

    <label for="seats">Number of Seats:</label>
    <input type="number" name="seats" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" name="airlineId" required><br>

    <input type="submit" value="Add Aircraft">
</form>

<a href="CSRepManageAircrafts.jsp">Go Back</a>

</body>
</html>
