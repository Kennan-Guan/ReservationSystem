<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Airport</title>
</head>
<body>

<%
try {
    if (request.getMethod().equals("POST")) {
        String airportId = request.getParameter("airportId");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Check if the airportId is not empty
        if (airportId != null && !airportId.isEmpty()) {
            // Delete airport
            String deleteAirportQuery = "DELETE FROM airport WHERE airport_id = ?";
            try (PreparedStatement deleteStmt = con.prepareStatement(deleteAirportQuery)) {
                deleteStmt.setString(1, airportId);
                deleteStmt.executeUpdate();
                out.print("Airport deleted successfully!");
            }
        } else {
            out.print("Airport ID cannot be empty.");
        }

        db.closeConnection(con);
    }
} catch (Exception e) {
    out.print(e);
}
%>

<form action="#" method="post">
    <label for="airportId">Airport ID:</label>
    <input type="text" name="airportId" required>
    <input type="submit" value="Delete Airport">
</form>

<form action="CSRepManageAirports.jsp">
    <input type="submit" value="Go To Manage Airports">
</form>

</body>
</html>
