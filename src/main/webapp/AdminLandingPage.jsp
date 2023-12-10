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
		<form action = "AdminEditAcctPage.jsp" method = "POST">
			<button type="submit">Edit Customer/Customer Service Rep Accounts</button>
		</form><br>
		<!-- Go to SalesReportPage.jsp -->
		<form action = "SalesReportPage.jsp" method = "POST">
			<select name="month" size=1>
				<option value="1">January</option>
				<option value="2">February</option>
				<option value="3">March</option>
				<option value="4">April</option>
				<option value="5">May</option>
				<option value="6">June</option>
				<option value="7">July</option>
				<option value="8">August</option>
				<option value="9">September</option>
				<option value="10">October</option>
				<option value="11">November</option>
				<option value="12">December</option>
			</select>&nbsp;<br> <input type="submit" value="month">
			<select name="year" size=1>
				<option value="2020">January</option>
				<option value="2021">February</option>
				<option value="2022">March</option>
				<option value="2023">April</option>
			</select>&nbsp;<br> <input type="submit" value="year">
			<button type="submit">See Monthly Sales Report</button>
		</form><br>
		<!-- Go to  GetResList.jsp-->
		<form action = "GetResList.jsp" method = "POST">
			<button type="submit">Check Reservations</button>
		</form><br>
		<!-- Go to SubmitTicketForDetails.jsp -->
		<form action = "SubmitTicketForDetails.jsp" method = "POST">
			<button type="submit">View Ticket Details</button>
		</form><br>
		<!-- Go to RevenueGenerationReportSelection.jsp -->
		<form action = "RevenueGenerationReportSelection.jsp" method = "POST">
			<button type="submit">See Revenue Generation Report</button>
		</form><br>
		<!-- Go to TopCustomer.jsp -->
		<form action = "TopCustomer.jsp" method = "POST">
			<button type="submit">See Customer Generating the Most Revenue</button>
		</form><br>
		<!--  Go to MostActiveFlightsPage.jsp -->
		<form action = "MostActiveFlightsPage.jsp" method = "POST">
			<button type="submit">See which Flight Sold the Most Tickets</button>
		</form><br>
		<!-- Log out -->
		<form action = "LogOut.jsp" method = "POST">
			<button type="submit">Logout</button>
		</form><br>	
		
	</body>
</html>