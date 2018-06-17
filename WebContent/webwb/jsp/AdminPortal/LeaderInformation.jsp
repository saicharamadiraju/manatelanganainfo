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
		<select name="DistrictName" >
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
		Name of the leader : <input name="leaderName"><br/><br/>
		
		<select name="LeaderDesignation">
			<option>MLA</option>
			<option>MP</option>
		</select> 
		
		<br/><br/>
		
		Political Party : <input type="text" name="PoliticalParty"/> <br/><br/>
		Assembly Constituency : <input type="text" name="AssemblyConstituency"/><br/><br/>
		
		
		<input type="file" name="leaderImage"> <br /><br/>
		
		<input type="submit">
		<input type="hidden" name="tableName" value="leadersdata">
		<input type="hidden" name="jspName" value="AdminPortal/LeaderInformation.jsp">
	</div>
	</form>
</body>

<script type="text/javascript">
	function insertData() {
		
	}
</script>
</html>		