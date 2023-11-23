<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Admin Homepage</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to lead admin to next page based off of button clicked -->
		<form action = "AdminSelectionHandling.jsp" method = "POST">
		<input type = "Button" name = "EditAcct" value = "Edit Customer/Customer Service Rep Accounts"><br/>
		Enter Month: <input type = "text" name = "SalesMonth"/>
		<input type = "Button" name = "GenerateReport" value = "See Monthly Sales Report"><br/>
		<input type = "Button" name = "CheckRes" value = "Check Reservations"><br/>
		<input type = "Button" name = "RevenueGenerators" value = "See Revenue Generation Report"><br/>
		<input type = "Button" name = "MostActive" value = "See which Flight Sold the Most Tickets">		
		</form>
	</body>
</html>