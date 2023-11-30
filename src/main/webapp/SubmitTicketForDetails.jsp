<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Get Ticket Details</title>
</head>
<body>
<!--  Add functionality to either send customer to TicketDetailsPage.jsp if they are the owner of the ticket with the num or 
TickerDetailsError.jsp otherwise -->
<!-- In functionality, need to also let an admin view details for any ticket so long as it exists, otherwise go to error page 
(sent to same pages as customer) -->
<form action="SubmitTicket.jsp" method="POST">
		<h1>Enter ticket number and then press submit</h1>

       Enter ticket Number: <input type="text" name="ticket Num"/> <br/>
       <input type = "button" name = "home" value = "Home"><br/>
       <input type="submit" value="Submit"/>
     </form>
</body>
</html>