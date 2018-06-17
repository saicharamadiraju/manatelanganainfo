<%@page import="com.yourdistrict.NewsContentData"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.yourdistrict.DistrictsList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.yourdistrict.NewsDataDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
.flash-button {
	animation-name: flash;
	animation-duration: 1s;
	animation-timing-function: linear;
	animation-iteration-count: infinite; // Firefox 1+
	-webkit-animation-name : flash;
	-webkit-animation-duration: 1s;
	-webkit-animation-timing-function: linear;
	-webkit-animation-iteration-count: infinite; // Safari 3-4
	-moz-animation-name : flash;
	-moz-animation-duration: 1s;
	-moz-animation-timing-function: linear;
	-moz-animation-iteration-count: infinite;
}

@
keyframes flash { 0% {
	opacity: 1.0;
}

50%
{
opacity




:


 


0
.5




;
}
100%
{
opacity




:


 


1
.0




;
}
}
//
Firefox 1+ @-webkit-keyframes flash { 0% {
	opacity: 1.0;
}

50%
{
opacity




:


 


0
.5




;
}
100%
{
opacity




:


 


1
.0




;
}
}
//
Safari 3-4 @-moz-keyframes flash { 0% {
	opacity: 1.0;
}

50%
{
opacity




:


 


0
.5




;
}
100%
{
opacity




:


 


1
.0




;
}
}
.inputFields {
	width: 150px;
}

.tableContentNewsFeed {
	border-bottom: 1px solid black;
}

table, td {
	border-collapse: collapse;
}

.headingTextNewsFeed {
	font-size: 18px;
	font-family: Impact, Charcoal, sans-serif;
	font-weight: bolder;
	color: #0e3c87;
	border-bottom: solid 1px black;
	font-weight: bolder;
}

#NewsFeedContentInner {
	display: none;
}

.hide {
	position: absolute;
	top: -1px;
	left: -1px;
	width: 1px;
	height: 1px;
}

.UserPostNewsTable {
	border: 2px solid black;
	table-layout: fixed;
	width: 300px;
	height: 300px;
	float: right;
	padding-left: 10px;
}

table.fixed {
	table-layout: fixed;
	border: 2px solid black;
	width: 330px;
} /*Setting the table width is important!*/
table.fixed td {
	overflow: hidden;
} /*Hide text outside the cell.*/
table.fixed td:nth-of-type(1) {
	width: 50%;
} /*Setting the width of column 1.*/
table.fixed td:nth-of-type(2) {
	width: 50%;
} /*Setting the width of column 2.*/
#UserNewsFeed {
	float: right;
	padding-left: 12px;
	padding-right: 4px;
	padding-top: 2px;
}

#OurNewsFeed {
	float: left;
	padding-top: 2px;
	padding-left: 2px;
}

#YourNewsFeed {
	float: left;
	padding-top: 2px;
	padding-left: 20px;
}
</style>
</head>
<body>

	<%
		ResultSet rs = null;
		List<NewsDataDTO> ourNewsList = new ArrayList<NewsDataDTO>();
		List<NewsDataDTO> yourNewsList = new ArrayList<NewsDataDTO>();
		try {
			DataManager dm = new DataManager();
			String query = "SELECT newstitle,districtname,postedby,newscontent FROM content.telnews WHERE isapproved LIKE 'yes'";

			rs = dm.getResultSet(query);

			while (rs.next()) {
				String newsTitle = rs.getString("newstitle");
				String districtName = rs.getString("districtname");
				String postedby = rs.getString("postedby");
				String newscontent = rs.getString("newscontent");
				String content = rs.getString("newscontent");

				String newsImage = "./StateInfo?image=true&CondProp2=districtname&CondPropValue2=" + districtName
						+ "&CondProp1=newstitle&CondPropValue1=" + URLEncoder.encode(newsTitle, "UTF-8")
						+ "&CondProp3=postedby&CondPropValue3=" + URLEncoder.encode(postedby, "UTF-8")
						+ "&TableName=telnews&ColumnToRetrieve=" + "newsimage";

				NewsDataDTO dto = new NewsDataDTO();
				dto.setDistrictName(districtName);
				dto.setImageURL(newsImage);
				dto.setNewsTitle(newsTitle);
				dto.setPostedby(postedby);
				dto.setContent(content);

				String newsFeedKey = dto.getNewsFeedKey();
				String contentURL = "&key=" + URLEncoder.encode(newsFeedKey, "UTF-8");
				dto.setContentURL(contentURL);

				if (postedby.equals("UrDistrictInfo")) {
					ourNewsList.add(dto);
				} else {
					yourNewsList.add(dto);
				}

				NewsContentData.getInstance().putNewsFeedObject(newsFeedKey, dto);
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>
	<div id="StoredNewsFeed">
		<div id="OurNewsFeed">
			<table class="fixed">
				<tr>
					<th class="headingTextNewsFeed" colspan="2"><label>Our
							News</label></th>
				</tr>

				<%
					for (NewsDataDTO dto : ourNewsList) {
						request.setAttribute("NewsFeedDTO", dto);
				%>
				<tr>
					<td width="20px" height="20px" class="tableContentNewsFeed"><img
						alt="News Image" width="100px" height="100px"
						src=<%=dto.getImageURL()%>
						onclick="javascript:window.open('./StateInfo?instance=ActualNews.jsp<%=dto.getContentURL()%>', 'NewsWindow', 'width=500,height=500');"></td>
					<td width="20px" height="20px" class="tableContentNewsFeed"><a
						href="#"
						onclick="javascript:window.open('./StateInfo?instance=ActualNews.jsp<%=dto.getContentURL()%>', 'NewsWindow', 'width=500,height=500');"><%=dto.getNewsTitle()%></a></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<div id="YourNewsFeed">
			<table class="fixed">
				<tr>
					<th class="headingTextNewsFeed" colspan="2"><label>Your
							News</label></th>
				</tr>

				<%
					for (NewsDataDTO dto : yourNewsList) {
				%>
				<tr>
					<td width="20px" height="20px" class="tableContentNewsFeed"><img
						alt="News Image" width="100px" height="100px"
						src=<%=dto.getImageURL()%>
						onclick="javascript:window.open('./StateInfo?instance=ActualNews.jsp<%=dto.getContentURL()%>', 'NewsWindow', 'width=500,height=500');"></td>
					<td width="20px" height="20px" class="tableContentNewsFeed"><a
						href="#"
						onclick="javascript:window.open('./StateInfo?instance=ActualNews.jsp<%=dto.getContentURL()%>', 'NewsWindow', 'width=500px,height=750px');"><%=dto.getNewsTitle()%></a></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>


	<div id="UserNewsFeed">

		<div id="showNewsFeedButton">
			<div id="Thankyou" style="display: none;">
				<label>Thank you for your support.</label> <label>Please
					click below to post more news</label>
			</div>
			<table class="UserPostNewsTable">
				<tr>
					<td align="center" rowspan="4" colspan="2"><img
						class="flash-button" src="./webwb/images/PostYourNews.JPG"
						onclick="getNewsFeed();" width="296px" height="300px"></td>
				</tr>
			</table>
		</div>

		<iframe name="hiddenFrame" class="hide"> </iframe>
		<div id="NewsFeedContentInner">
			<form id="submitNewsForm" method="post" target="hiddenFrame"
				action="?instance=InsertData.jsp"
				enctype="multipart/form-data">
				<table class="UserPostNewsTable">
					<tr>
						<th align="center" colspan="2">Post Your News Here!!</th>
					</tr>
					<tr>
						<td style="width: 10px;"><label> District: </label></td>
						<td><select name="districtname" class="inputFields">
								<%
									List<String> districtsList = DistrictsList.getInstance().getDistrictsList();
									for (String districtName : districtsList) {
								%>

								<option id=<%=districtName%>><%=districtName%></option>

								<%
									}
								%>
						</select></td>
					</tr>
					<tr>
						<td style="width: 10px;"><label>Title:</label></td>
						<td><input type="text" name="newstitle" class="inputFields"
							maxlength="50" /></td>
					</tr>
					<tr>
						<td style="width: 10px;"><label>Posted By:</label></td>
						<td><input type="text" name="postedby" class="inputFields"
							placeholder="Enter your name"></td>
					</tr>
					<tr>
						<td style="width: 10px;"><label>Content:</label></td>
						<td><textarea rows="15" cols="20" name="newscontent"
								class="inputFields"
								style="max-height: 100px; min-height: 100px; resize: none; overflow-y: scroll;"></textarea></td>
					</tr>
					<tr>
						<td style="width: 10px;"><label>Email:</label></td>
						<td><input type="text" name="emailid" class="inputFields"
							placeholder="Enter your name"></td>
					</tr>
					<tr>
						<td style="width: 10px;"><label>Image:</label></td>
						<td><input type="file" name="newsimage" class="inputFields"></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit"
							class="inputFields" value="Submit"></td>
					</tr>
				</table>
				<input type="hidden" name="isapproved" value="no"> <input
					type="hidden" name="tableName" value="telnews">
			</form>
		</div>
	</div>

	<script type="text/javascript">
		//	loadUserFeedContent();
		function getNewsFeed() {
			$("#NewsFeedContentInner").show();
			$("#showNewsFeedButton").hide();
		}

		function getNewsFeedButton() {
			$("#NewsFeedContentInner").hide();
			$("#showNewsFeedButton").show();
			$("Thankyou").show();
		}
	</script>
</body>
</html>