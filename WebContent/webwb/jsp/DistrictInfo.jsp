<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="com.yourdistrict.WebScrapper"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel='stylesheet' href='./webwb/css/DistrictOverlay.css'
	type='text/css' media='all' />
<title>Telangana</title>
</head>
<body>

	<%
	String districtName = (String)request.getAttribute("DistrictName");
		String hyderabadDistrictURL = "https://en.m.wikipedia.org/wiki/"+ districtName +"_district,_India";
		String districtURL = "https://en.m.wikipedia.org/wiki/"+ districtName +"_district";
	
		WebScrapper scrapper = new WebScrapper();
		
		if(districtName.equalsIgnoreCase("hyderabad")) {
			scrapper.establishConnection(hyderabadDistrictURL);
		} else {
			scrapper.establishConnection(districtURL);
		}
		
		Document document = scrapper.getDocument();
		Elements paragraphs = document.getElementsByTag("p");
		Element heading = document.getElementById("section_0");
		Element image = document.getElementsByClass("thumbimage").first();
	%>

	<div id="DistrictContainer">
		<input type="hidden" id="hiddenText" value="<%=districtName %>" />
		<div>
			<ul id="DistrictServices" style="float: left;">
				<li><a href="#" id="About" class="press">About</a></li>
				<li><a href="#" id="Your-Leaders" class="press">Your
						Leaders</a></li>
				<li><a href="#" id="Education" class="press">Education</a></li>
				<li><a href="#" id="Temples" class="press">Temples</a></li>
				<li><a href="#" id="RealEstate" class="press">Real Estate</a></li>
				<li><a href="#" id="HelpingHands" class="press">Helping hands</a></li>
				<li><a href="#" id="Classifieds" class="press">Classifieds</a></li>
			</ul>
		</div>
		<div>
			<div id="district-Name"> <h4><%=heading.toString() %></h4> </div>
			<div id="districtImage"> <%=image %> </div>
			
			<div class="internalContent" id="About-Div"> <%= paragraphs.text() %> </div>
			<div class="internalContent" id="Temples-Div" style="display: none;"> </div>
			<div class="internalContent" id="Education-Div" style="display: none;"> </div>
			<div class="internalContent" id="Your-Leaders-Div" style="display: none;"></div>
			<div class="internalContent" id="Classifieds-Div" style="display: none;"></div>
			<div class="internalContent" id="HelpingHands-Div" style="display: none;"></div>
			<div class="internalContent" id="RealEstate-Div" style="display: none;"></div>
		</div>
	</div>
</body>

<script type="text/javascript">
		$(".press").click(function() {
			debugger;
			var divID = $(this).attr('id');
			var nameOfA = divID;
			nameOfA = divID + "-Div";
			/* if(divID == "Your-Leaders" || divID == "Temples") {
				
			} else  */
			if(divID == "About") {
				$('#DistrictServices').show();
				$('#districtImage').show();
				$('#district-Name').show();
				$('#About-Div').show();
			} else {
				var url = "./StateInfo?instance=" + divID + ".jsp" + "&DistrictName=" + $("#hiddenText").attr('value');
				$.get(url, null, function(data) {
					$('#'+nameOfA).html(data);
				});
			}
			
			document.getElementById(nameOfA).style.display = "block";
			$('#'+nameOfA).siblings().hide();
			$('#DistrictServices').show();
			$('#districtImage').hide();
			$('#district-Name').show();
		});
	</script>
</html>