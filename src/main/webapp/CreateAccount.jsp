
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Creating Account</title>
</head>
<body>
<form action="CreateLoginDetails.jsp" method="POST">
<!-- Can only create Customer Accounts -->
		<h1>You are now creating a new account </h1>
		Enter a First Name: <input type="text" name="firstname"/><br/>
		Enter a Last Name: <input type="text" name="lastname"/><br/>
       Enter a Username: <input type="text" name="username"/> <br/>
       Enter a Password: <input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
</body>
</html>