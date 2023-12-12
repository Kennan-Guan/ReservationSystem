<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs336.pkg.*, java.io.*, java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reply to Customer</title>
</head>
<body>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    String username = (String) session.getAttribute("user");
    String selectedCustomer = request.getParameter("Rep");
    out.println(selectedCustomer);
/*     String repUsername = "custrep"; 
 */
    String messagesQuery = "SELECT DISTINCT cm.message_id, cm.sender_id, cm.text, cm.date_time_sent " +
            "FROM chat_message cm " +
            "JOIN chat_association ca ON cm.sender_id = ca.customer_username " +
            "WHERE ca.rep_username = ? AND cm.sender_id = ? " +
            "ORDER BY cm.date_time_sent DESC";

    try (PreparedStatement pstmt = con.prepareStatement(messagesQuery)) {
        pstmt.setString(1, username);
        pstmt.setString(2, selectedCustomer);
        ResultSet messagesResult = pstmt.executeQuery();
%>

<%
    String successParam = request.getParameter("success");
    if ("true".equals(successParam)) {
%>
    <div style="color: green;">Reply sent successfully!</div>

    

    <form action="CSRepChatPage.jsp" method="GET">
  
        <input type="submit" name="Back" value="Back to Chat Page">
    </form>
<%
    } else {
%>
    <h1>Reply to Customer <%= selectedCustomer %></h1>

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
    
    String updateStatusQuery = "UPDATE chat_message " +
            "SET responded = 'Y' " +
            "WHERE sender_id = ? AND responded = 'N'";
    try (PreparedStatement updateStatusStmt = con.prepareStatement(updateStatusQuery)) {
        updateStatusStmt.setString(1, selectedCustomer);
        updateStatusStmt.executeUpdate();
    }

    %>
        <%
        }
        
        //close the connection.
        db.closeConnection(con);
        %>
    </table>

    <br/>
    <form action="SendReply.jsp" method="POST">
        <input type="hidden" name="customerName" value="<%= selectedCustomer %>">
        <label for="replyText">Reply:</label>
        <textarea name="replyText" rows="4" cols="50"></textarea><br>
        <input type="submit" value="Send Reply">
    </form>

    <form action="CSRepChatPage.jsp" method="GET">
    
        <input type="submit" name="Back" value="Back to Chat Page">
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
