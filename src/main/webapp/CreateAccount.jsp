<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Creating Account</title>
</head>
<body>
<form action="CreateLoginDetails.jsp" method="POST">
		<h1>You are now creating an acc cuz no account was found in db </h1>

       Enter a Username: <input type="text" name="username"/> <br/>
       Enter a Password: <input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
</body>
</html>