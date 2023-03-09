package com.kosta.kyj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosta.kyj.service.BlogAdminService;
import com.kosta.kyj.service.BlogService;
import com.kosta.kyj.service.UserService;
import com.kosta.kyj.vo.BlogVo;
import com.kosta.kyj.vo.CategoryVo;
import com.kosta.kyj.vo.PostVo;
import com.kosta.kyj.vo.UserVo;

@Controller
public class BlogController {

	@Autowired
	private UserService userService;
	@Autowired
	private BlogService blogService;
	@Autowired
	private BlogAdminService blogAdminService;
	
	//내블로그 페이지
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String blogMain(@PathVariable("id") String id, Model model) {
		int userNo;
		//1.db에서 주소창에 쓴 id가 있는지 확인
		int count = userService.checkId(id);
		//2.있으면 그 id에 맞는 userNo, userName값 가져오기
		if(count == 1) {
			UserVo userVo = userService.getUserNo(id);
			model.addAttribute("userVo", userVo);
			userNo = userVo.getUserNo();
			
			//3.blog정보가져오기
			BlogVo basic = new BlogVo();
			basic = blogAdminService.getData(userNo);
			model.addAttribute("basic",basic);
			
			//4.userNo에 맞는 category,post 가져오기
			//category
			List<CategoryVo> categoryVo = blogService.getCategory(userNo);
			model.addAttribute("categoryVo", categoryVo);
			//post
			//getPost: postNo, postTitle, postContent
			List<PostVo> postVo = blogService.getPost(userNo);
			model.addAttribute("postVo", postVo);
			if(postVo.size() == 0) {
				return "blog/blog-main";
			}else {
				model.addAttribute("lastPostVo", postVo.get(0));
				return "blog/blog-main";
			}
			//model.addAttribute("lastPostVo", postVo.get(0));
		}else {
			return "blog/blog-error";
		}
	}
	
	//게시글 제목 클릭 후 postNo에 맞는 게시물 화면에 표출
	@ResponseBody
	@RequestMapping(value = "/showPost", method = RequestMethod.POST)
	public PostVo showPost(@RequestBody PostVo postVo) {
		int postNo = postVo.getPostNo();
		System.out.println("postNo : "+postNo);
		
		PostVo showPost = blogService.showPost(postNo);
		System.out.println(showPost);
		
		PostVo pv = new PostVo();
		pv.setPostTitle(showPost.getPostTitle());
		pv.setPostContent(showPost.getPostContent());
		return pv;
	}
	
	//게시글 제목 클릭 후 postNo에 맞는 게시물 화면에 표출
	@ResponseBody
	@RequestMapping(value = "/cateTitle", method = RequestMethod.POST)
	public List<CategoryVo> cateTitle(@RequestBody CategoryVo categoryVo) {
		System.out.println("userNo "+categoryVo.getUserNo());
		System.out.println("cateNo: "+categoryVo.getCateNo());
		
		//userNo와 cateNo를 넘겨 값을 받아온다.
		List<CategoryVo> listcategoryVo = blogService.clickCate(categoryVo);
		
		return listcategoryVo;
	}
	
}
