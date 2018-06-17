<%@page import="com.yourdistrict.DistrictsList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@page import="java.sql.ResultSet"%>
<html>
<head>
<title>Telangana</title>
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
		Name of the Temple : <input name="templename"><br/><br/>
		
		About Temple:<br/>
		<textarea name="description" required="required" rows="10" cols="100" ></textarea>
		
		<br/><br/>
		
		Location : <input name="location"><br/><br/>
		
		<input type="file" name="templeimage"> <br /><br/>
		
		<input type="submit">
		<input type="hidden" name="tableName" value="templesdata">
		<input type="hidden" name="jspName" value="AdminPortal/TemplesInformation.jsp">
	</div>
	</form>
</body>

<script type="text/javascript">
	function insertData() {
		
	}
</script>
</html>		