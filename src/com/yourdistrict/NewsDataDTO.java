package com.yourdistrict;

public class NewsDataDTO {
	private String newsTitle;
	private String postedby;
	private String imageURL;
	private String districtName;
	private String contentURL;
	private String newsFeedKey;
	private String content;
	
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public String getPostedby() {
		return postedby;
	}
	public void setPostedby(String postedby) {
		this.postedby = postedby;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	public String getContentURL() {
		return contentURL;
	}
	public void setContentURL(String content) {
		this.contentURL = content;
	}
	
	public String getNewsFeedKey() {
		newsFeedKey = districtName+"/"+postedby+"/"+newsTitle;
		return newsFeedKey;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
