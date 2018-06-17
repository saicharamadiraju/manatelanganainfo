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
	<div id="classifiedsInfo">
	<%
		String districtName = (String) request.getAttribute("DistrictName");
	%>
	<input type="hidden" id="hiddenText" value="<%= districtName %>" />
	
		Select Business Type : <select name="businessType"
			onchange="getMeFromDatabase(this.value)">
			<option value="">Select Business Type</option>
			<%
				ResultSet rs = null;
				try {
					DataManager manager = new DataManager();
					String query = "SELECT distinct(businesstype) FROM content.classifiedsdata WHERE "
							+ "districtname LIKE '" + districtName + "'";

					rs = manager.getResultSet(query);

					while (rs != null && rs.next()) {
						String businesstype = rs.getString("businesstype");
						System.out.println(businesstype);
			%>

			<option value=<%=businesstype%>><%=businesstype%></option>
			
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
		</select>
	</div>
	<div id="classifiedsContent"></div>
</body>

<script type="text/javascript">
	function getMeFromDatabase(businessType) {
		debugger;
		if (businessType == "")
			return;

		$.ajax({
			'type' : 'POST',
			'url' : './StateInfo?instance=GetClassifiedsForBusinessType.jsp&businesstype=' + businessType + "&DistrictName="+ $("#hiddenText").attr('value'),
			'dataType' : 'html',
			'success' : function(data) {
				$("#classifiedsContent").html(data);
			}
		});
	}
</script>
</html>