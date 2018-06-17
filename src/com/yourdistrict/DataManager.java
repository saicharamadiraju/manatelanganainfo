package com.yourdistrict;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataManager {

	private Connection gInstance;
	private String host = "jdbc:mysql://34.203.220.176:3306/content";
	private String JDBC_DRIVER = "com.mysql.jdbc.Driver"; 
	private String userName = "saicharan";
	private String password = "saicharan";
	Logger oLog = Logger.getLogger(DataManager.class.getName());

	public Connection getDBConnection() {
		Connection con = null;		
		if(gInstance != null) {
			con = gInstance;
		} else {
			try {
				Class.forName(JDBC_DRIVER);
				con = DriverManager.getConnection(host, userName, password);
			} catch (SQLException e) {
				oLog.log(Level.SEVERE, "Not able to get a connection");
			} catch (ClassNotFoundException e) {
				oLog.log(Level.SEVERE, "JDBC driver Class not found");
			}
		}
		return con;
	}

	public ResultSet getResultSet(String tableName, String[] columnNames){
		DataManager dm = new DataManager();
		Connection con = dm.getDBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();

			String sql = "SELECT ";
			for(int i=0 ; i< columnNames.length; i++) {
				String columnName = columnNames[i];
				sql += columnName;
				if(!(i+1 == columnNames.length)) {
					sql += ",";
				}
			}
			sql += " FROM "+ tableName;

			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet getResultSet(String tableName, String[] columnNames, String whereConditionProp , String whereCondValue) {
		DataManager dm = new DataManager();
		Connection con = dm.getDBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();

			String sql = "SELECT ";
			for(int i=0 ; i< columnNames.length; i++) {
				String columnName = columnNames[i];
				sql += columnName;
				if(!(i+1 == columnNames.length)) {
					sql += ",";
				}
			}
			sql += " FROM "+ tableName;

			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet getResultSet(String query) {
		DataManager dm = new DataManager();
		Connection con = dm.getDBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();

			rs = stmt.executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public void insertData(String tableName , String[] columnNames, Object[] columnValues,InputStream is) {
		DataManager dm = new DataManager();
		Connection con = dm.getDBConnection();
		try {
			String sql = "INSERT INTO " + tableName + " ( ";

			for(int i=0; i < columnNames.length;i++) {
				String columnName = columnNames[i];
				sql += columnName;
				if(!(i+1 == columnNames.length)) {
					sql += ",";
				}
			}

			sql += " ) VALUES (";

			for(int i=0; i < columnValues.length;i++) {
				sql += "?";
				if(!(i+1 == columnValues.length)) {
					sql += ",";
				}
			}

			sql += " )";
			
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, (String)columnValues[0]);
			ps.setString(2, (String)columnValues[1]);
			ps.setString(3, (String)columnValues[2]);
			if(is != null) {
				ps.setBlob(4, is);
			}
			
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String readInput(InputStream is){
	    BufferedReader br=null;
	    StringBuilder sb= new StringBuilder();

	    String linea;


	    try {
	        br= new BufferedReader(new InputStreamReader(is));
	        while((linea=br.readLine())!= null){
	            sb.append(linea);
	        }
	    } catch (IOException ex) {
	        ex.printStackTrace();
	    } finally{
	        if(br!=null){
	            try {
	                br.close();
	            } catch (IOException ex) {
	                ex.printStackTrace();
	            }
	        }
	    }

	    return sb.toString();

	}
}
