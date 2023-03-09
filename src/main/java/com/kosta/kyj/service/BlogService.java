package com.kosta.kyj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.kyj.repository.BlogDao;
import com.kosta.kyj.vo.BlogVo;
import com.kosta.kyj.vo.CategoryVo;
import com.kosta.kyj.vo.PostVo;

@Service
public class BlogService {

	@Autowired
	private BlogDao blogDao;
	
	//userNo에 맞는 카테고리 가져오기
	public List<CategoryVo> getCategory(int userNo) {
		return blogDao.getCategory(userNo);
	}

	//userNo에 맞는 게시글 가져오기
	public List<PostVo> getPost(int userNo) {
		return blogDao.getPost(userNo);
	}

	//제일최신의 게시글 가져오기
	public PostVo lastPost(int userNo) {
		return blogDao.lastPost(userNo);
	}

	//게시글 제목 클릭 후 postNo에 맞는 게시물 화면에 표출
	public PostVo showPost(int postNo) {
		return blogDao.showPost(postNo);
	}
	
	public BlogVo blogSetting(BlogVo blogVo) {
		return blogDao.blogSetting(blogVo);
	}

	public List<CategoryVo> clickCate(CategoryVo categoryVo) {
		return blogDao.clickCate(categoryVo);
	}

	
}
