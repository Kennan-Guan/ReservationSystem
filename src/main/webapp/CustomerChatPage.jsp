<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>

<!-- NOTE: NEED TO HAVE FUNCTIONALITY SO THAT IF THE MOST RECENT CHAT WAS SENT BY THE CUSTOMER, THE RESPONDED FIELD IN THE TABLE IS N, 
ELSE HAVE IT BE Y -->
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
 
    // Query to get messages for the customer
    String messagesQuery = "SELECT DISTINCT cm.message_id, cm.sender_id, cm.text, cm.date_time_sent " +
            "FROM chat_message cm " +
            "JOIN chat_association ca ON cm.sender_id = ca.rep_username " +
            "WHERE ca.customer_username = ? " +
            "ORDER BY cm.date_time_sent DESC";

    try (PreparedStatement pstmt = con.prepareStatement(messagesQuery)) {
        pstmt.setString(1, username);
        ResultSet messagesResult = pstmt.executeQuery();
%>



<h1>Replies from the Customer Service Representative!</h1>

<table border ="1">
    <tr>
        <th> Customer Name </th>
        <th> Date/Time Sent </th>
        <th> Message Text </th>
    </tr>
    <%
    //parse out the results
    while (messagesResult.next()) { %>
        <tr>
            <td><%= messagesResult.getString("sender_id") %></td>
            <td><%= messagesResult.getString("date_time_sent") %></td>
            <td><%= messagesResult.getString("text") %></td>
        </tr>
    <%
    }
    //close the connection.
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
