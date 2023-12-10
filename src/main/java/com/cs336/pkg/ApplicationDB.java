package com.cs336.pkg;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {
	
	public ApplicationDB(){
		
	}

	public Connection getConnection(){
		
		//Create a connection string
		String connectionUrl = "jdbc:mysql://localhost:3306/ReservationSystem";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	

	public static void main(String[] args) {
	    ApplicationDB dao = new ApplicationDB();
	    Connection connection = dao.getConnection();

	    try {
	        // Perform a simple query to test the connection
	        Statement statement = connection.createStatement();
	        ResultSet resultSet = statement.executeQuery("SELECT * FROM admin");

	        // Process the result set if needed
	        while (resultSet.next()) {
	            // Do something with the data
	            String columnName = resultSet.getString("adminusername");
	            System.out.println(columnName);
	        }

	        // Close the result set and statement
	        resultSet.close();
	        statement.close();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // Close the connection
	        dao.closeConnection(connection);
	    }
	}

	
	

}
