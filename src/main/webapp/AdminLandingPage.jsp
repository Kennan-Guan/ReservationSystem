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
		<!-- Go to AdminUpdateAcct.jsp -->
		<form action = "AdminUpdateAcct.jsp" method = "POST">
			<input type="radio" name="account" value="customer"/>Customer
		  	<br>
		  	<input type="radio" name="account" value="customer representative"/>Customer Representative
		  	<br>
		  	<label for="account Name">What is the current username of the account?</label>
			<input type="text" name="accountName"/>
			<br>
		  	<label for="updateType">What are you Updating?</label>
		  	<select name="updateType" size=1>
				<option value="username">Username</option>
				<option value="password">Password</option>
				<option value="firstName">First Name</option>
				<option value="lastName">Last Name</option>
			</select>&nbsp;<br>
			<label for="newInfo">Input the New Information (Ex. "password" for new password)</label>
			<input type="text" name="newInfo"/>
			<button type="submit">Update Account</button>
		</form><br>
		
		
		<!-- Go to SalesReportPage.jsp -->
		<form action = "SalesReportPage.jsp" method = "POST">
			<label for="month">Choose Month</label>
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
			</select>&nbsp;<br>
			<label for="year">Choose a Year</label>
			<select name="year" size=1>
				<option value="2020">2020</option>
				<option value="2021">2021</option>
				<option value="2022">2022</option>
				<option value="2023">2023</option>
			</select>&nbsp;<br>
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