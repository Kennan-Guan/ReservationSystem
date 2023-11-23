<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Creating Account</title>
</head>
<body>
<!--  Add jsp page to either send user to ticket details page if they are the owner of the ticket with the num or ticketerror page otherwise -->
<form action="SubmitTicket.jsp" method="POST">
		<h1>Enter ticket number and then press submit</h1>

       Enter ticket Number: <input type="text" name="ticket Num"/> <br/>
       <input type = "button" name = "home" value = "Home"><br/>
       <input type="submit" value="Submit"/>
     </form>
</body>
</html>