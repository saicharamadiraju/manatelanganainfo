<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<iframe id="centerContent" frameborder="1" src="./StateInfo?instance=PostNewsInformation.jsp">
	<button name="LeaderInfo" value="LeaderInformation" onclick="window.open('?instance=AdminPortal/LeaderInformation.jsp', '_blank');">LeaderInformation</button>
	<button name="TemplesInfo" value="TemplesInformation" onclick="window.open('?instance=AdminPortal/TemplesInformation.jsp', '_blank');">TemplesInformation</button>
	<button name="CollegesInfo" value="CollegesInformation" onclick="window.open('?instance=AdminPortal/CollegesInformation.jsp', '_blank');">CollegesInformation</button>
	<button name="TravelsInfo" value="TravelsInformation" onclick="window.open('?instance=AdminPortal/LeaderInformation.jsp', '_blank');">TravelsInformation</button>
	<button name="ClassifiedsInfo" value="ClassifiedsInformation" onclick="window.open('?instance=AdminPortal/ClassifiedsInformation.jsp', '_blank');">ClassifiedsInformation</button>
	<button name="RealEstateInfo" value="RealEstateInformation" onclick="window.open('?instance=AdminPortal/RealEstateInformation.jsp', '_blank');">RealEstateInformation</button>
	
	<div>
		<button name="NewsPostInfo" value="PostNewsInformation" onclick="window.open('?instance=PostNewsInformation.jsp', '_blank');">PostNews</button>
		<button name="InsertAwards" value="StateAwardsInformation" onclick="window.open('?instance=AdminPortal/StateAwardsInformation.jsp', '_blank');">Awards</button>
		<button name="InsertServices" value="InsertServicesData" onclick="window.open('?instance=AdminPortal/InsertServicesData.jsp', '_blank');">Services</button>
	</div>
	
	<iframe id="resultContent" src="./StateInfo?instance=PostNewsInformation.jsp"></iframe>
	</iframe>
	
	
</body>
</html>