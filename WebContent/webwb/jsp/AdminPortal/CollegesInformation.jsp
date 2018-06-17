<%@page import="com.yourdistrict.DistrictsList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@page import="java.sql.ResultSet"%>
<html>
<head>
</head>

<body>
<form method="post" action="?instance=AdminPortal/InsertData.jsp" enctype="multipart/form-data">
	<div id="districtsList">
		<select name="districtname" >
			<%
				List<String> districtsList = DistrictsList.getInstance().getDistrictsList();
				for(String districtName : districtsList) {
			%>

			<option id=<%=districtName%>><%=districtName%></option>

			<%
				}
			%>
		</select> 
		
		<br /> <br />
		Name of the College <input name="collegename">
		<br/><br/>
		Instituition type
		<select name="instituitiontype">
			<option>Engineering</option>
			<option>Medical</option>
		</select> <br/><br/>
		
		Location : <input name="collegelocation"><br/><br/>
		College Link : <input name="collegelink"><br/><br/>
		College code : <input name="collegecode"><br/><br/>
		University : <input name="university"><br/><br/>
		<input type="file" name="collegeimage"> <br />
		<input type="submit"> <br />
		<input type="hidden" name="tableName" value="collegesdata">
		<input type="hidden" name="jspName" value="AdminPortal/CollegesInformation.jsp">
	</div>
	</form>
</body>

<script type="text/javascript">
	function insertData() {
		
	}
</script>
</html>		