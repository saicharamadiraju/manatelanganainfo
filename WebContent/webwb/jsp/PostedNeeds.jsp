<%@page import="com.yourdistrict.BloodGroups"%>
<%@page import="java.util.List"%>
<%@page import="com.yourdistrict.BloodNeeds"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String districtName = (String) request.getAttribute("districtName");
		BloodNeeds needs = new BloodNeeds();
		String result = needs.getPostedNeedsForDistrict(districtName);
		
		List<String> bloodgroups = BloodGroups.getBloodGroupsList();
		
	%>
	<div>
	<%= result %>
	</div>
</body>
</html>