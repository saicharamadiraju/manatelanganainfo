package com.yourdistrict;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BloodNeeds {
	
	public String getPostedNeedsForDistrict(String districtName) {
		
		
		String htmlHead = "<html>\r\n" + 
				"<head>\r\n" + 
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n" + 
				"<title>Telangana</title></head>";
		
		String htmlResponse = htmlHead;
		String query = "SELECT * from content.bloodneeds WHERE DistrictName LIKE '" + districtName + "'";		
		
		DataManager dm = new DataManager();
		ResultSet rs = dm.getResultSet(query);

		htmlResponse += "<body><table id=\"outerViewNeedsTable\" style=\"border:1px solid black;\">";
		try {
			while(rs.next()) {
				String neededFor = rs.getString("neededfor");
				String purpose = rs.getString("purpose");
				String contactNumber = rs.getString("needyphone");
				String location = rs.getString("needylocation");
				String date = rs.getString("datewhenrequired");
				String bloodGroup = rs.getString("needybloodgroup");

				
				htmlResponse += "<tr><td><table name=\"viewNeedsTable\"  style=\"border-bottom :1px solid black;\">\r\n" + 
						"			<tr>\r\n" + 
						"				<td>\r\n" + 
						"				Needed Blood Group:\r\n" + 
						"				</td>\r\n" + 
						"				<td>" + bloodGroup + "\r\n" + 
						"				</td>\r\n" + 
						"			</tr>\r\n" + 
						"			<tr>\r\n" + 
						"				<td>\r\n" + 
						"				Place Required:\r\n" + 
						"				</td>\r\n" + 
						"				<td>"+ location +"\r\n" + 
						"				</td>\r\n" + 
						"			</tr>\r\n" + 
						"			<tr>\r\n" + 
						"				<td>\r\n" + 
						"				Contact Person:\r\n" + 
						"				</td>\r\n" + 
						"				<td>"+ neededFor+"\r\n" + 
						"				</td>\r\n" + 
						"			</tr>\r\n" + 
						"			<tr>\r\n" + 
						"				<td>\r\n" + 
						"				Phone number:\r\n" + 
						"				</td>\r\n" + 
						"				<td>"+ contactNumber +"\r\n" + 
						"				</td>\r\n" + 
						"			</tr>\r\n" + 
						"			<tr>\r\n" + 
						"				<td>\r\n" + 
						"				Date when required:\r\n" + 
						"				</td>\r\n" + 
						"				<td>"+ date +"\r\n" + 
						"				</td>\r\n" + 
						"			</tr>\r\n" + 
						"			<tr>\r\n" + 
						"				<td>\r\n" + 
						"				Purpose:\r\n" + 
						"				</td>\r\n" + 
						"				<td>"+ purpose +"\r\n" + 
						"				</td>\r\n" + 
						"			</tr>\r\n" + 
						"		</table></td></tr>"	;
					}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		htmlResponse += "</table></body></html>";
		return htmlResponse;
	}
}
