<%@page import="java.net.URLDecoder"%>
<%@page import="com.yourdistrict.NewsContentData"%>
<%@page import="com.yourdistrict.NewsDataDTO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta property="og:url"           content="https://www.yourdistrict.info/telangana/StateInfo" />
  <meta property="og:type"          content="website" />
  <meta property="og:title"         content="Telangana State Info" />
  <meta property="og:description"   content="This page provides the information about the News feed" />
  <meta property="og:image"         content="https://www.your-domain.com/path/image.jpg" />
<title>Insert title here</title>
<style type="text/css">
#popupMainBody {
	background-color: white;
	width: 1000px;
}

#popupImage {
	float: left;
}

#popupContent {
	float: left;
	width: 600px;
	text-align: justify;
}

#NewsTablePopup {
	table-layout: fixed;
	width: 500px;
}
</style>
</head>
<body id="popupMainBody">
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId            : '552151185157508',
      autoLogAppEvents : true,
      xfbml            : true,
      version          : 'v2.12'
    });
    
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>
	<%
		String contentURL = (String) request.getAttribute("key");
		System.out.println(contentURL);

		NewsDataDTO dto = NewsContentData.getInstance().getNewsFeedObject(contentURL);
		System.out.println(dto.getNewsTitle());
		String url = (String)request.getAttribute("ActualURL");
		System.out.println(url);
	%>

	<div>
		<h2><%=dto.getNewsTitle()%>
		</h2>
		<br />
		<table id="NewsTablePopup">
			<tr>
				<td>
					<div id="popupImage">
						<img src="<%=dto.getImageURL()%>" width="300px" height="300px">
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="popupContent">
						<%=dto.getContent()%>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<b>Posted By : <%= dto.getPostedby() %></b>
				</td>
			</tr>
		</table>
	</div>
	<fb:share-button href="http://www.yourdistrict.info/telangana/StateInfo"
                 type="button_count">
	</fb:share-button>
</body>
</html>