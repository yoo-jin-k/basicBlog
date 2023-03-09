package com.kosta.kyj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.kyj.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	private SqlSession session;
	
	//회원가입
	public int insert(UserVo userVo) {
		int count = session.insert("user.join",userVo);
		if(count == 1) {
			return 1;
		}else {
			return 0; 
		}
	}

	//이메일 중복체크
	public int checkId(String id) {
		int count = session.selectOne("user.checkId",id);
		return count;
	}

	//로그인 개수
	public int doLoginCnt(UserVo userVo) {
		int count = session.selectOne("user.doLoginCnt",userVo);
		return count;
	}

	//로그인 실행
	public UserVo doLogin(UserVo userVo) {
		return session.selectOne("user.doLogin",userVo);
	}

	//회원가입시 blog테이블에도 정보 넣어야한다.
	public void createBlog(UserVo userVo) {
		session.insert("user.createBlog",userVo);
	}

	//id에 맞는 userNo, userName값 가져오기
	public UserVo getUserNo(String id) {
		return session.selectOne("user.getUserNo", id);
	}

	//userNo에 대한 id를 가져오기
	public String getId(int userNo) {
		return session.selectOne("user.getId", userNo);
	}

	

}
