<%@page import="com.yourdistrict.ExcelReader"%>
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
		String tableName = (String) request.getAttribute("tableName");
		String fileLocation =(String) request.getAttribute("ExcelFileLocation");
		
		ExcelReader reader = new ExcelReader();
		reader.insertDataIntoTableFromFile("C:\\Users\\Saicharan\\Downloads\\Awards List.xlsx","content.stateservices");
		
	%>
</body>
</html>