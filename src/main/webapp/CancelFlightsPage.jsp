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
		<!-- Need to create JSP file to cancel the ticket if it is business or first class and the cancelling customer is the ticket owner. -->
		<!-- If canceled, send to cancelSuccess Page, else to cancel Fail Page-->
		
		<form action = "CancelTickets.jsp" method = "POST">
		Enter Ticket Number:<input type = "text" name = "ticketNum" /><br/>
		<input type = "Button" name = "Home" value = "Home"> <br/>
		<input type = "Submit" value = "Cancel">		
		
		</form>
	</body>
</html>