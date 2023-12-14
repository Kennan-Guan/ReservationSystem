<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Airport</title>
</head>
<body>

<%
try {
    if (request.getMethod().equals("POST")) {
        String oldAirportId = request.getParameter("oldAirportId");
        String newAirportId = request.getParameter("newAirportId");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        if (oldAirportId != null && !oldAirportId.isEmpty() && newAirportId != null && !newAirportId.isEmpty()) {
            // Update airport
            String updateAirportQuery = "UPDATE airport SET airport_id = ? WHERE airport_id = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateAirportQuery)) {
                updateStmt.setString(1, newAirportId);
                updateStmt.setString(2, oldAirportId);
                updateStmt.executeUpdate();
                out.print("Airport updated successfully!");
            }
        } else {
            out.print("Airport IDs cannot be empty.");
        }

        db.closeConnection(con);
    }
} catch (Exception e) {
    out.print(e);
}
%>

<form action="#" method="post">
    <label for="oldAirportId">Old Airport ID:</label>
    <input type="text" name="oldAirportId" required><br>
    <label for="newAirportId">New Airport ID:</label>
    <input type="text" name="newAirportId" required><br>
    <input type="submit" value="Click to confirm for Edit Airport">
</form>
<form action="CSRepManageAirports.jsp">
    <input type="submit" value="Go To Manage Airports">
</form>


</body>
</html>
