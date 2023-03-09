package com.kosta.kyj.vo;

public class CategoryVo {
	private int cateNo;
	private int userNo;
	private String cateName;
	private String description;
	private String regDate;
	private int countPost;	//post 게시글 수
	
	public CategoryVo() {
		super();
	}
	public CategoryVo(int cateNo, int userNo, String cateName, String description, String regDate) {
		super();
		this.cateNo = cateNo;
		this.userNo = userNo;
		this.cateName = cateName;
		this.description = description;
		this.regDate = regDate;
	}
	public CategoryVo(int cateNo, int userNo, String cateName, String description, String regDate, int countPost) {
		super();
		this.cateNo = cateNo;
		this.userNo = userNo;
		this.cateName = cateName;
		this.description = description;
		this.regDate = regDate;
		this.countPost = countPost;
	}
	
	public int getCateNo() {
		return cateNo;
	}
	public void setCateNo(int cateNo) {
		this.cateNo = cateNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getCountPost() {
		return countPost;
	}
	public void setCountPost(int countPost) {
		this.countPost = countPost;
	}
	
	@Override
	public String toString() {
		return "CategoryVo [cateNo=" + cateNo + ", userNo=" + userNo + ", cateName=" + cateName + ", description="
				+ description + ", regDate=" + regDate + ", countPost=" + countPost + "]";
	}
	
}
