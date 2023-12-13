    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.time.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
	
	try {
		// accept userinputs from BrowseResults.jsp and stores them into variables
		String flightType = request.getParameter("tickerType");
		String dept_airport = request.getParameter("DepartingCode");
		String arr_airport = request.getParameter("ArrivingCode"); 
		String str_date = request.getParameter("FlightDate");
		String str_date2 = request.getParameter("FlightDate2");
		String dept_airport2 = request.getParameter("ArrivingCode");
		String arr_airport2 = request.getParameter("DepartingCode"); 
		int n = Integer.parseInt(request.getParameter("maxStops"));
		String create_table_string ="";
		String alter_String ="";
		ArrayList<String> updates = new ArrayList<String>();
		String create_table_string2 = "";
		String alter_String2 = "";
		ArrayList<String> updates2 = new ArrayList<String>();
		
		
		int n = 3;
		LocalDate date = LocalDate.parse(str_date);
		LocalDate min_date;
		LocalDate max_date;
		LocalDate date2 = LocalDate.parse(str_date2);
		LocalDate min_date2;
		LocalDate max_date2;
		Boolean flexible = true;
		String str = ("");
		String str2 = ("");
		Boolean twoWay = false;
		// set up connection to database
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement inter_stmt = con.createStatement();
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		ResultSet result;
		ResultSet result2;
		
	    
		// check for empty inputs
		if (flightType == null || dept_airport.equals("") || arr_airport.equals("") || str_date.equals("")) {
			out.print("Empty Field Detected. Make sure all fields are filled out!");
			//checking tickers, see if customer wants one way or two way, queries change depending
		} else if (flightType.equals("One Way Set Date")) {
			flexible = false;
			min_date = date;
            max_date = date.plusDays(1);
			//Jon query
			
			create_table_string = "CREATE TEMPORARY TABLE flight_options AS SELECT * FROM ";
			for (int i = 1; i <= n+1; i++){
	            String temp_string = "(SELECT f" + Integer.toString(i) + ".flight_num AS 'flight_num" + Integer.toString(i) + 
	            "', f" + Integer.toString(i) +".departure_airport_id AS 'f" + Integer.toString(i) + "_dept_airport', f" +
	            Integer.toString(i) + ".departure_time AS 'f" + Integer.toString(i) + "_dept_time', f" + Integer.toString(i) +
	            ".arrival_airport_id AS 'f" + Integer.toString(i) + "_arr_airport', f" + Integer.toString(i) +".arrival_time AS 'f" +
	            Integer.toString(i) + "_arr_time', f" + Integer.toString(i) + ".seats_remaining AS 'f" + Integer.toString(i) + 
	            "_seats_left', f" + Integer.toString(i) + ".economy_rate AS 'f" + Integer.toString(i) + "_econ_rate'," + " f" +
	            Integer.toString(i) + ".airline_id AS 'f" + Integer.toString(i) + "_airline'"+ "FROM flight f" +
	            Integer.toString(i) + " WHERE f" + Integer.toString(i) + ".departure_time > '" +
	            min_date.toString() + "' AND f" + Integer.toString(i) + ".departure_time < '" + 
	            max_date.toString() + "') t" + Integer.toString(i) + ", ";
	            create_table_string = create_table_string + temp_string;
	        }

	        create_table_string = create_table_string.substring(0, create_table_string.length() - 2);
	        create_table_string = create_table_string + " WHERE f1_dept_airport = '" + dept_airport + "' AND (";
	        
	        for (int i = 1; i <= n + 1; i ++){
	            String temp_string = "";
	            if (i > 1){
	                temp_string = temp_string + "OR f";
	            } else{
	                temp_string = "f";
	            }
	            temp_string = temp_string + Integer.toString(i) + "_arr_airport = '" + arr_airport + "'  ";
	            create_table_string = create_table_string + temp_string; 
	        }
	        
	        create_table_string = create_table_string + ") AND ( f1_arr_airport = '" + arr_airport + "'";

	        String temp_table_final_cond = "";
	        
	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " OR ";
	            for (int j = 1; j <i; j++){
	                
	                String inner_temp_string = "f" + Integer.toString(j) + "_arr_airport = f" + Integer.toString(j + 1) +
	                "_dept_airport AND f" + Integer.toString(j) + "_arr_time < f" + Integer.toString(j + 1) + "_dept_time AND ";
	                temp_string = temp_string + inner_temp_string;

	            }
	            temp_string = temp_string + "f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"'";

	            temp_table_final_cond = temp_table_final_cond + temp_string;
	            
	        }
	        
	        create_table_string = create_table_string + temp_table_final_cond + ");";
	        
	        alter_String = "ALTER TABLE flight_options ";

	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " MODIFY COLUMN flight_num" + Integer.toString(i) + " VARCHAR(5),  MODIFY COLUMN f" +
	            Integer.toString(i) + "_dept_airport CHAR(3), MODIFY COLUMN f" + Integer.toString(i) +
	            "_dept_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_arr_airport CHAR(3), MODIFY COLUMN f" +
	            Integer.toString(i) + "_arr_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_seats_left INT," +
	            "MODIFY COLUMN f" + Integer.toString(i) + "_econ_rate FLOAT," + "MODIFY COLUMN f" + Integer.toString(i) +
	            "_airline CHAR(2),";
	            alter_String = alter_String + temp_string;            
	        }

	        alter_String = alter_String.substring(0, alter_String.length() - 1) + ";";
	        
	        updates = new ArrayList<String>();
	        for (int i = 1; i <= n; i++){
	            String temp_string = "UPDATE flight_options SET ";
	            for (int j = i + 1; j <= n + 1; j++){
	                String inner_temp_string = "flight_num" + Integer.toString(j) + " = NULL, f" + Integer.toString(j) +
	                "_dept_airport = NULL, f" + Integer.toString(j) + "_dept_time = NULL, f" + Integer.toString(j) + 
	                "_arr_airport = NULL, f"  +Integer.toString(j) + "_arr_time = NULL, f" + Integer.toString(j) + 
	                "_seats_left = NULL, f" + Integer.toString(j) + "_econ_rate = 0," + " f" + Integer.toString(j) + 
	                "_airline = NULL, ";
	                temp_string = temp_string + inner_temp_string;
	            }
	            temp_string = temp_string.substring(0, temp_string.length() - 2);
	            temp_string = temp_string + " WHERE f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"';";
	            updates.add(temp_string);
	        }
	        
	        String final_query = "SELECT DISTINCT *, TIMEDIFF(Arrival_Time, f1_dept_time) AS flight_length\n" + //
	                "FROM ( SELECT DISTINCT *, ";
	        for (int i = 1; i <= n + 1; i++){
	            final_query = final_query + "f" + Integer.toString(i) +"_econ_rate +";
	        }
	        final_query = final_query.substring(0, final_query.length() - 1);



	        final_query = final_query + "AS total_fare, ";
	        
	        if (n > 0){
	            String temp_string = " CASE ";
	            for (int i = n + 1; i > 1; i--){
	                temp_string = temp_string + "WHEN f" + Integer.toString(i) + "_arr_time IS NOT NULL THEN f" +
	                Integer.toString(i) +"_arr_time ";
	            }
	            temp_string = temp_string + "ELSE f1_arr_time END AS 'Arrival_Time' ";
	            final_query = final_query + temp_string;
	        } else{
	            String temp_string = "f1_arr_time AS 'Arrival_Time'";
	            final_query = final_query + temp_string;
	        }



	        final_query = final_query + "FROM flight_options) fo;";
	        
			str = final_query;
	
		} else if (flightType.equals("One Way Flex Date")) {
			min_date = date.minusDays(3);
            max_date = date.plusDays(4);
			// Jon query
            create_table_string = "CREATE TEMPORARY TABLE flight_options AS SELECT * FROM ";
			for (int i = 1; i <= n+1; i++){
	            String temp_string = "(SELECT f" + Integer.toString(i) + ".flight_num AS 'flight_num" + Integer.toString(i) + 
	            "', f" + Integer.toString(i) +".departure_airport_id AS 'f" + Integer.toString(i) + "_dept_airport', f" +
	            Integer.toString(i) + ".departure_time AS 'f" + Integer.toString(i) + "_dept_time', f" + Integer.toString(i) +
	            ".arrival_airport_id AS 'f" + Integer.toString(i) + "_arr_airport', f" + Integer.toString(i) +".arrival_time AS 'f" +
	            Integer.toString(i) + "_arr_time', f" + Integer.toString(i) + ".seats_remaining AS 'f" + Integer.toString(i) + 
	            "_seats_left', f" + Integer.toString(i) + ".economy_rate AS 'f" + Integer.toString(i) + "_econ_rate'," + " f" +
	            Integer.toString(i) + ".airline_id AS 'f" + Integer.toString(i) + "_airline'"+ "FROM flight f" +
	            Integer.toString(i) + " WHERE f" + Integer.toString(i) + ".departure_time > '" +
	            min_date.toString() + "' AND f" + Integer.toString(i) + ".departure_time < '" + 
	            max_date.toString() + "') t" + Integer.toString(i) + ", ";
	            create_table_string = create_table_string + temp_string;
	        }

	        create_table_string = create_table_string.substring(0, create_table_string.length() - 2);
	        create_table_string = create_table_string + " WHERE f1_dept_airport = '" + dept_airport + "' AND (";
	        
	        for (int i = 1; i <= n + 1; i ++){
	            String temp_string = "";
	            if (i > 1){
	                temp_string = temp_string + "OR f";
	            } else{
	                temp_string = "f";
	            }
	            temp_string = temp_string + Integer.toString(i) + "_arr_airport = '" + arr_airport + "'  ";
	            create_table_string = create_table_string + temp_string; 
	        }
	        
	        create_table_string = create_table_string + ") AND ( f1_arr_airport = '" + arr_airport + "'";

	        String temp_table_final_cond = "";
	        
	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " OR ";
	            for (int j = 1; j <i; j++){
	                
	                String inner_temp_string = "f" + Integer.toString(j) + "_arr_airport = f" + Integer.toString(j + 1) +
	                "_dept_airport AND f" + Integer.toString(j) + "_arr_time < f" + Integer.toString(j + 1) + "_dept_time AND ";
	                temp_string = temp_string + inner_temp_string;

	            }
	            temp_string = temp_string + "f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"'";

	            temp_table_final_cond = temp_table_final_cond + temp_string;
	            
	        }
	        
	        create_table_string = create_table_string + temp_table_final_cond + ");";
	        
	        alter_String = "ALTER TABLE flight_options ";

	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " MODIFY COLUMN flight_num" + Integer.toString(i) + " VARCHAR(5),  MODIFY COLUMN f" +
	            Integer.toString(i) + "_dept_airport CHAR(3), MODIFY COLUMN f" + Integer.toString(i) +
	            "_dept_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_arr_airport CHAR(3), MODIFY COLUMN f" +
	            Integer.toString(i) + "_arr_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_seats_left INT," +
	            "MODIFY COLUMN f" + Integer.toString(i) + "_econ_rate FLOAT," + "MODIFY COLUMN f" + Integer.toString(i) +
	            "_airline CHAR(2),";
	            alter_String = alter_String + temp_string;            
	        }

	        alter_String = alter_String.substring(0, alter_String.length() - 1) + ";";
	        
	        updates = new ArrayList<String>();
	        for (int i = 1; i <= n; i++){
	            String temp_string = "UPDATE flight_options SET ";
	            for (int j = i + 1; j <= n + 1; j++){
	                String inner_temp_string = "flight_num" + Integer.toString(j) + " = NULL, f" + Integer.toString(j) +
	                "_dept_airport = NULL, f" + Integer.toString(j) + "_dept_time = NULL, f" + Integer.toString(j) + 
	                "_arr_airport = NULL, f"  +Integer.toString(j) + "_arr_time = NULL, f" + Integer.toString(j) + 
	                "_seats_left = NULL, f" + Integer.toString(j) + "_econ_rate = 0," + " f" + Integer.toString(j) + 
	                "_airline = NULL, ";
	                temp_string = temp_string + inner_temp_string;
	            }
	            temp_string = temp_string.substring(0, temp_string.length() - 2);
	            temp_string = temp_string + " WHERE f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"';";
	            updates.add(temp_string);
	        }
	        
	        String final_query = "SELECT DISTINCT *, TIMEDIFF(Arrival_Time, f1_dept_time) AS flight_length\n" + //
	                "FROM ( SELECT DISTINCT *, ";
	        for (int i = 1; i <= n + 1; i++){
	            final_query = final_query + "f" + Integer.toString(i) +"_econ_rate +";
	        }
	        final_query = final_query.substring(0, final_query.length() - 1);



	        final_query = final_query + "AS total_fare, ";
	        
	        if (n > 0){
	            String temp_string = " CASE ";
	            for (int i = n + 1; i > 1; i--){
	                temp_string = temp_string + "WHEN f" + Integer.toString(i) + "_arr_time IS NOT NULL THEN f" +
	                Integer.toString(i) +"_arr_time ";
	            }
	            temp_string = temp_string + "ELSE f1_arr_time END AS 'Arrival_Time' ";
	            final_query = final_query + temp_string;
	        } else{
	            String temp_string = "f1_arr_time AS 'Arrival_Time'";
	            final_query = final_query + temp_string;
	        }



	        final_query = final_query + "FROM flight_options) fo;";
	        
			str = final_query;
		
		} else if (flightType.equals("Two Way Set Date")) {
			if (str_date.equals("")){
				out.print("Empty Field Detected. Make sure the date of the second flight is given!");
			}else{
			flexible = false;
			min_date = date;
            max_date = date.plusDays(1);
            min_date2 = date2;
            max_date2 = date2.plusDays(1);
			//writing 2 queries that you can replace with Jon's algo, one to produce table for way there and one for way back
            create_table_string = "CREATE TEMPORARY TABLE flight_options AS SELECT * FROM ";
			for (int i = 1; i <= n+1; i++){
	            String temp_string = "(SELECT f" + Integer.toString(i) + ".flight_num AS 'flight_num" + Integer.toString(i) + 
	            "', f" + Integer.toString(i) +".departure_airport_id AS 'f" + Integer.toString(i) + "_dept_airport', f" +
	            Integer.toString(i) + ".departure_time AS 'f" + Integer.toString(i) + "_dept_time', f" + Integer.toString(i) +
	            ".arrival_airport_id AS 'f" + Integer.toString(i) + "_arr_airport', f" + Integer.toString(i) +".arrival_time AS 'f" +
	            Integer.toString(i) + "_arr_time', f" + Integer.toString(i) + ".seats_remaining AS 'f" + Integer.toString(i) + 
	            "_seats_left', f" + Integer.toString(i) + ".economy_rate AS 'f" + Integer.toString(i) + "_econ_rate'," + " f" +
	            Integer.toString(i) + ".airline_id AS 'f" + Integer.toString(i) + "_airline'"+ "FROM flight f" +
	            Integer.toString(i) + " WHERE f" + Integer.toString(i) + ".departure_time > '" +
	            min_date.toString() + "' AND f" + Integer.toString(i) + ".departure_time < '" + 
	            max_date.toString() + "') t" + Integer.toString(i) + ", ";
	            create_table_string = create_table_string + temp_string;
	        }

	        create_table_string = create_table_string.substring(0, create_table_string.length() - 2);
	        create_table_string = create_table_string + " WHERE f1_dept_airport = '" + dept_airport + "' AND (";
	        
	        for (int i = 1; i <= n + 1; i ++){
	            String temp_string = "";
	            if (i > 1){
	                temp_string = temp_string + "OR f";
	            } else{
	                temp_string = "f";
	            }
	            temp_string = temp_string + Integer.toString(i) + "_arr_airport = '" + arr_airport + "'  ";
	            create_table_string = create_table_string + temp_string; 
	        }
	        
	        create_table_string = create_table_string + ") AND ( f1_arr_airport = '" + arr_airport + "'";

	        String temp_table_final_cond = "";
	        
	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " OR ";
	            for (int j = 1; j <i; j++){
	                
	                String inner_temp_string = "f" + Integer.toString(j) + "_arr_airport = f" + Integer.toString(j + 1) +
	                "_dept_airport AND f" + Integer.toString(j) + "_arr_time < f" + Integer.toString(j + 1) + "_dept_time AND ";
	                temp_string = temp_string + inner_temp_string;

	            }
	            temp_string = temp_string + "f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"'";

	            temp_table_final_cond = temp_table_final_cond + temp_string;
	            
	        }
	        
	        create_table_string = create_table_string + temp_table_final_cond + ");";
	        
	        alter_String = "ALTER TABLE flight_options ";

	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " MODIFY COLUMN flight_num" + Integer.toString(i) + " VARCHAR(5),  MODIFY COLUMN f" +
	            Integer.toString(i) + "_dept_airport CHAR(3), MODIFY COLUMN f" + Integer.toString(i) +
	            "_dept_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_arr_airport CHAR(3), MODIFY COLUMN f" +
	            Integer.toString(i) + "_arr_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_seats_left INT," +
	            "MODIFY COLUMN f" + Integer.toString(i) + "_econ_rate FLOAT," + "MODIFY COLUMN f" + Integer.toString(i) +
	            "_airline CHAR(2),";
	            alter_String = alter_String + temp_string;            
	        }

	        alter_String = alter_String.substring(0, alter_String.length() - 1) + ";";
	        
	        updates = new ArrayList<String>();
	        for (int i = 1; i <= n; i++){
	            String temp_string = "UPDATE flight_options SET ";
	            for (int j = i + 1; j <= n + 1; j++){
	                String inner_temp_string = "flight_num" + Integer.toString(j) + " = NULL, f" + Integer.toString(j) +
	                "_dept_airport = NULL, f" + Integer.toString(j) + "_dept_time = NULL, f" + Integer.toString(j) + 
	                "_arr_airport = NULL, f"  +Integer.toString(j) + "_arr_time = NULL, f" + Integer.toString(j) + 
	                "_seats_left = NULL, f" + Integer.toString(j) + "_econ_rate = 0," + " f" + Integer.toString(j) + 
	                "_airline = NULL, ";
	                temp_string = temp_string + inner_temp_string;
	            }
	            temp_string = temp_string.substring(0, temp_string.length() - 2);
	            temp_string = temp_string + " WHERE f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"';";
	            updates.add(temp_string);
	        }
	        
	        String final_query = "SELECT DISTINCT *, TIMEDIFF(Arrival_Time, f1_dept_time) AS flight_length\n" + //
	                "FROM ( SELECT DISTINCT *, ";
	        for (int i = 1; i <= n + 1; i++){
	            final_query = final_query + "f" + Integer.toString(i) +"_econ_rate +";
	        }
	        final_query = final_query.substring(0, final_query.length() - 1);



	        final_query = final_query + "AS total_fare, ";
	        
	        if (n > 0){
	            String temp_string = " CASE ";
	            for (int i = n + 1; i > 1; i--){
	                temp_string = temp_string + "WHEN f" + Integer.toString(i) + "_arr_time IS NOT NULL THEN f" +
	                Integer.toString(i) +"_arr_time ";
	            }
	            temp_string = temp_string + "ELSE f1_arr_time END AS 'Arrival_Time' ";
	            final_query = final_query + temp_string;
	        } else{
	            String temp_string = "f1_arr_time AS 'Arrival_Time'";
	            final_query = final_query + temp_string;
	        }



	        final_query = final_query + "FROM flight_options) fo;";
	        
			str = final_query;
			
			
			
			
			
			
			
			create_table_string2 = "CREATE TEMPORARY TABLE flight_options2 AS SELECT * FROM ";
			for (int i = 1; i <= n+1; i++){
	            String temp_string = "(SELECT f" + Integer.toString(i) + ".flight_num AS 'flight_num" + Integer.toString(i) + 
	            "', f" + Integer.toString(i) +".departure_airport_id AS 'f" + Integer.toString(i) + "_dept_airport', f" +
	            Integer.toString(i) + ".departure_time AS 'f" + Integer.toString(i) + "_dept_time', f" + Integer.toString(i) +
	            ".arrival_airport_id AS 'f" + Integer.toString(i) + "_arr_airport', f" + Integer.toString(i) +".arrival_time AS 'f" +
	            Integer.toString(i) + "_arr_time', f" + Integer.toString(i) + ".seats_remaining AS 'f" + Integer.toString(i) + 
	            "_seats_left', f" + Integer.toString(i) + ".economy_rate AS 'f" + Integer.toString(i) + "_econ_rate'," + " f" +
	            Integer.toString(i) + ".airline_id AS 'f" + Integer.toString(i) + "_airline'"+ "FROM flight f" +
	            Integer.toString(i) + " WHERE f" + Integer.toString(i) + ".departure_time > '" +
	            min_date2.toString() + "' AND f" + Integer.toString(i) + ".departure_time < '" + 
	            max_date2.toString() + "') t" + Integer.toString(i) + ", ";
	            create_table_string2 = create_table_string2 + temp_string;
	        }

	        create_table_string2 = create_table_string2.substring(0, create_table_string2.length() - 2);
	        create_table_string2 = create_table_string2 + " WHERE f1_dept_airport = '" + dept_airport2 + "' AND (";
	        
	        for (int i = 1; i <= n + 1; i ++){
	            String temp_string = "";
	            if (i > 1){
	                temp_string = temp_string + "OR f";
	            } else{
	                temp_string = "f";
	            }
	            temp_string = temp_string + Integer.toString(i) + "_arr_airport = '" + arr_airport2 + "'  ";
	            create_table_string2 = create_table_string2 + temp_string; 
	        }
	        
	        create_table_string2 = create_table_string2 + ") AND ( f1_arr_airport = '" + arr_airport2 + "'";

	        String temp_table_final_cond2 = "";
	        
	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " OR ";
	            for (int j = 1; j <i; j++){
	                
	                String inner_temp_string = "f" + Integer.toString(j) + "_arr_airport = f" + Integer.toString(j + 1) +
	                "_dept_airport AND f" + Integer.toString(j) + "_arr_time < f" + Integer.toString(j + 1) + "_dept_time AND ";
	                temp_string = temp_string + inner_temp_string;

	            }
	            temp_string = temp_string + "f" + Integer.toString(i) + "_arr_airport = '" + arr_airport2 +"'";

	            temp_table_final_cond2 = temp_table_final_cond2 + temp_string;
	            
	        }
	        
	        create_table_string2 = create_table_string2 + temp_table_final_cond2 + ");";
	        
	        alter_String2 = "ALTER TABLE flight_options2 ";

	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " MODIFY COLUMN flight_num" + Integer.toString(i) + " VARCHAR(5),  MODIFY COLUMN f" +
	            Integer.toString(i) + "_dept_airport CHAR(3), MODIFY COLUMN f" + Integer.toString(i) +
	            "_dept_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_arr_airport CHAR(3), MODIFY COLUMN f" +
	            Integer.toString(i) + "_arr_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_seats_left INT," +
	            "MODIFY COLUMN f" + Integer.toString(i) + "_econ_rate FLOAT," + "MODIFY COLUMN f" + Integer.toString(i) +
	            "_airline CHAR(2),";
	            alter_String2 = alter_String2 + temp_string;            
	        }

	        alter_String2 = alter_String2.substring(0, alter_String2.length() - 1) + ";";
	        
	        updates2 = new ArrayList<String>();
	        for (int i = 1; i <= n; i++){
	            String temp_string = "UPDATE flight_options2 SET ";
	            for (int j = i + 1; j <= n + 1; j++){
	                String inner_temp_string = "flight_num" + Integer.toString(j) + " = NULL, f" + Integer.toString(j) +
	                "_dept_airport = NULL, f" + Integer.toString(j) + "_dept_time = NULL, f" + Integer.toString(j) + 
	                "_arr_airport = NULL, f"  +Integer.toString(j) + "_arr_time = NULL, f" + Integer.toString(j) + 
	                "_seats_left = NULL, f" + Integer.toString(j) + "_econ_rate = 0," + " f" + Integer.toString(j) + 
	                "_airline = NULL, ";
	                temp_string = temp_string + inner_temp_string;
	            }
	            temp_string = temp_string.substring(0, temp_string.length() - 2);
	            temp_string = temp_string + " WHERE f" + Integer.toString(i) + "_arr_airport = '" + arr_airport2 +"';";
	            updates2.add(temp_string);
	        }
	        
	        String final_query2 = "SELECT DISTINCT *, TIMEDIFF(Arrival_Time, f1_dept_time) AS flight_length" + 
	                " FROM ( SELECT DISTINCT *, ";
	        for (int i = 1; i <= n + 1; i++){
	            final_query2 = final_query2 + "f" + Integer.toString(i) +"_econ_rate +";
	        }
	        final_query2 = final_query2.substring(0, final_query2.length() - 1);



	        final_query2 = final_query2 + "AS total_fare, ";
	        
	        if (n > 0){
	            String temp_string = " CASE ";
	            for (int i = n + 1; i > 1; i--){
	                temp_string = temp_string + "WHEN f" + Integer.toString(i) + "_arr_time IS NOT NULL THEN f" +
	                Integer.toString(i) +"_arr_time ";
	            }
	            temp_string = temp_string + "ELSE f1_arr_time END AS 'Arrival_Time' ";
	            final_query2 = final_query2 + temp_string;
	        } else{
	            String temp_string = "f1_arr_time AS 'Arrival_Time'";
	            final_query2 = final_query2 + temp_string;
	        }



	        final_query2 = final_query2 + "FROM flight_options2) fo;";
	        
			str2 = final_query2;
			
			}
					
		} else if (flightType.equals("Two Way Flex Date")) {
			if (str_date.equals("")){
				out.print("Empty Field Detected. Make sure the date of the second flight is given!");
			}else{
			min_date = date.minusDays(3);
            max_date = date.plusDays(4);
            min_date2 = date2.minusDays(3);
            max_date2 = date2.plusDays(4);
            create_table_string = "CREATE TEMPORARY TABLE flight_options AS SELECT * FROM ";
			for (int i = 1; i <= n+1; i++){
	            String temp_string = "(SELECT f" + Integer.toString(i) + ".flight_num AS 'flight_num" + Integer.toString(i) + 
	            "', f" + Integer.toString(i) +".departure_airport_id AS 'f" + Integer.toString(i) + "_dept_airport', f" +
	            Integer.toString(i) + ".departure_time AS 'f" + Integer.toString(i) + "_dept_time', f" + Integer.toString(i) +
	            ".arrival_airport_id AS 'f" + Integer.toString(i) + "_arr_airport', f" + Integer.toString(i) +".arrival_time AS 'f" +
	            Integer.toString(i) + "_arr_time', f" + Integer.toString(i) + ".seats_remaining AS 'f" + Integer.toString(i) + 
	            "_seats_left', f" + Integer.toString(i) + ".economy_rate AS 'f" + Integer.toString(i) + "_econ_rate'," + " f" +
	            Integer.toString(i) + ".airline_id AS 'f" + Integer.toString(i) + "_airline'"+ "FROM flight f" +
	            Integer.toString(i) + " WHERE f" + Integer.toString(i) + ".departure_time > '" +
	            min_date.toString() + "' AND f" + Integer.toString(i) + ".departure_time < '" + 
	            max_date.toString() + "') t" + Integer.toString(i) + ", ";
	            create_table_string = create_table_string + temp_string;
	        }

	        create_table_string = create_table_string.substring(0, create_table_string.length() - 2);
	        create_table_string = create_table_string + " WHERE f1_dept_airport = '" + dept_airport + "' AND (";
	        
	        for (int i = 1; i <= n + 1; i ++){
	            String temp_string = "";
	            if (i > 1){
	                temp_string = temp_string + "OR f";
	            } else{
	                temp_string = "f";
	            }
	            temp_string = temp_string + Integer.toString(i) + "_arr_airport = '" + arr_airport + "'  ";
	            create_table_string = create_table_string + temp_string; 
	        }
	        
	        create_table_string = create_table_string + ") AND ( f1_arr_airport = '" + arr_airport + "'";

	        String temp_table_final_cond = "";
	        
	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " OR ";
	            for (int j = 1; j <i; j++){
	                
	                String inner_temp_string = "f" + Integer.toString(j) + "_arr_airport = f" + Integer.toString(j + 1) +
	                "_dept_airport AND f" + Integer.toString(j) + "_arr_time < f" + Integer.toString(j + 1) + "_dept_time AND ";
	                temp_string = temp_string + inner_temp_string;

	            }
	            temp_string = temp_string + "f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"'";

	            temp_table_final_cond = temp_table_final_cond + temp_string;
	            
	        }
	        
	        create_table_string = create_table_string + temp_table_final_cond + ");";
	        
	        alter_String = "ALTER TABLE flight_options ";

	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " MODIFY COLUMN flight_num" + Integer.toString(i) + " VARCHAR(5),  MODIFY COLUMN f" +
	            Integer.toString(i) + "_dept_airport CHAR(3), MODIFY COLUMN f" + Integer.toString(i) +
	            "_dept_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_arr_airport CHAR(3), MODIFY COLUMN f" +
	            Integer.toString(i) + "_arr_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_seats_left INT," +
	            "MODIFY COLUMN f" + Integer.toString(i) + "_econ_rate FLOAT," + "MODIFY COLUMN f" + Integer.toString(i) +
	            "_airline CHAR(2),";
	            alter_String = alter_String + temp_string;            
	        }

	        alter_String = alter_String.substring(0, alter_String.length() - 1) + ";";
	        
	        updates = new ArrayList<String>();
	        for (int i = 1; i <= n; i++){
	            String temp_string = "UPDATE flight_options SET ";
	            for (int j = i + 1; j <= n + 1; j++){
	                String inner_temp_string = "flight_num" + Integer.toString(j) + " = NULL, f" + Integer.toString(j) +
	                "_dept_airport = NULL, f" + Integer.toString(j) + "_dept_time = NULL, f" + Integer.toString(j) + 
	                "_arr_airport = NULL, f"  +Integer.toString(j) + "_arr_time = NULL, f" + Integer.toString(j) + 
	                "_seats_left = NULL, f" + Integer.toString(j) + "_econ_rate = 0," + " f" + Integer.toString(j) + 
	                "_airline = NULL, ";
	                temp_string = temp_string + inner_temp_string;
	            }
	            temp_string = temp_string.substring(0, temp_string.length() - 2);
	            temp_string = temp_string + " WHERE f" + Integer.toString(i) + "_arr_airport = '" + arr_airport +"';";
	            updates.add(temp_string);
	        }
	        
	        String final_query = "SELECT DISTINCT *, TIMEDIFF(Arrival_Time, f1_dept_time) AS flight_length\n" + //
	                "FROM ( SELECT DISTINCT *, ";
	        for (int i = 1; i <= n + 1; i++){
	            final_query = final_query + "f" + Integer.toString(i) +"_econ_rate +";
	        }
	        final_query = final_query.substring(0, final_query.length() - 1);



	        final_query = final_query + "AS total_fare, ";
	        
	        if (n > 0){
	            String temp_string = " CASE ";
	            for (int i = n + 1; i > 1; i--){
	                temp_string = temp_string + "WHEN f" + Integer.toString(i) + "_arr_time IS NOT NULL THEN f" +
	                Integer.toString(i) +"_arr_time ";
	            }
	            temp_string = temp_string + "ELSE f1_arr_time END AS 'Arrival_Time' ";
	            final_query = final_query + temp_string;
	        } else{
	            String temp_string = "f1_arr_time AS 'Arrival_Time'";
	            final_query = final_query + temp_string;
	        }



	        final_query = final_query + "FROM flight_options) fo;";
	        
			str = final_query;
			
			
			
			
			
			
			
			create_table_string2 = "CREATE TEMPORARY TABLE flight_options2 AS SELECT * FROM ";
			for (int i = 1; i <= n+1; i++){
	            String temp_string = "(SELECT f" + Integer.toString(i) + ".flight_num AS 'flight_num" + Integer.toString(i) + 
	            "', f" + Integer.toString(i) +".departure_airport_id AS 'f" + Integer.toString(i) + "_dept_airport', f" +
	            Integer.toString(i) + ".departure_time AS 'f" + Integer.toString(i) + "_dept_time', f" + Integer.toString(i) +
	            ".arrival_airport_id AS 'f" + Integer.toString(i) + "_arr_airport', f" + Integer.toString(i) +".arrival_time AS 'f" +
	            Integer.toString(i) + "_arr_time', f" + Integer.toString(i) + ".seats_remaining AS 'f" + Integer.toString(i) + 
	            "_seats_left', f" + Integer.toString(i) + ".economy_rate AS 'f" + Integer.toString(i) + "_econ_rate'," + " f" +
	            Integer.toString(i) + ".airline_id AS 'f" + Integer.toString(i) + "_airline'"+ "FROM flight f" +
	            Integer.toString(i) + " WHERE f" + Integer.toString(i) + ".departure_time > '" +
	            min_date2.toString() + "' AND f" + Integer.toString(i) + ".departure_time < '" + 
	            max_date2.toString() + "') t" + Integer.toString(i) + ", ";
	            create_table_string2 = create_table_string2 + temp_string;
	        }

	        create_table_string2 = create_table_string2.substring(0, create_table_string2.length() - 2);
	        create_table_string2 = create_table_string2 + " WHERE f1_dept_airport = '" + dept_airport2 + "' AND (";
	        
	        for (int i = 1; i <= n + 1; i ++){
	            String temp_string = "";
	            if (i > 1){
	                temp_string = temp_string + "OR f";
	            } else{
	                temp_string = "f";
	            }
	            temp_string = temp_string + Integer.toString(i) + "_arr_airport = '" + arr_airport2 + "'  ";
	            create_table_string2 = create_table_string2 + temp_string; 
	        }
	        
	        create_table_string2 = create_table_string2 + ") AND ( f1_arr_airport = '" + arr_airport2 + "'";

	        String temp_table_final_cond2 = "";
	        
	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " OR ";
	            for (int j = 1; j <i; j++){
	                
	                String inner_temp_string = "f" + Integer.toString(j) + "_arr_airport = f" + Integer.toString(j + 1) +
	                "_dept_airport AND f" + Integer.toString(j) + "_arr_time < f" + Integer.toString(j + 1) + "_dept_time AND ";
	                temp_string = temp_string + inner_temp_string;

	            }
	            temp_string = temp_string + "f" + Integer.toString(i) + "_arr_airport = '" + arr_airport2 +"'";

	            temp_table_final_cond2 = temp_table_final_cond2 + temp_string;
	            
	        }
	        
	        create_table_string2 = create_table_string2 + temp_table_final_cond2 + ");";
	        
	        alter_String2 = "ALTER TABLE flight_options2 ";

	        for (int i = 2; i <= n + 1; i++){
	            String temp_string = " MODIFY COLUMN flight_num" + Integer.toString(i) + " VARCHAR(5),  MODIFY COLUMN f" +
	            Integer.toString(i) + "_dept_airport CHAR(3), MODIFY COLUMN f" + Integer.toString(i) +
	            "_dept_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_arr_airport CHAR(3), MODIFY COLUMN f" +
	            Integer.toString(i) + "_arr_time DATETIME, MODIFY COLUMN f" + Integer.toString(i) + "_seats_left INT," +
	            "MODIFY COLUMN f" + Integer.toString(i) + "_econ_rate FLOAT," + "MODIFY COLUMN f" + Integer.toString(i) +
	            "_airline CHAR(2),";
	            alter_String2 = alter_String2 + temp_string;            
	        }

	        alter_String2 = alter_String2.substring(0, alter_String2.length() - 1) + ";";
	        
	        updates2 = new ArrayList<String>();
	        for (int i = 1; i <= n; i++){
	            String temp_string = "UPDATE flight_options2 SET ";
	            for (int j = i + 1; j <= n + 1; j++){
	                String inner_temp_string = "flight_num" + Integer.toString(j) + " = NULL, f" + Integer.toString(j) +
	                "_dept_airport = NULL, f" + Integer.toString(j) + "_dept_time = NULL, f" + Integer.toString(j) + 
	                "_arr_airport = NULL, f"  +Integer.toString(j) + "_arr_time = NULL, f" + Integer.toString(j) + 
	                "_seats_left = NULL, f" + Integer.toString(j) + "_econ_rate = 0," + " f" + Integer.toString(j) + 
	                "_airline = NULL, ";
	                temp_string = temp_string + inner_temp_string;
	            }
	            temp_string = temp_string.substring(0, temp_string.length() - 2);
	            temp_string = temp_string + " WHERE f" + Integer.toString(i) + "_arr_airport = '" + arr_airport2 +"';";
	            updates2.add(temp_string);
	        }
	        
	        String final_query2 = "SELECT DISTINCT *, TIMEDIFF(Arrival_Time, f1_dept_time) AS flight_length" + 
	                " FROM ( SELECT DISTINCT *, ";
	        for (int i = 1; i <= n + 1; i++){
	            final_query2 = final_query2 + "f" + Integer.toString(i) +"_econ_rate +";
	        }
	        final_query2 = final_query2.substring(0, final_query2.length() - 1);



	        final_query2 = final_query2 + "AS total_fare, ";
	        
	        if (n > 0){
	            String temp_string = " CASE ";
	            for (int i = n + 1; i > 1; i--){
	                temp_string = temp_string + "WHEN f" + Integer.toString(i) + "_arr_time IS NOT NULL THEN f" +
	                Integer.toString(i) +"_arr_time ";
	            }
	            temp_string = temp_string + "ELSE f1_arr_time END AS 'Arrival_Time' ";
	            final_query2 = final_query2 + temp_string;
	        } else{
	            String temp_string = "f1_arr_time AS 'Arrival_Time'";
	            final_query2 = final_query2 + temp_string;
	        }



	        final_query2 = final_query2 + "FROM flight_options2) fo;";
	        
			str2 = final_query2;
		}
		}
		
		inter_stmt.executeQuery("DROP TABLE IF EXISTS flight_options;");
		inter_stmt.executeQuery(create_table_string);
		inter_stmt.executeQuery(alter_String);
		for (String update : updates){
			inter_stmt.executeQuery(update);
		}
		
		
		result = stmt.executeQuery(str);
		
		
		
		// NEED TO ADD TABLE, AND IF STATEMENT FOR SECOND TABLE IF TWO WAY SELECTED
		
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
        if (twoWay) {
        	inter_stmt.executeQuery("DROP TABLE IF EXISTS flight_options2;");
			inter_stmt.executeQuery(create_table_string2);
			inter_stmt.executeQuery(alter_String2);
			for (String update : updates2){
				inter_stmt.executeQuery(update);
			}
			result2 = stmt2.executeQuery(str2);
        	ResultSetMetaData metaData2 = result2.getMetaData();
    		int columnCount2 = metaData2.getColumnCount();
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
			</tbody>
			</table>
    <%
        } 
%>

<%
		
		
		con.close();

		
	} catch(Exception e){
		out.print(e);
	}
	
	
%>
</body>
</html> 