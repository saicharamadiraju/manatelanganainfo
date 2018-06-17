<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telangana</title>
</head>
<body>
	<div id="topHeader">
		<div id="kcr">
			<img src="./webwb/images/KCR-Photo.png">
		</div>
		<div id="heading">
			<h1>TELANGANA STATE OVERVIEW</h1>
		</div>

		<div id="logo">
			<img src="./webwb/images/telanganathalli.jpg">
		</div>
	</div>	
	<!-- <div id="WhatsNew">
			<div id="WhatsNewLabel">
				<label> What's New!! </label>
			</div>
			<div id="WhatsNewMarquee">
				<marquee scrollamount="2" behavior="scroll" width="800px">
					<a>Happy</a> <a>Holiday</a>
				</marquee>
			</div>
		</div> -->
		
		<div id="horizontalMenu" class="clearfix">
				<a href="#" id="home">Home</a>
				<a href="#" class="ajaxClick" onClick="getJSPResource(this.id)" id="StateProfile">State Profile</a>
				<div class="dropdown">
					<button class="dropbtn dropdown-toggle" id="dropDownButton">Know Your District
					<i class="fa fa-caret-down"></i>	
					</button>
					<div id="dropDownContent" class="dropdown-content">
						
					</div>
				</div>

				<a href="./StateInfo?instance=NewsFeed.jsp" target="CenterContent" id="NewsFeed">Tel News Feed</a>
				<a href="#" class="ajaxClick" onClick="getJSPResource(this.id)" id="Entertainment">Entertainment</a>
				<a href="#" class="ajaxClick" onClick="getJSPResource(this.id)" id="PhotoGallery">Photo Gallery</a>
				<a href="#" class="ajaxClick" id="ContactUs" onClick="getJSPResource(this.id)">Contact Us</a>
			</div>
			
			<script type="text/javascript">
			function getJSPResource(divID) {
				debugger;
				var url = "./StateInfo?instance=" + divID+".jsp";
				$.get(url, null, function(data) {
					/* $("#centerContent").html(data);
					$('#description').remove();// hide();
					$('#slideShow').hide();
					$('#footerTable').hide(); */
					document.CenterContent.document.body.innerHTML = data;
				});
			} 
			</script>																
</body>
</html>