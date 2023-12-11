<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs336.pkg.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Send Reply to Customer Representative</title>
</head>
<body>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    String customerUsername = (String) session.getAttribute("user");
    String repUsername = request.getParameter("Rep");
    String replyText = request.getParameter("replyText");
    out.println("replyText: " + replyText);


    String insertReplyQuery = "INSERT INTO chat_message (sender_id, text, date_time_sent) VALUES (?, ?, NOW())";
    try (PreparedStatement pstmt = con.prepareStatement(insertReplyQuery)) {
        pstmt.setString(1, customerUsername);
        pstmt.setString(2, replyText);
        pstmt.executeUpdate();
    }

    String insertAssociationQuery = "INSERT IGNORE INTO chat_association (customer_username, rep_username) VALUES (?, ?)";
    try (PreparedStatement pstmt = con.prepareStatement(insertAssociationQuery)) {
        pstmt.setString(1, customerUsername);
        pstmt.setString(2, repUsername); 
        pstmt.executeUpdate();
    }

    response.sendRedirect("ReplyToCustomerRep.jsp?success=true");

    db.closeConnection(con);

} catch (Exception e) {
    out.print(e);
}
%>

</body>
</html>
