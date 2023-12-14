<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Flights</title>
	</head>
	<body>
	
		<h1>Flights</h1>
		<!-- Need to add functionality to filter results (which would return to this page but with a different set of query results displayed)
		, go back to BrowseFlights.jsp, or go to CustomerLandingPage.jsp --> 
		
		<% try {
			String str = request.getParameter("str");
			Boolean twoWay = Boolean.parseBoolean(request.getParameter("twoWay"));
			String sort1 = request.getParameter("sort1");
			String minPrice1 = request.getParameter("minprice1");
			String maxPrice1 = request.getParameter("maxprice1");
			String airline1 = request.getParameter("airline1");
			String minTakeoff1 = request.getParameter("minTakeoff1");
			String maxTakeoff1 = request.getParameter("maxTakeoff1");
			String minArrival1 = request.getParameter("minArrival1");
			String maxArrival1 = request.getParameter("maxArrival1");
			String sort_order = request.getParameter("order1");
			
			
			String str2 = "";
			
			
			
			//Set up variables to store userinputs for first sort, departure sort
			
			
			//Set up variables to store userinputs for second sort, arrival sort
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			ResultSet result;
			ResultSet result2;
			
			str = str.substring(0, str.length() - 1);
			str = "SELECT * FROM (" + str + ") ff";
			
			if ((minPrice1 != null && !minPrice1.isEmpty()) || (maxPrice1 != null && !maxPrice1.isEmpty()) || 
					(airline1 != null && !airline1.isEmpty())|| (minTakeoff1 != null && !minTakeoff1.isEmpty()) || 
					(maxTakeoff1 != null && !maxTakeoff1.isEmpty()) || (minArrival1 != null && !minArrival1.isEmpty()) ||
					(maxArrival1 != null && !maxArrival1.isEmpty())){
				str = str + " WHERE";
			}
			
			// IF statements to process the first filters
			if (minPrice1 != null && !minPrice1.isEmpty()){
				str = str + " total_fare >= " + minPrice1 + " AND"; 
			}
			
			if (maxPrice1 != null && !maxPrice1.isEmpty()){
				str = str + " total_fare <= " + maxPrice1 + " AND";
			}
			
			if (airline1 != null && !airline1.isEmpty()){
				str = str + " REPLACE(REPLACE(Airlines, ' ', ''), '" + airline1 + "', '') = '' AND";
			}
			
			if (minTakeoff1 != null && !minTakeoff1.isEmpty()){
				str = str + " TIME(f1_dept_time) >= '" + minTakeoff1 + "' AND";
			}
			
			if (maxTakeoff1 != null && !maxTakeoff1.isEmpty()){
				str = str + " TIME(f1_dept_time) <= '" + maxTakeoff1 + "' AND";
			}
			
			if (minArrival1 != null && !minArrival1.isEmpty()){
				str = str + " TIME(Arrival_Time) >= '" + minArrival1 + "' AND";
			}
			
			if (maxArrival1 != null && !maxArrival1.isEmpty()){
				str = str + " TIME(Arrival_Time) <= '" + maxArrival1 + "' AND";
			}
			
			if (str.substring(str.length() - 4).equals(" AND")){
				str = str.substring(0, str.length() - 4);
			}

			if (sort1 != null && !sort1.isEmpty()){
				str = str + " ORDER BY " + sort1 + " " + sort_order;
			}
			
			str = str + ";";
			
			if (twoWay == true){
				str2 = request.getParameter("str2");
				str2 = str2.substring(0, str2.length() - 1);
				str2 = "SELECT * FROM (" + str2 + ") ff";
				String sort2 = request.getParameter("sort2");
				String minPrice2 = request.getParameter("minprice2");
				String maxPrice2 = request.getParameter("maxprice2");
				String maxStops2 = request.getParameter("maxstops2");
				String airline2 = request.getParameter("airline2");
				String minTakeoff2 = request.getParameter("minTakeoff2");
				String maxTakeoff2 = request.getParameter("maxTakeoff2");
				String minArrival2 = request.getParameter("minArrival2");
				String maxArrival2 = request.getParameter("maxArrival2");
				String sort_order2 = request.getParameter("order2");
				
				if ((minPrice2 != null && !minPrice2.isEmpty()) || (maxPrice2 != null && !maxPrice2.isEmpty()) || 
						(airline2 != null && !airline2.isEmpty())|| (minTakeoff2 != null && !minTakeoff2.isEmpty()) || 
						(maxTakeoff2 != null && !maxTakeoff2.isEmpty()) || (minArrival2 != null && !minArrival2.isEmpty()) ||
						(maxArrival2 != null && !maxArrival2.isEmpty())){
					str2 = str2 + " WHERE";
				}
				
				if (minPrice2 != null && !minPrice2.isEmpty()){
					str2 = str2 + " total_fare >= " + minPrice2 + " AND"; 
				}
				
				if (maxPrice2 != null && !maxPrice2.isEmpty()){
					str2 = str2 + " total_fare <= " + maxPrice2 + " AND";
				}
				
				if (airline2 != null && !airline2.isEmpty()){
					str2 = str2 + " REPLACE(REPLACE(Airlines, ' ', ''), '" + airline2 + "', '') = '' AND";
				}
				
				if (minTakeoff2 != null && !minTakeoff2.isEmpty()){
					str2 = str2 + " TIME(f1_dept_time) >= '" + minTakeoff2 + "' AND";
				}
				
				if (maxTakeoff2 != null && !maxTakeoff2.isEmpty()){
					str2 = str2 + " TIME(f1_dept_time) <= '" + maxTakeoff2 + "' AND";
				}
				
				if (minArrival2 != null && !minArrival2.isEmpty()){
					str2 = str2 + " TIME(Arrival_Time) >= '" + minArrival2 + "' AND";
				}
				
				if (maxArrival2 != null && !maxArrival2.isEmpty()){
					str2 = str2 + " TIME(Arrival_Time) <= '" + maxArrival2 + "' AND";
				}
				
				if (str2.substring(str2.length() - 4).equals(" AND")){
					str2 = str2.substring(0, str2.length() - 4);
				}
				
				if (sort2 != null && !sort2.isEmpty()){
					str2 = str2 + " ORDER BY " + sort2 + " " + sort_order2;
				}
				
				str2 = str2 + ";";
				
			}
			
			
			
			//Run the query against the database.
			result = stmt.executeQuery(str);
			
			ResultSetMetaData metaData = result.getMetaData();
			int columnCount = metaData.getColumnCount();
		
		%>

<table>
<thead>
   <tr>
      <% for (int i = 1; i <= columnCount; i++) { %>
         <th><%= metaData.getColumnName(i) %></th>
      <% } %>
   </tr>
</thead>
<tbody>
   <% while (result.next()) { %>
      <tr>
         <% for (int i = 1; i <= columnCount; i++) { %>
            <td><%= result.getString(i) %></td>
         <% } %>
      </tr>
   <% } %>
</tbody>
</table>

<%
	int columnCount2; 
	ResultSetMetaData metaData2;
	if (twoWay == true) {
			result2 = stmt2.executeQuery(str2);
        	metaData2 = result2.getMetaData();
    		columnCount2 = metaData2.getColumnCount();
	
        
    %>
        <table>
			<thead>
			   <tr>
			      <% for (int i = 1; i <= columnCount2; i++) { %>
			         <th><%= metaData2.getColumnName(i) %></th>
			      <% } %>
			   </tr>
			</thead>
			<tbody>
			   <% while (result2.next()) { %>
			      <tr>
			         <% for (int i = 1; i <= columnCount2; i++) { %>
			            <td><%= result2.getString(i) %></td>
			         <% } %>
			      </tr>
			   <% } %>
	<% } %>
			</tbody>
			</table>
		
		
				

			<% 
			//close the connection.
			db.closeConnection(con);
			%>
		
		</form>
	
	<%} catch (Exception e) {
			out.print(e);
		}%>
	<br/>
	
	<form action="CustomerLandingPage.jsp" method="get">
        <button type="submit">Return Home</button>
    </form><br> 
	
	</body>
</html> 