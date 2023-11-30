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
		<!-- Go to AdminEditAcctPage.jsp -->
		<input type = "Button" name = "EditAcct" value = "Edit Customer/Customer Service Rep Accounts"><br/>
		<!-- Go to SalesReportPage.jsp -->
		Enter Month: <input type = "text" name = "SalesMonth"/>
		<input type = "Button" name = "GenerateReport" value = "See Monthly Sales Report"><br/>
		<!-- Go to  GetResList.jsp-->
		<input type = "Button" name = "CheckRes" value = "Check Reservations"><br/>
		<!-- Go to SubmitTicketForDetails.jsp -->
		<input type = "Button" name = "ViewTicketDeets" value = "View Ticket Details"><br/>
		<!-- Go to RevenueGenerationReportSelection.jsp -->
		<input type = "Button" name = "RevenueGenerators" value = "See Revenue Generation Report"><br/>
		<!-- Go to TopCustomer.jsp -->
		<input type = "Button" name = "TopCustomer" value = "See Customer Generating the Most Revenue"><br/>
		<!--  Go to MostActiveFlightsPage.jsp -->
		<input type = "Button" name = "MostActive" value = "See which Flight Sold the Most Tickets"><br/>
		<!-- Log out -->
		<input type = "Button" name = "LogOut" value = "Logout">		
		</form>
	</body>
</html>