package com.yourdistrict;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class WebScrapper {	
	
	Connection jsoupConn = null;
	
	public void establishConnection(String url) {
		jsoupConn = Jsoup.connect(url);
	}

	public Document getDocument() throws IOException {
		return jsoupConn.get();
	}
	
	public static void main(String[] args) {
		Connection jsoup = Jsoup.connect("https://www.google.co.in/");
		try {
			System.out.println(jsoup.get().body());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
