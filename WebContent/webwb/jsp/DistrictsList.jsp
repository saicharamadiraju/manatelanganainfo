<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<%@page import="com.yourdistrict.DistrictsList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@page import="java.sql.SQLException"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telangana</title>
</head>
<body>
	<div id="districtsList">

		<%
			List<String> districtsList = DistrictsList.getInstance().getDistrictsList();
			for(String districtName : districtsList) {
		%>
			<a href="#" onClick="getResource(this.id)" id=<%=districtName%>><%=districtName%></a>
		<%
			}
		%>
	</div>
</body>

<style>
#districtsList a {
	font-size: 15px;
	float: none;
	display: block;
	text-align: left;
	padding: 10px 12.5px;
}

#districtsList {
	display: block;
	float: left;
	overflow: hidden;
	position: absolute;
	background-color: #f9f9f9; #
	min-width: 160px;
	box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

</style>

<script>
function getResource(divID) {
	debugger;
	var url = "./StateInfo?District=true&DistrictName=" + divID;
	$.get(url, null, function(data) {
		$("#centerContent").html(data);
		$('#slideShow').hide();
		$('#footerTable').hide();
		$('#description').hide();
	});
}
</script>
</html>