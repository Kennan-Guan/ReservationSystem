<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Admin Homepage</title>
	</head>
	<body>
		<h2>Edit Account</h2>
		<!-- Add a new account -->
		<form action="AdminAddAcct.jsp" method="POST">
			<label for="account">What account type do you want to add?</label>
			<br>
			<input type="radio" name="account" value="customer"/>Customer
		  	<br>
		  	<input type="radio" name="account" value="customer representative"/>Customer Representative
		  	<br>
		  	<label for="newUsername">Give the username of the account you want added.</label>
			<input type="text" name="newUsername"/>
			<br>
			<label for="newPassword">Give the password of the account you want added.</label>
			<input type="text" name="newPassword"/>
			<br>
			<label for="newFname">Give the first name of the account you want added.</label>
			<input type="text" name="newFname"/>
			<br>
			<label for="newLname">Give the last name of the account you want added.</label>
			<input type="text" name="newLname"/>
			<br>
			<button type="submit">Add Account</button>
		</form><br>
		
		<!-- Update the details of a current account -->
		<form action = "AdminUpdateAcct.jsp" method = "POST">
			<label for="account">What account type do you want to update?</label>
			<br>
			<input type="radio" name="account" value="customer"/>Customer
		  	<br>
		  	<input type="radio" name="account" value="customer representative"/>Customer Representative
		  	<br>
		  	<label for="account Name">What is the current username of the account?</label>
			<input type="text" name="accountName"/>
			<br>
		  	<label for="updateType">What are you updating?</label>
		  	<select name="updateType" size=1>
				<option value="username">Username</option>
				<option value="password">Password</option>
				<option value="firstName">First Name</option>
				<option value="lastName">Last Name</option>
			</select>&nbsp;<br>
			<label for="newInfo">Input the new information (Ex. "password" for new password)</label>
			<input type="text" name="newInfo"/>
			<br>
			<button type="submit">Update Account</button>
		</form><br>
		<!-- Delete an account -->
		<form action="AdminDeleteAcct.jsp" method="POST">
			<label for="account">What account type do you want to delete?</label>
			<br>
			<input type="radio" name="account" value="customer"/>Customer
		  	<br>
		  	<input type="radio" name="account" value="customer representative"/>Customer Representative
		  	<br>
		  	<label for="deletedUsername">Give the username of the account you want deleted.</label>
			<input type="text" name="deletedUsername"/>
			<br>
			<button type="submit">Delete Account</button>
		</form><br>
		<h2>Generate Reports</h2>
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
		<!-- Go to RevenueGenerationReportSelection.jsp -->
		<form action = "RevenueGenerationReportPage.jsp" method = "POST">
			Generate report for a(n): 
			<input type = "radio" id = "airline" name = "RevReportFor" value = "airline">
			<label for = "airline">Airline </label>
			<input type = "radio" id = "flight" name = "RevReportFor" value = "flight">
			<label for = "flight">Flight </label>
			<input type = "radio" id = "customer" name = "RevReportFor" value = "customer">
			<label for = "customer">Customer </label><br>
			Enter airline code/ flight number/ customer name (note: when entering a flight number, enter it as '{airline code} - {number}'):
			<input type = "text" name = "revenueGeneratorId"><br>
			<button type="submit">See Revenue Generation Report</button>
		</form><br>
		<h2>See Reservations</h2>
		<!-- Go to  GetResList.jsp-->
		<form action = "GetReservationDetails.jsp" method = "POST">
			<input type="radio" name= "checkFor" value="flight"> Flight Number <br>
			<input type="radio" name= "checkFor" value="customer"> Customer <br>
			Enter customer username or flight number('{airline code} - {number}')
			<input type="text" name="identification"><br>
			<button type="submit">Check Reservations</button>
		</form><br>
		<h2>Ticket Details</h2>
		<!-- Go to SubmitTicketForDetails.jsp -->
		<form action = "SubmitTicketForDetails.jsp" method = "POST">
			<button type="submit">View Ticket Details</button>
		</form><br>
		<h2>Activity Details</h2>
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