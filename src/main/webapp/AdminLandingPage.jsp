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
		<!-- Go to AdminEditAcctPage.jsp -->
		<form action = "AdminEditAcctPage.jsp" method = "GET">
			<button type="submit">Edit Customer/Customer Service Rep Accounts</button>
		</form><br>
		<!-- Go to SalesReportPage.jsp -->
		<form action = "SalesReportPage.jsp" method = "GET">
			<button type="submit">See Monthly Sales Report</button>
		</form><br>
		<!-- Go to  GetResList.jsp-->
		<form action = "GetResList.jsp" method = "GET">
			<button type="submit">Check Reservations</button>
		</form><br>
		<!-- Go to SubmitTicketForDetails.jsp -->
		<form action = "SubmitTicketForDetails.jsp" method = "GET">
			<button type="submit">View Ticket Details</button>
		</form><br>
		<!-- Go to RevenueGenerationReportSelection.jsp -->
		<form action = "RevenueGenerationReportSelection.jsp" method = "GET">
			<button type="submit">See Revenue Generation Report</button>
		</form><br>
		<!-- Go to TopCustomer.jsp -->
		<form action = "TopCustomer.jsp" method = "GET">
			<button type="submit">See Customer Generating the Most Revenue</button>
		</form><br>
		<!--  Go to MostActiveFlightsPage.jsp -->
		<form action = "MostActiveFlightsPage.jsp" method = "GET">
			<button type="submit">See which Flight Sold the Most Tickets</button>
		</form><br>
		<!-- Log out -->
		<form action = "LogOut.jsp" method = "GET">
			<button type="submit">Logout</button>
		</form><br>	
		
	</body>
</html>