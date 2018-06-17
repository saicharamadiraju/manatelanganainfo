<%@page import="com.yourdistrict.ServiceDataDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.yourdistrict.ServicesData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telangana</title>
<style type="text/css">
.servicesImage {
	width: 130px;
	height: 130px;
}

tr.servicesRow:nth-child(even) {
    background-color: #edf2f9;
}

.servicesHeader {
	font-size: 20px;
	text-align: center;
	color: white;
	background-color: black;
}

.ServicesTable {
	table-layout: fixed;
	width: 800px; 
	text-align: justify;
	border: 1px solid black;
}

td.Wrappable {
	word-wrap:break-word ;
	font-size: 16px;
}

td.smallCol {
	width: 300px;
}

td.largeCol {
	width: 500px;
}

#TopTableServices {
	width: 50%;
	margin-left: 10px;
	margin-right: 10px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div id="ServicesCenterDiv">
		<div>
			<table id="TopTableServices">
				<tr> 
					<td><button value="Meeseva" onclick="loadDiv(this.value);"><img class="servicesImage"
						src="./webwb/images/Meeseva.png"
						></button></td>
					<td><button value="State" onclick="loadDiv(this.value);"><img class="servicesImage"
						src="./webwb/images/TelanganaLogo.png"
						onclick="loadDiv(this.id);"></button></td>
					<td><button value="Utility" onclick="loadDiv(this.value);"><img class="servicesImage"
						src="./webwb/images/UtilityServices.jpg"
						onclick="loadDiv(this.id);"></button></td>
					<td><button value="Central" onclick="loadDiv(this.value);"><img class="servicesImage"
						src="./webwb/images/CentralServices.jpg"
						onclick="loadDiv(this.id);"></button></td>
				</tr>
			</table>
		</div>
		<br/>
		<%
			List<ServiceDataDTO> meeSevaServices = ServicesData.getInstance()
					.getServicesWithName(ServicesData.MEESEVA_SERVICES);
			List<ServiceDataDTO> stateServices = ServicesData.getInstance()
					.getServicesWithName(ServicesData.STATE_SERVICES);
			List<ServiceDataDTO> centralServices = ServicesData.getInstance()
					.getServicesWithName(ServicesData.CENTRAL_SERVICES);
			List<ServiceDataDTO> utilityServices = ServicesData.getInstance()
					.getServicesWithName(ServicesData.UTILITY_SERVICES);
		%>

		<div id="StateServicesCenterContent">
			<div id="Meeseva" style="display: none;">
				<table class="ServicesTable">
					<tr class="servicesRow"> 
						<th class="servicesHeader">Name of Service</th>
						<th class="servicesHeader">Service Link</th>
					</tr>

					<%
						for (ServiceDataDTO dto : meeSevaServices) {
					%>
					<tr class="servicesRow"> 
						<td class="Wrappable smallCol"><%=dto.getServiceType()%></td>
						<td class="Wrappable largeCol"><a href="<%= dto.getServiceLink()%>"><%= dto.getServiceLink()%></a></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div id="Central" style="display: none;">
				<table class="ServicesTable">
					<tr class="servicesRow"> 
						<th class="servicesHeader">Name of Service</th>
						<th class="servicesHeader">Service Link</th>
					</tr>

					<%
						for (ServiceDataDTO dto : centralServices) {
					%>
					<tr class="servicesRow"> 
						<td class="Wrappable smallCol"><%=dto.getServiceType()%></td>
						<td class="Wrappable largeCol"><a href="<%= dto.getServiceLink()%>"><%= dto.getServiceLink()%></a></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div id="State" style="display: none;">
				<table class="ServicesTable">
					<tr class="servicesRow"> 
						<th class="servicesHeader">Name of Service</th>
						<th class="servicesHeader">Service Link</th>
					</tr>

					<%
						for (ServiceDataDTO dto : stateServices) {
					%>
					<tr class="servicesRow"> 
						<td class="Wrappable smallCol"><%=dto.getServiceType()%></td>
						<td class="Wrappable largeCol"><a href="<%= dto.getServiceLink()%>"><%= dto.getServiceLink()%></a></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div id="Utility" style="display: none;">
				<table class="ServicesTable">
					<tr class="servicesRow"> 
 						<th class="servicesHeader">Name of Service</th>
						<th class="servicesHeader">Service Link</th>
					</tr>

					<%
						for (ServiceDataDTO dto : utilityServices) {
					%>
					<tr class="servicesRow"> 
						<td class="Wrappable smallCol"><%=dto.getServiceType()%></td>
						<td class="Wrappable largeCol"><a href="<%= dto.getServiceLink()%>"><%= dto.getServiceLink()%></a></td>
					</tr>
					<%
					}
				%>
				</table>
			</div>
		</div>
	</div>
<script type="text/javascript">
	function loadDiv(divID) {
		debugger;
		$('#' + divID).show();
		$('#' + divID).siblings().hide();
	}
</script>
</body>
</html>