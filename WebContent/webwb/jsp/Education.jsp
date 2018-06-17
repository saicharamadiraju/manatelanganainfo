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
	table, td {
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<div id="EducationInfo">
		<div id="collegesTable">
			<table border="1px" bordercolor="black">
				<%
					ResultSet rs = null;
					try {
						String districtName = (String) request.getAttribute("DistrictName");

						DataManager manaer = new DataManager();
						String query = "SELECT collegename,collegecode, collegelocation, collegelink,instituitiontype FROM content.collegesdata WHERE "
								+ "districtname LIKE '" + districtName + "'";

						rs = manaer.getResultSet(query);

						while (rs.next()) {
							String collegename = rs.getString("collegename");
							String collegecode = rs.getString("collegecode");
							String collegelocation = rs.getString("collegelocation");
							String collegelink = rs.getString("collegelink");
							String instituitiontype = rs.getString("instituitiontype");
							String collegeimage = "./StateInfo?image=true&CondProp2=districtname&CondPropValue2=" + districtName
									+ "&CondProp1=collegename&CondPropValue1=" + collegename
									+ "&TableName=collegesdata&ColumnToRetrieve=" + "collegeimage";
					%><tr>
					<td>
						<table>
							<tr>
								<td class="imageOfCollege"><img id=<%= collegename%>
									src="<%= collegeimage%>" width="380px" height="340px"
									onClick="window.open('<%= "http://"+collegelink %>', '_blank');"></td>
							</tr>
							<tr>
								<td class="nameOfCollege">
									<table>
										<tr>
											<td><%= collegename %></td>
										</tr>
										<tr>
											<td><%= collegecode%></td>
										</tr>
										<tr>
											<td><%= instituitiontype %></td>
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