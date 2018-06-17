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
		Contact Person <input name="contactname">
		<br/><br/>
		
		Type of business : <input name="businesstype"><br/><br/>
		Address : <input name="address"><br/><br/>
		contact number : <input name="contactnumber"><br/><br/>
		email : <input name="emailid"><br/><br/>
		<input type="file" name="classifiedimage"> <br />
		<input type="submit"> <br />
		<input type="hidden" name="tableName" value="classifiedsdata">
		<input type="hidden" name="jspName" value="AdminPortal/ClassifiedsInformation.jsp">
	</div>
	</form>
</body>

<script type="text/javascript">
	function insertData() {
		
	}
</script>
</html>		