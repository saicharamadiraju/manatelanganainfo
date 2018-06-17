package com.yourdistrict;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResultDispatcher {
	
	
	public void redirectRequestToJSP(HttpServletRequest aRequest, HttpServletResponse aResponse,String aJSPName) {
		try {
			aRequest.getRequestDispatcher(aJSPName).forward(aRequest, aResponse);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
