<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cancellation Failure Page</title>
	</head>
	<body>
		<h1>Flight Could not be Canceled! Either you are not the ticketholder or the ticket is economy class</h1>
		<!-- Bring back to Landing Page -->
<br/>
		<form action = "CustomerLandingPage.jsp" method = "POST">
			<button type="submit">Return to Home Page</button>
		
		</form><br>
	</body>
</html> 