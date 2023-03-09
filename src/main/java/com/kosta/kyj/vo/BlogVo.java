package com.kosta.kyj.vo;

import org.springframework.web.multipart.MultipartFile;

public class BlogVo {

	private int userNo;
	private String blogTitle;
	private String logoFile;
	
	private MultipartFile file;
	
	
	public BlogVo() {
		super();
	}
	public BlogVo(int userNo, String blogTitle, String logoFile) {
		super();
		this.userNo = userNo;
		this.blogTitle = blogTitle;
		this.logoFile = logoFile;
	}
	public BlogVo(int userNo, String blogTitle, String logoFile, MultipartFile file) {
		super();
		this.userNo = userNo;
		this.blogTitle = blogTitle;
		this.logoFile = logoFile;
		this.file = file;
	}
	
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getBlogTitle() {
		return blogTitle;
	}
	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}
	public String getLogoFile() {
		return logoFile;
	}
	public void setLogoFile(String logoFile) {
		this.logoFile = logoFile;
	}
	
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	@Override
	public String toString() {
		return "BlogVo [userNo=" + userNo + ", blogTitle=" + blogTitle + ", logoFile=" + logoFile + ", file=" + file
				+ "]";
	}
	
	
}
