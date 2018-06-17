<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.Reader"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telangana</title>
<style type="text/css">
	#AwardsTable {
		margin-top: 10px;
	}
	
	#AwardImg {
		border-radius :5px;
		margin-right: 5px;
		width: 180px;
		height: 180px;		
	}
	
	.AwardText {
		font-size: 16px;
		text-align: justify;
		table-layout: fixed;
	}
	
	.AwardHeading {
		font-size: 20px;
	}
	
	#AwardsDiv {
	margin-right: 10px;
	}
</style>
</head>
<body>
	<div id="AwardsDiv">
		<table id="AwardsTable">
		<%
			ResultSet rs = null;
			DataManager manaer = new DataManager();
			String query = "SELECT awardtitle,aboutaward FROM content.stateawards";		
			rs = manaer.getResultSet(query);
			
			while (rs.next()) {
				String awardTitle = rs.getString("awardtitle");
				String awardImageURL = "./StateInfo?image=true&CondProp1=awardtitle&CondPropValue1=" + URLEncoder.encode(awardTitle,"UTF-8")
						+ "&TableName=stateawards&ColumnToRetrieve=" + "awardimage";
				
				StringBuilder sb = new StringBuilder();
				Reader in = rs.getCharacterStream("aboutaward");
				int buf = -1;
				while((buf = in.read()) > -1) {
				    sb.append((char)buf);
				}
				in.close();
				String aboutAward = sb.toString();
		%>
			<tr>
				<td><img src="<%= awardImageURL%>" id="AwardImg" width="200px" height="200px"></td>
				<td>
					<table>
						<tr>
							<td>
								<h3 class="AwardHeading"><%= awardTitle %></h3>
							</td>
						</tr>
						<tr>
							<td>
								<p class="AwardText"><%= aboutAward %></p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<%
				}			
			%>

		</table>
	</div>
</body>
</html>