<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs336.pkg.*, java.io.*, java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Customer Chat Page</title>
</head>
<body>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    // Retrieve the username from session attribute
    String username = (String) session.getAttribute("user");

    // Query to get customer's questions
    String questionsQuery = "SELECT cm.text, cm.date_time_sent " +
                           "FROM chat_message cm " +
                           "JOIN chat_association ca ON cm.sender_id = ca.customer_username " +
                           "WHERE ca.customer_username = ? " +
                           "ORDER BY cm.date_time_sent DESC";

    try (PreparedStatement pstmt = con.prepareStatement(questionsQuery)) {
        pstmt.setString(1, username);
        ResultSet questionsResult = pstmt.executeQuery();
%>

<h1>Customer Chat Page</h1>

<h2>Your Questions:</h2>

<%
        // Parse out the results
        while (questionsResult.next()) {
            String questionText = questionsResult.getString("text");
            String dateTimeSent = questionsResult.getString("date_time_sent");
%>

<div>
    <%= "Question: " + questionText %><br>
    <%= "Time: " + dateTimeSent %><br>
</div>
<hr>

<%
        }

        // Query to get messages for the customer
        String messagesQuery = "SELECT DISTINCT cm.message_id, cm.sender_id, cm.text, cm.date_time_sent " +
                               "FROM chat_message cm " +
                               "JOIN chat_association ca ON cm.sender_id = ca.rep_username " +
                               "WHERE (ca.customer_username = ? AND cm.sender_id = ?) OR (cm.sender_id = ? AND ca.customer_username = ?) " +
                               "ORDER BY cm.date_time_sent DESC";

        try (PreparedStatement pstmtMessages = con.prepareStatement(messagesQuery)) {
            pstmtMessages.setString(1, username);
            pstmtMessages.setString(2, username);
            pstmtMessages.setString(3, username);
            pstmtMessages.setString(4, username);
            ResultSet messagesResult = pstmtMessages.executeQuery();
    %>

    <h2>Replies from the Customer Service Representative:</h2>

    <table border="1">
        <tr>
            <th>Customer Name</th>
            <th>Date/Time Sent</th>
            <th>Message Text</th>
        </tr>
        <%
            // Parse out the results for replies
            while (messagesResult.next()) {
        %>
                <tr>
                    <td><%= messagesResult.getString("sender_id") %></td>
                    <td><%= messagesResult.getString("date_time_sent") %></td>
                    <td><%= messagesResult.getString("text") %></td>
                </tr>
        <%
            }
        }
        // Close the connection
        db.closeConnection(con);
    %>
    </table>

    <form action="ReplyToCustomerRep.jsp" method="POST">
        <label for="Rep">Enter name of Customer Rep you want to reply to:</label>
        <input type="text" name="Rep"/>
        <input type="submit" value="Reply">
    </form>
    <br>

    <form action="StartChat.jsp" method="POST">
        <label for="newMessage">I would like to send a New Message:</label>
        <input type="submit" value="Click to Send a Message!">
    </form>
    <br>
    <form action="CustomerLandingPage.jsp" method="GET">
        <input type="submit" name="Home" value="Return Home">
    </form>

<%}
} catch (Exception e) {
    out.print(e);
}
%>

</body>
</html>
