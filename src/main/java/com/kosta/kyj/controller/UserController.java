package com.kosta.kyj.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosta.kyj.service.UserService;
import com.kosta.kyj.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;

	//회원가입 성공페이지
	@RequestMapping(value = "/joinSuccess", method = RequestMethod.GET)
	public String joinSuccess() {
		return "/user/joinSuccess";
	}
	
	//id체크(중복이면1, 아니면0)
	//@RequestParam: 쿼리스트링으로  넘길때, @RequestBody: POST
	@ResponseBody
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public int checkId(@RequestBody UserVo userVo) {
		String id = userVo.getId();
		int result = userService.checkId(id);
		return result;
	}

	//회원가입 실행
	@RequestMapping(value = "/doJoin", method = RequestMethod.POST)
	public String doJoin(@ModelAttribute UserVo userVo) {
		int result = userService.doJoin(userVo);
		if(result == 1) {
			//회원가입시 blog테이블에도 정보 넣어야한다.
			userService.createBlog(userVo);
			return "redirect:/user/joinSuccess";
		}else {
			return "redirect:/user/doJoin";
		}
	}

	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "main/index";
	}
	
	//로그인
	@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
	public String doLogin(HttpServletRequest request, @ModelAttribute UserVo userVo, Model model) {
		HttpSession session = request.getSession();
		int resultCnt = userService.doLoginCnt(userVo);
		UserVo resultVo = userService.doLogin(userVo);
		
		if(resultCnt == 1) {
			session.setAttribute("authUser", resultVo);
			return "redirect:/";
		}else {
			int fail = 0;
			model.addAttribute("fail", fail);
			return "user/loginForm";
		}
	}
	
	
	
	
}
