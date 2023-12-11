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
    <title>Customer Service Rep Chat Page</title>
</head>
<body>

<h1>Customers who want to chat:</h1>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    String repUsername = "custrep"; 


    String messagesQuery = "SELECT DISTINCT cm.message_id, cm.sender_id, cm.text, cm.date_time_sent, cm.responded " +
            "FROM chat_message cm " +
            "JOIN chat_association ca ON cm.sender_id = ca.customer_username " +
            "WHERE ca.rep_username = ? " +
            "ORDER BY cm.date_time_sent DESC";

    try (PreparedStatement pstmt = con.prepareStatement(messagesQuery)) {
        pstmt.setString(1, repUsername);
        ResultSet messagesResult = pstmt.executeQuery();
        
  
%>

<table border="1">
    <tr>
        <th> Customer Name </th>
        <th> Date/Time Sent </th>
        <th> Message Text </th>
        <th> Responded </th>
    </tr>
    <%
    //parse out the results
    while (messagesResult.next()) { %>
        <tr>
            <td><%= messagesResult.getString("sender_id") %></td>
            <td><%= messagesResult.getString("date_time_sent") %></td>
            <td><%= messagesResult.getString("text") %></td>
            <td><%= messagesResult.getString("responded") %></td>
        </tr>
    <%
    }
    //close the connection.
    db.closeConnection(con);
    %>
</table>

<br/>
Enter name of Customer to reply to:
<form action="ReplyToCustomer.jsp" method="POST">
    <input type="text" name="Rep" />
    <input type="submit" value="reply">
</form>

<form action="CSRepLandingPage.jsp" method="GET">
    <input type="submit" name="Home" value="Return Home">
</form>

<%}
} catch (Exception e) {
    out.print(e);
}
%>
</body>
</html>
