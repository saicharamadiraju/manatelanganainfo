<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.MultipartStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.yourdistrict.DataManager"%>
<html>
<head>
<title>Telangana</title>
</head>
<body>
	<%
		DataManager dm = new DataManager();
		FileItemFactory fif = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(fif);
		List items = sfu.parseRequest(request);

		String tableName = null;
		//String jspName = null;
		StringBuffer query = new StringBuffer();
		StringBuffer values = new StringBuffer();
		
		for (int i = 0; i < items.size(); i++) {
			FileItem item = (FileItem) items.get(i);

			String fieldName = item.getFieldName();
			
			if(fieldName.equalsIgnoreCase("tableName" )) {
				tableName = item.getString();
			}/*  else if(fieldName.equalsIgnoreCase("jspName")) {
				jspName = item.getString();
			} */  else {
				query.append(fieldName);
				values.append("?");
				
				if(i+1 < items.size() && !(((FileItem)items.get(i+1)).getFieldName().equalsIgnoreCase("tableName" ))) {	
					query.append(",");
					values.append(",");
				}	
			}
			
		}	
		
		String sql = "INSERT INTO "+ tableName + " ( " + query.toString() + ") values("+ values.toString() + ")";
		System.out.println(sql);
		
		PreparedStatement stmt = dm.getDBConnection().prepareStatement(sql);
		int j = 1;
		
		for (int i = 0; i < items.size(); i++) {
			FileItem item = (FileItem) items.get(i);
			String fieldName ;
			
			if(item.isFormField()) {
				fieldName = item.getString();
				if(!(item.getFieldName().equalsIgnoreCase("tableName") || item.getFieldName().equalsIgnoreCase("jspName"))) {
					stmt.setString(j++, fieldName);
				}
			} else {
				String fileName = item.getName();
				stmt.setBinaryStream(j++, item.getInputStream());
			}
		}		
		stmt.execute();
		
		//response.sendRedirect("?instance=" + jspName);
	%>
	
</body>
</html>