package com.yourdistrict;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StaticContentHandler {
	
	public void processRequest(HttpServletRequest aRequest,HttpServletResponse aResponse) {
		String servletPathInfo = aRequest.getPathInfo();
		new ResultDispatcher().redirectRequestToJSP(aRequest,aResponse,servletPathInfo);
	}
	
	public boolean isStaticContentRequest(String aPathInfo) {
		String[] keyWords = {"png","css","jpg","jpeg","js"}; 
		boolean isSCRequest = false;
		
		if(!(null == aPathInfo || "".equals(aPathInfo))) {
			
			for(String keyWord : keyWords) {
				if(aPathInfo.contains(keyWord)) {
					isSCRequest = true;
					break;
				}
			}
		}
		return isSCRequest;
	}
}
