package com.kosta.kyj.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kosta.kyj.service.BlogAdminService;
import com.kosta.kyj.service.UserService;
import com.kosta.kyj.vo.BlogVo;
import com.kosta.kyj.vo.CategoryVo;
import com.kosta.kyj.vo.PostVo;
import com.kosta.kyj.vo.UserVo;

//내블로그 관리
@Controller
@RequestMapping("/{id}/admin")
public class BlogAdminController {
	final Logger logger = LoggerFactory.getLogger(BlogAdminController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BlogAdminService blogAdminService;
	
	//내블로그 관리페이지 이동
	@RequestMapping(value = "/basic", method = RequestMethod.GET)
	public String manageBlog(@PathVariable("id") String id, Model model) {
		//주소의id에 맞는 userNo가져오기
		UserVo userVo = userService.getUserNo(id);
		int userNo = userVo.getUserNo();
		model.addAttribute("userNo",userNo);
		//기존 정보들 블로그 관리 화면에 표출
		BlogVo basic = new BlogVo();
		basic = blogAdminService.getData(userNo);
		model.addAttribute("basic",basic);
		return "blog/admin/blog-admin-basic";
	}
	
	//내블로그 관리 > 카테고리이동
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	public String category(@PathVariable("id") String id, Model model) {
		//주소의id에 맞는 userNo가져오기
		UserVo uservo = userService.getUserNo(id);
		int userNo = uservo.getUserNo();
		//System.out.println("userNo는?!?: "+userNo);
		model.addAttribute("userNo",userNo);
		
		//기존 정보들 블로그 관리 화면에 표출
		BlogVo basic = new BlogVo();
		basic = blogAdminService.getData(userNo);
		model.addAttribute("basic",basic);
				
		//카테고리 데이터 가져오기(카테고리번호, 카테고리명, 포스트 수, 설명)
		List<CategoryVo> cateVo = blogAdminService.getCateData(userNo);
		model.addAttribute("cateVo",cateVo);
		
		return "blog/admin/blog-admin-cate";
	}
	
	
	//카테고리 리스트 추가
	@ResponseBody
	@RequestMapping(value = "/addCate", method = RequestMethod.POST)
	public CategoryVo addCate(@RequestBody CategoryVo catevo) {
		//insert -> userNo, cateName, description
		System.out.println("catevo.getUserNo(): "+catevo.getUserNo());
		System.out.println("catevo.getCateName(): "+catevo.getCateName());
		System.out.println("catevo.getDescription(): "+catevo.getDescription());
		blogAdminService.addCate(catevo);
		
		return catevo;
	}
	
	//카테고리 리스트 삭제 전 post개수확인
	@ResponseBody
	@RequestMapping(value = "/countPost", method = RequestMethod.POST)
	public CategoryVo countPost(@RequestBody CategoryVo catevo, Model model){
		//선택한 카테고리의 포스트 수를 가져오기 parameter = userNo, cateNo
		CategoryVo cv = blogAdminService.getCountPost(catevo);
		
		return cv;
	}
	
	//카테고리 리스트 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteCate", method = RequestMethod.POST)
	public CategoryVo deleteCate(@RequestBody CategoryVo catevo, Model model){
		int cateNo = catevo.getCateNo();
		blogAdminService.delete(cateNo);
		return catevo;
	}

	//내블로그 관리 > 글작성페이지
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write(@PathVariable("id") String id, Model model) {
		//주소의id에 맞는 userNo가져오기
		UserVo userVo = userService.getUserNo(id);
		int userNo = userVo.getUserNo();
		
		//기존 정보들 블로그 관리 화면에 표출
		BlogVo basic = new BlogVo();
		basic = blogAdminService.getData(userNo);
		model.addAttribute("basic",basic);
				
		//카테고리 데이터 가져오기(카테고리번호, 카테고리명, 포스트 수, 설명)
		List<CategoryVo> cateVo = blogAdminService.getCateData(userNo);
		model.addAttribute("cateVo",cateVo);
		
		return "blog/admin/blog-admin-write";
	}

	//내블로그 관리 > 글작성 실행
	@RequestMapping(value = "/writePost", method = RequestMethod.POST)
	public String writePost(@ModelAttribute PostVo postVo, @ModelAttribute UserVo uservo
							,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		postVo.toString();
		System.out.println(postVo.toString());
		String postTitle = postVo.getPostTitle();
		String postContent = postVo.getPostContent();
		if(postTitle.equals("") || postContent.equals("")) {
			redirectAttributes.addFlashAttribute("msg", "fail");
			String referer = request.getHeader("Referer");
			return "redirect:"+ referer;
		}else {
			 blogAdminService.writePost(postVo);
			redirectAttributes.addFlashAttribute("msg", "success");
			return "redirect:/"+ uservo.getId() +"/admin/write";
		}
		
	}
	
	//내블로그 관리페이지 > 기본설정변경버튼
	@RequestMapping(value = "/blogSetting", method = RequestMethod.POST)
	public String blogSetting(@ModelAttribute BlogVo blogVo, @ModelAttribute UserVo uservo, Model model
								,@RequestParam("file") MultipartFile file
								,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		//주소의id에 맞는 userNo가져오기
		UserVo userVo = userService.getUserNo(uservo.getId());
		int userNo = userVo.getUserNo();
		System.out.println(blogVo.toString());
		blogVo.setUserNo(userNo);
		
		//기존 정보들 블로그 관리 화면에 표출
		BlogVo basic = new BlogVo();
		basic = blogAdminService.getData(userNo);
		model.addAttribute("basic",basic);
	
		///////////////////////////파일업로드/////////////////////////////////////
		String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드!
		
		if(fileRealName.equals(null) || fileRealName.equals("")) {
			//기존 이력이 있는지 확인
			String logoName = basic.getLogoFile();
			//기존 이력이 있으면 기존의 로고파일 이름을 다시 넣어서 update시킴
			if(logoName != null && !logoName.equals("")) {
				blogVo.setLogoFile(logoName);
				blogAdminService.blogSetting(blogVo);
			}else {
				System.out.println("aaaaaaaaa  null");
				blogVo.setLogoFile("notExist");
				blogAdminService.blogSetting(blogVo);
			}
		}else {
			long size = file.getSize(); //파일 사이즈
			
			System.out.println("파일명 : "  + fileRealName);
			System.out.println("용량크기(byte) : " + size);
			//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			String uploadFolder = "/Users/yoo-jinkim/Documents/eclipse-study/basicBlog/src/main/webapp/assets/upload";
			
			/*
			  파일 업로드시 파일명이 동일한 파일이 이미 존재할 수도 있고 사용자가 
			  업로드 하는 파일명이 언어 이외의 언어로 되어있을 수 있습니다. 
			  타인어를 지원하지 않는 환경에서는 정산 동작이 되지 않습니다.(리눅스가 대표적인 예시)
			  고유한 랜던 문자를 통해 db와 서버에 저장할 파일명을 새롭게 만들어 준다.
			 */
			
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString());
			String[] uuids = uuid.toString().split("-");
			
			String uniqueName = uuids[0];
			System.out.println("생성된 고유문자열" + uniqueName);
			System.out.println("확장자명" + fileExtension);
			
			// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
			
			File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
			try {
				file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			String saveFileName = uniqueName+fileExtension;
			
			blogVo.setLogoFile(saveFileName);
		}
		int count = blogAdminService.blogSetting(blogVo);
		System.out.println("count: "+count);
		if(count == 1) {
			redirectAttributes.addFlashAttribute("msg", "success");
			return "redirect:/"+ uservo.getId() +"/admin/basic";
		}else {
			redirectAttributes.addFlashAttribute("msg", "fail");
			return "redirect:/"+ uservo.getId() +"/admin/basic";
		}
	}
	
	
}//end