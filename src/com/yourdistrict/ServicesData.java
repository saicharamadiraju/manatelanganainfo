package com.yourdistrict;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ServicesData {
	
	public static final String MEESEVA_SERVICES = "Meeseva Services";
	public static final String STATE_SERVICES = "State Services";
	public static final String CENTRAL_SERVICES = "Central Services";
	public static final String UTILITY_SERVICES = "Utility Services";

	private Map<String,List<ServiceDataDTO>> serviceEntries = new HashMap<>();
	
	private static ServicesData gInstance = null;
	
	public static ServicesData getInstance() {
		if(null == gInstance) {
			gInstance = new ServicesData();
		}	
		return gInstance;
	}
	
	private ServicesData() {
		loadData();
	}
	
	public List<ServiceDataDTO> getServicesWithName(String servicename) {
		return serviceEntries.get(servicename);
	}
	
	private void loadData() {
		try {
			List<ServiceDataDTO> stateServices = new ArrayList<>();
			List<ServiceDataDTO> utilityServices = new ArrayList<>();
			List<ServiceDataDTO> centralServices = new ArrayList<>();
			List<ServiceDataDTO> meesevaServices = new ArrayList<>();
			
			DataManager dm = new DataManager();
			String query = "SELECT * FROM content.stateservices";

			ResultSet rs = dm.getResultSet(query);

			while(rs.next()) {
				String serviceName = rs.getString("servicename");
				String serviceType = rs.getString("servicetype");
				String serviceLink = rs.getString("servicelink");
				
				ServiceDataDTO dto = new ServiceDataDTO();
				dto.setServiceLink(serviceLink);
				dto.setServiceName(serviceName);
				dto.setServiceType(serviceType);
				
				if(serviceName.equals(MEESEVA_SERVICES)) {
					meesevaServices.add(dto);
				} else if(serviceName.equals(STATE_SERVICES)) {
					stateServices.add(dto);
				} else if(serviceName.equals(CENTRAL_SERVICES)) {
					centralServices.add(dto);
				} else {
					utilityServices.add(dto);
				}
				
				serviceEntries.put(MEESEVA_SERVICES, meesevaServices);
				serviceEntries.put(CENTRAL_SERVICES, centralServices);
				serviceEntries.put(STATE_SERVICES, stateServices);
				serviceEntries.put(UTILITY_SERVICES, utilityServices);
			}
		} catch(Exception  e) {

		}
	}
}
