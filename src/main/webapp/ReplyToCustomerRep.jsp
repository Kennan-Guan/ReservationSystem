<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reply to Customer Representative</title>
</head>
<body>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    // Retrieve the username from session attribute or wherever it's stored
    String customerUsername = (String) session.getAttribute("user");

    // Retrieve the representative username from the form
    String repUsername = request.getParameter("Rep");

    // Query to get messages for the customer
    String messagesQuery = "SELECT DISTINCT cm.message_id, cm.sender_id, cm.text, cm.date_time_sent " +
            "FROM chat_message cm " +
            "JOIN chat_association ca ON cm.sender_id = ca.rep_username " +
            "WHERE ca.customer_username = ? AND cm.sender_id = ? " +
            "ORDER BY cm.date_time_sent DESC";

    try (PreparedStatement pstmt = con.prepareStatement(messagesQuery)) {
        pstmt.setString(1, customerUsername);
        pstmt.setString(2, repUsername);
        ResultSet messagesResult = pstmt.executeQuery();
%>

<%
    // Check for the success parameter
    String successParam = request.getParameter("success");
    if ("true".equals(successParam)) {
%>
    <div style="color: green;">Reply sent successfully to your Customer Representative!</div>

    <form action="CustomerChatPage.jsp" method="GET">
        <input type="submit" name="Back" value="Back to Customer Chat Page">
    </form>
<%
    } else {
%>
    <h1>Chat with Customer Representative <%= repUsername %></h1>

    <table border="1">

        <tr>
            <th> Date/Time Sent </th>
            <th> Message Text </th>
        </tr>
        <%
        //parse out the results
        while (messagesResult.next()) { %>
            <tr>
                <td><%= messagesResult.getString("date_time_sent") %></td>
                <td><%= messagesResult.getString("text") %></td>
            </tr>
        <%
        }
        //close the connection.
        db.closeConnection(con);
        %>
    </table>

    <br/>
    <form action="SendReplyToCustomerRep.jsp" method="POST">
        <input type="hidden" name="customerName" value="<%= customerUsername %>">
        <input type="hidden" name="repName" value="<%= repUsername %>">
        <label for="replyText">Reply:</label>
        <textarea name="replyText" rows="4" cols="50"></textarea><br>
        <input type="submit" value="Send Reply">
    </form>

    <form action="CustomerChatPage.jsp" method="GET">
        <input type="submit" name="Back" value="Back to Customer Chat Page">
    </form>

<%
    }
    }
} catch (Exception e) {
    out.print(e);
}
%>

</body>
</html>
