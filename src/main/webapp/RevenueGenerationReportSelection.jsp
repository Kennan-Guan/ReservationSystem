<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Revenue Generation Report</title>
	</head>
	<body>
		<h1>Select Action</h1>
		<!-- Need to create JSP file to lead admin to RevenueGenerationReport.jsp or Landing Page-->
		
		<form action = "RevenueGenReportCreationjsp" method = "POST">
		Generate report for a(n): 
		<input type = "radio" id = "airline" name = "RevReportFor" value = "airline">
		<label for = "airline">Airline </label>
		<input type = "radio" id = "flight" name = "RevReportFor" value = "flight">
		<label for = "flight">Flight </label>
		<input type = "radio" id = "customer" name = "RevReportFor" value = "customer">
		<label for = "customer">Customer </label><br/>
		Enter ariline code/ flight number/ customer name (note: when entering a flight number, enter it as '{ariline code} - {number}'):
		<input type = "text" name = "revenueGeneratorId" /><br/>
		<input type = "button" name ="Home" value = "Home">
		<input type = "Submit" value = "book">		
		
		</form>
	</body>
</html>