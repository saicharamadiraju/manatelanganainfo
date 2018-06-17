package com.yourdistrict;

import java.util.Arrays;
import java.util.List;

public class BloodGroups {
	public static final List<String> getBloodGroupsList() {
		List<String> bloodGroupsList = Arrays.asList("A+",
										"A-",
										"AB+",
										"AB-",
										"B+",
										"B-",
										"O+",
										"O-",
										/*"A1+",
										"A1-",
										"A2+",
										"A2-",
										"A1B+",
										"A1B-",
										"A2B+",
										"A2B-",*/
										"Bombay_Blood_Group");
		
		return bloodGroupsList;
	}
	
	public static final String getBloodGroupsDropDownHTML(String divID) {
		String resultHTML =  
				"		<select id=\""+ divID +"\" > <option value=\"\">Select One</option>";
		
		for(String bloodGroup : getBloodGroupsList()) {
			resultHTML += "<option value=\""+bloodGroup+"\">"+ bloodGroup + "</option>";
		}
		
	resultHTML += "</select>"; 
		
		System.out.println(resultHTML);
		return resultHTML;
	}
	
}	