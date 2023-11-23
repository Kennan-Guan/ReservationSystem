<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Join Wait List Page</title>
	</head>
	<body>
		<h1>Join Wait List?</h1>
		<!-- Need to create JSP file to lead customer to next page based off of button clicked -->
		<form action = "WaitlistSelection.jsp" method = "POST">
		There are no available tickets of this kind. Would you like to join the waitlist? <br/>
		<input type = "button" name = "yes" value = "join waitlist"><br/>
		<input type = "button" name = "home" value = "Return to Home">
		</form>
	</body>
</html>