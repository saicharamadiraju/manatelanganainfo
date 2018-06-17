<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telangana</title>
<style type="text/css">
#donorsTable {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 60%;
}

#donorsTable td, donorsTable th {
    border: 1px solid #ddd;
    padding: 4px;
}

#donorsTable tr:nth-child(even){background-color: #f2f2f2;}
#donorsTable tr:nth-child(odd){background-color: #f2f2f2;}

#donorsTable tr:hover {background-color: #ddd;}

#donorsTable th {
    padding-top: 10px;
    padding-bottom: 10px;
    text-align: left;
    background-color: black;
    color: white;
}
</style>

</head>
<body>

	<table id="donorsTable">
	<tr>
		<th>Donor Name</th>
		<th>Age</th>
		<th>Gender</th>
		<th>Contact Number</th>
		<th>Address</th>
	</tr>
	
			<%
 		ResultSet rs = null;
			try {
			String districtName = (String)request.getAttribute("DistrictName");
			String bloodgroup = (String)request.getAttribute("bloodgroup");
			
			DataManager manaer = new DataManager();
			String query = "SELECT DonorName,phone,sex,age,place FROM content.donors WHERE " + 
						"districtname LIKE '" + districtName + "' AND bloodgroup LIKE '" + bloodgroup +"'";
							
			System.out.println(query);
			rs = manaer.getResultSet(query);
			
			while(rs.next()) {
				String DonorName = rs.getString("DonorName");
				String phone = rs.getString("phone");
				String gender = rs.getString("sex");
				int age = rs.getInt("age");
				String place = rs.getString("place");
				System.out.println(DonorName);
			%>

			<tr>
				<td><%= DonorName%></td>
				<td><%= age%></td>
				<td><%= gender%></td>
				<td><%= phone%></td>
				<td><%= place%></td>
			</tr>
		
		<%
			}
			
			} finally {
				try {
					if(rs != null)
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}	
			}
		%>
		</table>
</body>	
</html>