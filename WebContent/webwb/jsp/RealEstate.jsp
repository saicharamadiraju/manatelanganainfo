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
	<div id="RealEstateInfo">
		<div id="realestatediv">
			<table border="1px" bordercolor="black">
				<%
					ResultSet rs = null;
					try {
						String districtName = (String) request.getAttribute("DistrictName");

						DataManager manaer = new DataManager();
						String query = "SELECT projectname,contactname,location, googlemap,websiteurl,contactnumber,email FROM content.realestate WHERE "
								+ "districtname LIKE '" + districtName + "'";

						rs = manaer.getResultSet(query);

						while (rs.next()) {
							String projectname = rs.getString("projectname");
							String contactname = rs.getString("contactname");
							String location = rs.getString("location");
							String websiteurl = rs.getString("websiteurl");
							String googlemap =  rs.getString("googlemap");
							String email =  rs.getString("email");
							String contactnumber = rs.getString("contactnumber");
							String realestateimage = "./StateInfo?image=true&CondProp2=districtname&CondPropValue2=" + districtName
									+ "&CondProp1=projectname&CondPropValue1=" + projectname
									+ "&TableName=realestate&ColumnToRetrieve=" + "realestateimage";
					%><tr>
					<td>
						<table>
							<tr>
								<td class="imageOfCollege"><img id=<%= projectname%>
									src="<%= realestateimage%>" width="380px" height="340px"
									onClick="window.open('<%= "http://"+websiteurl %>', '_blank');"></td>
							</tr>
							<tr>
								<td class="nameOfCollege">
									<table>
										<tr>
											<td><h3><%= projectname %></h3></td>
										</tr>
										<tr>
											<td><label>Contact:</label>
											<%= contactname%></td>
										</tr>
										<tr>
											<td><label>DialUs:</label>
											<%= contactnumber%></td>
											<td><label>Email:</label>
											<%= email %></td>
										</tr>
										<tr>
											<td><label>Address:</label>
											<%= location %></td>
											<td><label>Location:</label>
											<%= googlemap %></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<%
					}

					} finally {
						try {
							if (rs != null)
								rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
				%>
			</table>
		</div>
	</div>
</body>

<style type="text/css">
#templesTable {
	float: left;
}
</style>

<script type="text/javascript">
	function description(templeName) {
		debugger;
		var description1 = document.getElementById("hiddenTemp" + templeName).value;
		$('#templeDescription').html(description1);
	}
</script>
</html>