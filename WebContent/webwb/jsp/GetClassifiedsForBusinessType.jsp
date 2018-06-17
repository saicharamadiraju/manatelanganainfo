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
</head>
<body>
	<br/>
	<table border="1px" bordercolor="black">
			<%
 		ResultSet rs = null;
			try {
			String districtName = (String)request.getAttribute("DistrictName");
			String businessType = (String)request.getAttribute("businesstype");
			
			DataManager manaer = new DataManager();
			String query = "SELECT emailid,contactnumber,contactname,address FROM content.classifiedsdata WHERE " + 
						"districtname LIKE '" + districtName + "' AND businesstype LIKE '" + businessType +"'";
							
			rs = manaer.getResultSet(query);
			
			while(rs.next()) {
				String emailid = rs.getString("emailid");
				String contactnumber = rs.getString("contactnumber");
				String contactname = rs.getString("contactname");
				String address = rs.getString("address");
				String classifiedimage = "./StateInfo?image=true&CondProp3=DistrictName&CondPropValue3=" + districtName + "&CondProp1=contactname&CondPropValue1=" + contactname +
										"&CondProp2=businesstype&CondPropValue2=" + businessType + "&TableName=classifiedsdata&ColumnToRetrieve=" + "classifiedimage"; 
			%>

			<tr>
				<td class="imaOfClassified">
					<img id="ClassifiedImage" src="<%=classifiedimage%>" width="350px" height="350px">
				</td>
			</tr>
			<tr>	
				<td class="nameOfMP">
					<table>
						<tr>
							<td>
								Contact Person:
							</td>
							<td>
								<%=contactname %>
							</td>
						</tr>
						<tr>
							<td>
								Email:
							</td>
							<td>
								<%=emailid %>
							</td>
						</tr>
						<tr>
							<td>
								Mobile:
							</td>
							<td>
								<%=contactnumber %>
							</td>
						</tr>
						<tr>
							<td>
								Location:
							</td>
							<td>
								<%=address %>
							</td>
						</tr>
					</table>
				</td>
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