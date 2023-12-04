<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Make Res For Customer</title>
</head>
<body>
<!-- Send CS Rep to FlightReservationPage.jsp and make it so that the reservation made by the CS Rep is for the customer with username entered-->
<form action="SubmitCustomerForRes" method="POST">
		<h1>Input Customer UserName and then press submit</h1>

       Enter Customer's UserName: <input type="text" name="UserName"/> <br/>
       <input type = "button" name = "home" value = "Home"><br/>
       <input type="submit" value="Submit"/>
     </form>
</body>
</html>