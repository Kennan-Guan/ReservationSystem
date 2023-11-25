<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Get Reservation Details</title>
</head>
<body>
<!--  Add functionality to either display an error message if the flight info or customer name don't exist or send the admin to the ReservationList Page-->
<form action="GetReservationDetails.jsp" method="POST">
		<h1>Enter Flight Info Or Customer Name</h1>
	    Note: if getting details for a customer, enter the first name in field 1 and the second in field 2. If getting details for a flight,
	    enter the airline code in field 1 and the flight number in field 2. <br/>
        Field 1: <input type="text" name="f1"/> <br/>
        Field 2: <input type="text" name="f2"/> <br/>
        <input type = "radio" id = "cust" name = "entryType" name = "Customer">
        <label for = "cust">Customer</label>
        <input type = "radio" id = "flight" name = "entryType" name = "Flight">
        <label for = "flight">Flight</label><br/>
        <input type="submit" value="Submit"/><br/>
        <input type = "button" name = "home" value = "Home">
       
     </form>
</body>
</html>