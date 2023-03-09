package com.kosta.kyj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.kyj.vo.BlogVo;
import com.kosta.kyj.vo.CategoryVo;
import com.kosta.kyj.vo.PostVo;

@Repository
public class BlogDao {

	@Autowired
	private SqlSession session;

	//userNo에 맞는 카테고리 가져오기
	public List<CategoryVo> getCategory(int userNo) {
		return session.selectList("blog.getCategory", userNo);
	}

	//userNo에 맞는 게시글 가져오기
	public List<PostVo> getPost(int userNo) {
		return session.selectList("blog.getPost", userNo);
	}
	
	//제일최신의 게시글 가져오기
	public PostVo lastPost(int userNo) {
		return session.selectOne("blog.lastPost", userNo);
	}
	
	//게시글 제목 클릭 후 postNo에 맞는 게시물 화면에 표출
	public PostVo showPost(int postNo) {
		return session.selectOne("blog.showPost", postNo);
	}
	
	public BlogVo blogSetting(BlogVo blogVo) {
		return session.selectOne("blog.blogSetting", blogVo);
	}

	public List<CategoryVo> clickCate(CategoryVo categoryVo) {
		return session.selectList("blog.clickCate", categoryVo);
	}
	
}
