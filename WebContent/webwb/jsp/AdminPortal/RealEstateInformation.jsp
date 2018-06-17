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
	<div id="realEstateList">
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
		Project name <input name="projectname"><br/><br/>
		Details : <textarea rows="20" cols="60" name="details"></textarea><br/><br/>
		Location : <input name="location"><br/><br/>
		Google map link : <input name="googlemap"><br/><br/>
		contact number : <input name="contactnumber"><br/><br/>
		email : <input name="email"><br/><br/>
		website link : <input name="websiteurl" ><br/><br/>
		<input type="file" name="realestateimage"> <br />
		<input type="submit"> <br />
		<input type="hidden" name="tableName" value="realestate">
		<input type="hidden" name="jspName" value="AdminPortal/RealEstateInformation.jsp">
	</div>
	</form>
</body>

<script type="text/javascript">
	function insertData() {
		
	}
</script>
</html>		