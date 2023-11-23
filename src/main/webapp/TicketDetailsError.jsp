<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Ticket Details Error Page</title>
	</head>
	<body>
		<h1>Error: either you are not the ticket owner or the ticket does not exist</h1>
		<!-- Need to create JSP file to bring back to landing page or to ticket submission page-->
		<form action = "TicketDetailsErrorPageHandling.jsp" method = "POST">
		<input type = "radio" id = "home" name = "Home" value = "Home">
		<label for = "home">Home</label>
		<input type = "radio" id = "newTicket" name = "newTicket" value = "newTicket">
		<label for = "newTicker">Enter a new Ticket</label><br/>
		<input type = "Submit" value = "Submit">
		</form>
	</body>
</html>