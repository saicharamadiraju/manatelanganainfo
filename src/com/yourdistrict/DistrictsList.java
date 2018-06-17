package com.yourdistrict;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DistrictsList {
	private static DistrictsList gInstance = null;
	
	public static DistrictsList getInstance() {
		if(gInstance == null) {
			gInstance = new DistrictsList();
		}	
		return gInstance;
	}
	
	private DistrictsList() {
		//gInstance = new DistrictsList();
	}
	
	private List<String> districts = null;
	
	public List<String> getDistrictsList() {
		if(districts == null || districts.isEmpty()) {

			ResultSet rs1 = null;
			try {
				String tableName = "districtinformation";
				String[] columnNames = { "name" };
				DataManager dm = new DataManager();
				rs1 = dm.getResultSet(tableName, columnNames);

				districts = new ArrayList<String>();
				while (rs1.next()) {
					String districtName = rs1.getString("name");
					districts.add(districtName);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs1 != null)
						rs1.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}	
		}

		return districts;
	}
}
