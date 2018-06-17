<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="?instance=AdminPortal/InsertData.jsp" enctype="multipart/form-data">
	<div id="awards">
		Award Title : <input type="text" name="awardtitle"><br />
		Award Content : <textarea rows="50" cols="50" name="aboutaward"></textarea><br />
		<input type="file" name="awardimage"> <br />
		<input type="submit"> <br />
		<input type="hidden" name="tableName" value="stateawards">
		<input type="hidden" name="jspName" value="AdminPortal/StateAwardsInformation.jsp">
	</div>
	</form>
</body>
</html>