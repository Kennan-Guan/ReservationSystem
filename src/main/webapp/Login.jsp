<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login Form</title>
	</head>
	<body>
		<h1>Login Form</h1>
		<!-- Need to add functionality to send user to proper landing page based off of account type -->
		<form action="CheckLoginDetails.jsp" method="POST"> 
		Username: <input type="text" name="username"/> <br/>
		Password:<input type="password" name="password"/> <br/>
		<input type="submit" value="Submit"/> <br/>
		</form>
		<!-- Go to CreateLoginDetails.jsp -->
		<a href=CreateLoginDetails.jsp>Create Account</a>
	</body>
</html>