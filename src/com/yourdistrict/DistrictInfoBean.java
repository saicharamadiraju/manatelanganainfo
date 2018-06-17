package com.yourdistrict;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.jsoup.helper.StringUtil;

public class DistrictInfoBean {
	private final String WEBWB = "webwb";
	private final String JSP = "jsp";
	private final String SLASH = "/";
	private final String DOT = ".";

	public void processRequest(HttpServletRequest aRequest,HttpServletResponse aResponse) {
		String queryString = aRequest.getQueryString();
		Map<String,String> queryParams = parseQueryStringAndPopulateMap(queryString);

		insertDataRequest(aRequest, aResponse , queryParams);
		
//		handleSelectRequest(aRequest, aResponse , queryParams);
		
		handleDistrictDisplay(aRequest, aResponse, queryParams);
		
		handleImageDisplay(aRequest, aResponse, queryParams);
		
		handleJSPDisplay(aRequest, aResponse, queryParams);
	}

	private void insertDataRequest(HttpServletRequest aRequest, HttpServletResponse aResponse,
			Map<String, String> queryParams) {
		if(!queryParams.containsKey("insertData")) return;
		StringBuffer columns = new StringBuffer();
		StringBuffer values = new StringBuffer();
		List<String> preparedStmtValues = new ArrayList<>();
		
		Iterator it = queryParams.keySet().iterator();
		while(it.hasNext()) {
			String key = (String)it.next();
			
			if(key.equalsIgnoreCase("tablename") || key.equalsIgnoreCase("insertdata")) {
				continue;
			}
			
			String value = queryParams.get(key);
			
			columns.append(key);
			values.append("?");
			preparedStmtValues.add(value);	
			if(it.hasNext()) {
				columns.append(",");
				values.append(",");
			}
		}
		String tableName = (String)queryParams.get("tablename");
		String sql = "INSERT INTO " + tableName + " (" + columns +") values(" + values + ")";
		System.out.println(sql);
		DataManager dm = new DataManager();
		try {
			PreparedStatement stmt = dm.getDBConnection().prepareStatement(sql);
			int i = 1;
			for(String a : preparedStmtValues) {
				stmt.setString(i++ , a );	
			}
			
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	private void handleSelectRequest(HttpServletRequest aRequest, HttpServletResponse aResponse, Map aQueryParams) {
		boolean isSelectQueryRequest = aQueryParams.containsKey("selectQuery");
		
		if(isSelectQueryRequest) {
			aQueryParams.remove("selectQuery");
			String columnsToRetrieve = (String) aQueryParams.get("ColumnToRetrieve");
			String[] columns = columnsToRetrieve.split(",");
			
			String query = generateSelectQueryFromQueryParams(aQueryParams);
			DataManager dm = new DataManager();
			ResultSet rs = dm.getResultSet(query);
			
			String htmlResponse = "<html> <head> </head> <body>";
			try {
				while(rs.next()) {
					for(String column : columns) {
						
						System.out.println(rs.getString(column));
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			htmlResponse += "</body></html>";
		}
	}

	private void sendRedirect(HttpServletRequest aRequest,HttpServletResponse aResponse , String redirectToLocation) {
		redirectToLocation = SLASH + WEBWB + SLASH + JSP + SLASH + redirectToLocation;
		System.out.println("Redirectin  to : " + redirectToLocation);

		new ResultDispatcher().redirectRequestToJSP(aRequest,aResponse,redirectToLocation);
	}
	
	
	private void handleDistrictDisplay(HttpServletRequest aRequest, HttpServletResponse aResponse , Map queryParams) {
		String districtName = null;
		String districtParamValue = (String) queryParams.get("District");

		if(!StringUtil.isBlank(districtParamValue) && districtParamValue.equalsIgnoreCase("true")) {
			districtName = (String) queryParams.get("DistrictName");
			aRequest.setAttribute("DistrictName", districtName);
			String redirectToLocation = "DistrictInfo" + DOT + JSP;
			sendRedirect(aRequest , aResponse , redirectToLocation);
		}
	}
	
	private void handleJSPDisplay(HttpServletRequest aRequest, HttpServletResponse aResponse , Map queryParams) {
		String instanceName = (String) queryParams.get("instance");
		String originalURL = aRequest.getRequestURI();
		String queryURL = aRequest.getQueryString();
		aRequest.setAttribute("ActualURL",originalURL + "?"+queryURL);
		if(!StringUtil.isBlank(instanceName)) {
			Iterator it = queryParams.keySet().iterator();
			while(it.hasNext()) {
				String key = (String)it.next();
				String value = (String)queryParams.get(key);
				
				aRequest.setAttribute(key, value);
			}
			
			sendRedirect(aRequest , aResponse , instanceName);
		}
	}
	
	private void handleImageDisplay(HttpServletRequest aRequest, HttpServletResponse aResponse , Map queryParams) {
		String imageParamValue = (String) queryParams.get("image");
		if(!StringUtil.isBlank(imageParamValue) && imageParamValue.equalsIgnoreCase("true")) {
			//Read Imae from database
			
			Blob image = null;
			byte[ ] imgData = null ;
			DataManager manaer = new DataManager();
			String query = generateSelectQueryFromQueryParams(queryParams);
							
			ResultSet rs = manaer.getResultSet(query);
			try {
				if (rs.next()) {
					image = rs.getBlob(1);
					imgData = image.getBytes(1,(int)image.length());
				}
				
				aResponse.setContentType("image/jpg");
				OutputStream o = aResponse.getOutputStream();
				o.write(imgData);
				o.flush();
				o.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	}
	
	private String generateSelectQueryFromQueryParams(Map queryParams) {
		String query = "SELECT " + queryParams.get("ColumnToRetrieve") + " FROM content." + queryParams.get("TableName")  ;
		
		int i = 1;
		String key = "CondProp";
		String value = "CondPropValue";
		boolean first = true;
		do {
			if(queryParams.containsKey(key + i)) {
				if(first) {
					query += " WHERE ";
					first = false;
				}
				query += (String)queryParams.get(key + i) +  " LIKE '" +  (String)queryParams.get(value + i) + "'";
				i++;
				if(queryParams.containsKey(key + i)) {
					query += " AND ";
				}
			} else {
				break;
			}
		} while(true);
		
		return query;
	}
	@Deprecated
	private void processRequestHereItself(HttpServletRequest request) {
		String selectedDistrict = request.getParameter("selectedDistrict");
		String leaderName = request.getParameter("leaderName");
		String selectedDesignation = request.getParameter("selectedDesignation");

		InputStream is = null;

		Part filePart;
		try {
			filePart = request.getPart("leaderImage");


			if(filePart != null) {
				System.out.println(filePart.getSize());
				is = filePart.getInputStream();
			}

			System.out.println(selectedDistrict);
			System.out.println(leaderName);
			System.out.println(selectedDesignation);

			DataManager dm = new DataManager();
			dm.insertData("leadersdata", new String[]{"districtname","leadername","leaderdesignation"}, new Object[]{selectedDistrict,leaderName,selectedDesignation},is);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}
	
	private Map<String,String> parseQueryStringAndPopulateMap(String aQueryString) {
		try {
			aQueryString = URLDecoder.decode(aQueryString, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String,String> queryparams = new HashMap<>();
		String[] parts = new String[2];
		String[] params = aQueryString.split("&");
		
		for(String param : params) {
			parts = param.split("=");
			queryparams.put(parts[0], parts[1]);
		}
		return queryparams;
	}
}
