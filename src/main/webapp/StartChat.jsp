<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs336.pkg.*, java.io.*, java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Start New Chat</title>
</head>
<body>

    <h1>Start a New Chat with a Customer Service Representative!</h1>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Connection con = null;
        try {
            String customerUsername = (String) session.getAttribute("user");
            String selectedRepUsername = request.getParameter("selectedRepUsername");
            String messageText = request.getParameter("message");

            // Check if the message text is not null or empty
            if (messageText != null && !messageText.trim().isEmpty()) {
                // Get the database connection
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                String insertMessageQuery = "INSERT INTO chat_message (sender_id, text, date_time_sent) VALUES (?, ?, NOW())";
                try (PreparedStatement pstmt = con.prepareStatement(insertMessageQuery)) {
                    pstmt.setString(1, customerUsername);
                    pstmt.setString(2, messageText);
                    pstmt.executeUpdate();
                }

                String insertChat_Customer = "INSERT IGNORE INTO chat_customer (username) VALUES (?)";
                try (PreparedStatement pstmt = con.prepareStatement(insertChat_Customer)) {
                    pstmt.setString(1, customerUsername);
                    pstmt.executeUpdate();
                }
                String selectRepQuery = "SELECT repusername FROM customerrep " +
                        "WHERE repusername NOT IN (SELECT rep_username FROM chat_association WHERE customer_username = ?) " +
                        "ORDER BY RAND() LIMIT 1";

try (PreparedStatement repStmt = con.prepareStatement(selectRepQuery)) {
    repStmt.setString(1, customerUsername);
    ResultSet repResult = repStmt.executeQuery();

    // Print debug information
    out.println("Selected Customer: " + customerUsername);

    // Check if there is a representative in the database
    if (repResult.next()) {
        String repUsername = repResult.getString("repusername");

        // Print debug information
        out.println("Selected Representative: " + repUsername);

        // Your existing code for inserting into chat_association
        String insertChatAssoc = "INSERT INTO chat_association (customer_username, rep_username) VALUES (?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(insertChatAssoc)) {
            pstmt.setString(1, customerUsername);
            pstmt.setString(2, repUsername);
            pstmt.executeUpdate();
        }

        out.println("Message submitted successfully!");
    } else {
        out.println("No representative found!");
    }
}


            } else {
                out.println("Please fill in your Message in the text box below!");
            }
        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    out.println("Error closing database connection: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }
%>

    <form action="StartChat.jsp" method="post">
		<input type="hidden" name="customerUsername" value="<%= session.getAttribute("user") %>">

        <label for="message">Message:</label>
        <textarea id="message" name="message" rows="4" cols="50" required></textarea><br>

        <input type="submit" value="Submit Message">
    </form>

    <a href="CustomerChatPage.jsp">Back to Chat Page</a>

</body>
</html>
