<%@page import="java.sql.SQLException"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>News Feed Telangana</title>
<style>
  .hide { position:absolute; top:-1px; left:-1px; width:1px; height:1px; }
  #UserPostNewsTable {
  	border: 1px solid black;
  	table-layout: fixed;
  }
  
  td {
    width : 75px;
  }
</style>
</head>
<body>


<iframe name="hiddenFrame" class="hide" ></iframe>
<div id="newsFeedContentInner">
		<form id="submitNewsForm" method="post" target="hiddenFrame" action="?instance=InsertData.jsp" enctype="multipart/form-data"  >
			<table id="UserPostNewsTable">
				<tr>
					<th align="center">Post Your News Here!!</th>
				</tr>
				<tr>
					<td><label> District: </label></td>
					<td><select name="districtname">
							<%
								ResultSet rs = null;
								try {
									String tableName = "districtinformation";
									String[] columnNames = { "name" };
									DataManager dm = new DataManager();
									rs = dm.getResultSet(tableName, columnNames);

									while (rs.next()) {
										String districtName = rs.getString("name");
										System.out.println(districtName);
							%>

							<option id=<%=districtName%>><%=districtName%></option>

							<%
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
					</select></td>
				</tr>
				<tr>
					<td><label>Title:</label></td>
					<td><input type="text" name="newstitle" maxlength="50" /></td>
				</tr>
				<tr>
					<td><label>Posted By:</label></td>
					<td><input type="text" name="postedby" value="UrDistrictInfo"></td>
				</tr>
				<tr>
					<td><label>EmailID:</label></td>
					<td><input type="text" name="emailid" ></td>
				</tr>
				<tr>
					<td><label>Content:</label></td>
					<td><textarea rows="15" cols="30" name="newscontent"
							style="max-height: 100px; min-height: 100px; resize: none; overflow-y: scroll;"></textarea></td>
				</tr>
				<tr>
					<td><label>Image:</label></td>
					<td><input type="file" name="newsimage"></td>
				</tr>
				
				<tr>
					<td><input type="submit" value="Post News"></td>
				</tr>
			</table>
			<input type="hidden" name="isapproved" value="yes"> 
			<input type="hidden" name="tableName" value="telnews"> 
		</form>
	</div>
</body>

</html>