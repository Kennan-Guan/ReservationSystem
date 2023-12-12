<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cancel Page</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to cancel the ticket if it is business or first class and the canceling customer is the ticket owner. -->
		<!-- If canceled, send to cancelSuccessPage.jsp, else to cancelFailPage.jsp-->
		<br/>
		<form action = "CustomerLandingPage.jsp" method = "get">
			<button type="submit">Return to Home Page</button>
		
		</form><br>		
		<form action = "CancelTickets.jsp" method = "POST">
		Enter Ticket Number:<input type = "text" name = "ticketId" /><br/>
		      <input type="submit" value="Cancel Ticket"/>
		</form>
	</body>
</html>