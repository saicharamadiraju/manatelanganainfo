package com.yourdistrict;

import java.util.HashMap;
import java.util.Map;

public class NewsContentData {
	private static NewsContentData gInstance = null;
	
	public static NewsContentData getInstance() {
		if(null == gInstance) {
			gInstance = new NewsContentData();
		}	
		return gInstance;
	}
	
	private NewsContentData() {
		//TODO : overriding as singleton
	}
	
	private Map<String, NewsDataDTO> mapOfDTO = new HashMap<>();
	
	public void putNewsFeedObject(String key , NewsDataDTO dto) {
		mapOfDTO.put(key, dto);
	}
	
	public NewsDataDTO getNewsFeedObject(String key) {
		return mapOfDTO.get(key);
	}
}
