<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel='stylesheet' href='./webwb/css/StateProfile.css' type='text/css' media='all' />
<title>Telangana</title>
</head>
<body>
	<div id="StateProfileContainer">
		<div  style="float: left;">
			<ul id="StateServices">
				<a href="#" id="Government" class="statepress">Government</a>
				<a href="#" id="Achievements" class="statepress">Govt Achievements</a>
				<a href="#" id="Symbols" class="statepress">State Symbols</a>
				<a href="#" id="Awards" class="statepress">Awards</a>
				<a href="#" id="Services" class="statepress">Services</a>
			</ul>
		</div>
		<div>
			<div class="internalContent" id="Government-Div" style="display: none;"> </div>
			<div class="internalContent" id="Achievements-Div" style="display: none;"> </div>
			<div class="internalContent" id="Symbols-Div" style="display: none;"></div>
			<div class="internalContent" id="Awards-Div" style="display: none;"></div>
			<div class="internalContent" id="Services-Div" style="display: none;"></div>
		</div>
	</div>	
</body>
<script type="text/javascript">
	$(".statepress").click(function() {
		var divID = $(this).attr('id');
		var nameOfA = divID;
		nameOfA = divID + "-Div";
		var url = "./StateInfo?instance=" + divID + ".jsp";
		$.get(url, null, function(data) {
			$('#'+nameOfA).html(data);
		});
		
		document.getElementById(nameOfA).style.display = "block";
		$('#'+nameOfA).siblings().hide();
		$('#StateServices').show();
	});
</script>
</html>