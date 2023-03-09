package com.kosta.kyj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.kyj.repository.BlogAdminDao;
import com.kosta.kyj.vo.BlogVo;
import com.kosta.kyj.vo.CategoryVo;
import com.kosta.kyj.vo.PostVo;

@Service
public class BlogAdminService {

	@Autowired
	private BlogAdminDao blogAdminDao;

	//기존 정보들 블로그 관리 화면에 표출
	public BlogVo getData(int userNo) {
		return blogAdminDao.getData(userNo);
	}

	//내블로그 관리페이지 > 기본설정변경버튼
	public int blogSetting(BlogVo blogVo) {
		return  blogAdminDao.blogSetting(blogVo);
	}

	//내블로그 관리 > 카테고리
	public List<CategoryVo> getCateData(int userNo) {
		return  blogAdminDao.getCateData(userNo);
	}

	//카테고리 리스트 추가
	public void addCate(CategoryVo catevo) {
		blogAdminDao.addCate(catevo);
	}

	//선택한 카테고리의 포스트 수를 가져오기
	public CategoryVo getCountPost(CategoryVo catevo) {
		return  blogAdminDao.getCountPost(catevo);
	}

	//카테고리 삭제
	public int delete(int cateNo) {
		return blogAdminDao.delete(cateNo);
	}

	//글작성
	public int writePost(PostVo postVo) {
		return blogAdminDao.writePost(postVo);
	}


	
	
}
