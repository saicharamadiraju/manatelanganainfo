package com.yourdistrict;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Date;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class RequestProcessor extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static Logger oLog = Logger.getLogger(RequestProcessor.class.getName());
	public void doGet(HttpServletRequest aRequest, HttpServletResponse aResponse) throws ServletException {
		doPost(aRequest, aResponse);
	}
	
	public void doPost(HttpServletRequest aRequest, HttpServletResponse aResponse) throws ServletException {
		dumpRequest(aRequest);
		
		String aQueryString = aRequest.getQueryString();
		
		String aPathInfo = aRequest.getPathInfo();
		
		if((null == aQueryString || "".equals(aQueryString)) && !isStaticContentRequest(aPathInfo)) {
			showWelcomeScreen(aRequest, aResponse);
		} else if (isStaticContentRequest(aPathInfo)) {
			StaticContentHandler andler = new StaticContentHandler();
			
			andler.processRequest(aRequest,aResponse);
		} else {
			String implClass = getServletConfig().getInitParameter("ImplementationClass");
			processRequest(aRequest,aResponse,implClass);
		}
	}

	private boolean isStaticContentRequest(String aPathInfo) {
		String[] keyWords = {"png","css","jpg","jpeg","js"}; 
		boolean isSCRequest = false;
		
		if(!(null == aPathInfo || "".equals(aPathInfo))) {
			
			for(String keyWord : keyWords) {
				String extension = aPathInfo.substring(aPathInfo.indexOf(".")+1);
				if(extension.equalsIgnoreCase(keyWord)) {
					isSCRequest = true;
					break;
				}
			}
		}
		return isSCRequest;
	}

	private String processRequest(HttpServletRequest aRequest,HttpServletResponse aResponse, String implClass) {
		String result = "";
		
		
		Class<?> c;
		try {
			c = Class.forName(implClass);
			Class[] argTypes = new Class[] { HttpServletRequest.class,HttpServletResponse.class };
			Method  method = c.getDeclaredMethod ("processRequest", argTypes);
			DistrictInfoBean bean = new DistrictInfoBean();
			
			result = (String) method.invoke (bean, aRequest,aResponse);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return result;
	}
	private void showWelcomeScreen(HttpServletRequest aRequest, HttpServletResponse aResponse) {
		try {
//			aRequest.getScheme() + "://" + aReq.getServerName() + 
			aRequest.getRequestDispatcher("/webwb/jsp/TelanganaStateMap.jsp").forward(aRequest, aResponse);
//			aResponse.sendRedirect("/JSP/TelanganaStateMap.jsp");
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void dumpRequest(HttpServletRequest aReq) {
		StringBuilder sb = new StringBuilder();
		sb.append("Dump HttpServletRequest");
		sb.append("\n\t getPathInfo = " + aReq.getPathInfo());
		sb.append("\n\t getPathTranslated = " + aReq.getPathTranslated());
		sb.append("\n\t getRemoteAddr = " + aReq.getRemoteAddr());
		sb.append("\n\t getRemoteHost = " + aReq.getRemoteHost());
		sb.append("\n\t getRemoteUser = " + aReq.getRemoteUser());
		sb.append("\n\t getRequestURI = " + aReq.getRequestURI());
		sb.append("\n\t getRequestedSessionId = " + aReq.getRequestedSessionId());
		sb.append("\n\t getProtocol = " + aReq.getProtocol());
		sb.append("\n\t getContextPath = " + aReq.getContextPath());
		sb.append("\n\t getContentType = " + aReq.getContentType());
		sb.append("\n\t getContentLength = " + aReq.getContentLength());
		sb.append("\n\t getAuthType = " + aReq.getAuthType());
		sb.append("\n\t getMethod = " + aReq.getMethod());
		sb.append("\n\t getQueryString = " + aReq.getQueryString());
		sb.append("\n\t getScheme = " + aReq.getScheme());
		sb.append("\n\t getServerName = " + aReq.getServerName());
		sb.append("\n\t getServerPort = " + aReq.getServerPort());
		sb.append("\n\t getServletPath = " + aReq.getServletPath());
		HttpSession session = aReq.getSession();
		if (session != null) {
			sb.append("\n\t session");
			sb.append("\n\t\t getId = " + session.getId());
			sb.append("\n\t\t getCreationTime = " + new Date(session.getCreationTime()));
			sb.append("\n\t\t getLastAccessedTime = " + new Date(session.getLastAccessedTime()));
			sb.append("\n\t\t getMaxInactiveInterval = " + session.getMaxInactiveInterval());
			Enumeration attributeNames = session.getAttributeNames();
			if (attributeNames.hasMoreElements()) {
				sb.append("\n\t\t attributes:");
				while (attributeNames.hasMoreElements()) {
					Object name = attributeNames.nextElement();
					sb.append("\n\t\t\t " + name + " = " + aReq.getAttribute((String) name));
				}
			}
		}
		sb.append("\n\t getUserPrincipal = " + aReq.getUserPrincipal());
		Cookie[] cookies = aReq.getCookies();
		if (cookies != null && cookies.length > 0) {
			sb.append("\n\t cookies:");
			for (Cookie c : cookies) {
				sb.append("\n\t\t [getComment=" + c.getComment() + ", getDomain=" + c.getDomain() + ", getMaxAge=" + c.getMaxAge() + ", getPath=" + c.getPath() + ", getName=" + c.getName() + ", getValue=" + c.getValue() + ", getSecure=" + c.getSecure() + ", getVersion=" + c.getVersion() + "]");
			}
		}
		Enumeration<String> headerNames = aReq.getHeaderNames();
		if (headerNames.hasMoreElements()) {
			sb.append("\n\t headers:");
			while (headerNames.hasMoreElements()) {
				String name = headerNames.nextElement();
				sb.append("\n\t\t " + name + " = " + aReq.getHeader(name));
			}
		}
		Enumeration<String> attributeNames = aReq.getAttributeNames();
		if (attributeNames.hasMoreElements()) {
			sb.append("\n\t attributes:");
			while (attributeNames.hasMoreElements()) {
				String name = attributeNames.nextElement();
				sb.append("\n\t\t " + name + " = " + aReq.getAttribute(name));
			}
		}
		
		oLog.log(Level.INFO,"printing the request : " + sb.toString());
	}
}
