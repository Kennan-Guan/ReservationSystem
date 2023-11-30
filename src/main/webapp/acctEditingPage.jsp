<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Account</title>
	</head>
	<body>
		<h1>Edit Account</h1>
		<!-- Need to create JSP file to implement edits and bring user to home page after clicking submit -->
		
		<form action = "editAcctActionHandling.jsp" method = "POST">
		Enter New Username: <input type = "text" name = "newUName" /><br/>
		Enter New Password: <input type = "text" name = "newPwd" /><br/>
		Enter New First Name : <input type = "text" name = "newFName" /><br/>
		Enter New Last Name : <input type = "text" name = "newLName" /><br/>
		<input type = "Button" name = "Home" value = "Home"> <br/>
		<input type = "Submit" value = "Submit">	
		
		</form>
	</body>
</html>