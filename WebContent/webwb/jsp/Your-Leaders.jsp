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
<style type="text/css">
	table, td {
		border-collapse: collapse;
	}
</style>
<title>Telangana</title>
</head>
<body>

	<div id="leadersInfo">
		<table border="1px" bordercolor="black">
			<%
		ResultSet rs = null;
			try {
			String districtName = (String)request.getAttribute("DistrictName");
			
			DataManager manaer = new DataManager();
			String query = "SELECT leadername,leaderdesignation,assemblyconstituency,politicalparty FROM content.leadersdata WHERE " + 
						"DistrictName LIKE '" + districtName + "'";
							
			rs = manaer.getResultSet(query);
			
			while(rs.next()) {
				String leadername = rs.getString("leadername");
				String leaderdesignation = rs.getString("leaderdesignation");
				String leaderimage =  "./StateInfo?image=true&CondProp3=DistrictName&CondPropValue3=" + districtName + "&CondProp1=LeaderName&CondPropValue1=" + leadername + "&CondProp2=LeaderDesignation&CondPropValue2=" + leaderdesignation + "&TableName=leadersdata&ColumnToRetrieve=" + "LeaderImage";
				System.out.println("Leader imae : " + leaderimage);
				String assemblyconstituency = rs.getString("assemblyconstituency");
				String politicalParty = rs.getString("politicalparty");
			%>

			<tr>
				<td class="imaOfMP">
					<img id="LeaderImage" src="<%=leaderimage%>" width="150px" height="160px">
				</td>
				<td class="nameOfMP">
					<table>
						<tr>
							<td>
								<%=leadername %>
							</td>
						</tr>
						<tr>
							<td>
								<%=leaderdesignation %>
							</td>
						</tr>
						<tr>
							<td>
								<%=assemblyconstituency %>
							</td>
						</tr>
						<tr>
							<td>
								<%=politicalParty %>
							</td>
						</tr>
					</table>
				</td>
				<!-- <td class="AboutMP" >
					
				</td> -->
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
	</div>
</body>
</html>