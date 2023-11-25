<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Account Editing</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to lead admin to next page based off of button clicked -->
		<form action = "AdminEditingActionHandling.jsp" method = "POST">
		Enter a new username to create an account: <input type = "text" name = "AddUsername" /><br/>
		Enter a new password to create an account: <input type = "text" name = "AddPassword" /><br/>
		What type of account are you creating? 
		<input type = "radio" id = "cust" name = "acctType" value = "Customer">
		<label for = "cust">Customer</label>
		<input type = "radio" id = "rep" name = "acctType" value = "Representative">
		<label for = "rep">Customer Service Representative</label><br/>
		Enter a username to delete an account: <input type = "text" name = "DelAcct"/><br/>
		Enter a username to edit an account: <input type = "text" name = "editAcct"/><br/>	
		<input type = "Submit" value = "Submit"><br/>
		<input type = "button" name = "home" value = "home">	
		</form>
	</body>
</html>