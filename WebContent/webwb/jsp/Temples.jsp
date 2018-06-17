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
	<div id="templesInfo">
		<div id="templesTable">
			<table border="1px" bordercolor="black">
				<%
					ResultSet rs = null;
					try {
						String districtName = (String) request.getAttribute("DistrictName");

						DataManager manaer = new DataManager();
						String query = "SELECT templename,location, description FROM content.templesdata WHERE "
								+ "districtname LIKE '" + districtName + "'";

						rs = manaer.getResultSet(query);

						while (rs.next()) {
							String templename = rs.getString("templename");
							String location = rs.getString("location");
							String description = new String(rs.getBytes("description"));
							String templedescriptionid = "hiddenTemp" + templename;

							String templeimage = "./StateInfo?image=true&CondProp2=districtname&CondPropValue2=" + districtName
									+ "&CondProp1=templename&CondPropValue1=" + templename
									+ "&TableName=templesdata&ColumnToRetrieve=" + "templeimage";
				%><tr>
					<td>
						<table>
							<tr>
								<td class="imaOfMP"><img id=<%=templename%>
									src="<%=templeimage%>" width="290px" height="280px"
									onClick="description(this.id)"> <input type="hidden"
									name="hiddenTemp1" id=<%=templedescriptionid%>
									value="<%=description%>" /></td>
							</tr>
							<tr>
								<td class="nameOfMP">
									<table>
										<tr>
											<td><%=templename + " -"%></td>
											<td><%=location%></td>
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
		<div id="templeDescription" style="display: none;">
							<textarea name="description" readonly="readonly" rows="50" cols="50"></textarea>
						</div>
	</div>
</body>

<style type="text/css">
#templeDescription {
	float: left;
	margin-left: 10px;
	font-size: 15px;
	font-weight: zy;
	width: 400px;
	height: 500px;
}

#templesTable {
	float: left;
}
</style>

<script type="text/javascript">
	function description(templeName) {
		debugger;
		var description1 = document.getElementById("hiddenTemp" + templeName).value;
		$('#templeDescription').html(description1);
		$('#templeDescription').show();
	}
</script>
</html>