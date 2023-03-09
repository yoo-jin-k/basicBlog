<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BasicBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicBlog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js">
$(function(){
	var message = $("#msg").val();
	if(message == "success"){
		alert("게시글이 등록되었습니다.");
	}else if(message == "fail"){
		alert("게시글 등록에 실패했습니다.");
	}
});
</script>
</head>
<body>
	<input type="hidden" id="msg" value="${msg}">	
	<div id="container">
		<!-- 블로그 해더 -->
		<div id="header">
			<h1><a href="/basicBlog/main">${basic.blogTitle}</a></h1>
			<ul class="menu">
				<c:choose>
					<c:when test='${empty authUser}'>
						<!-- 로그인 전 메뉴 -->
						<li><a href="/basicBlog/user/loginForm">로그인</a></li>
						<li><a href="/basicBlog/user/joinForm">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<!-- 로그인 후 메뉴 -->
						<%--<li>로그인한 사용자: ${authUser.id}</li>
				  			<li>현재 방문한 페이지: ${userVo.id}</li> --%>
						<c:choose>
							<c:when test="${authUser.id eq userVo.id}">
								<li><a href="/basicBlog/${authUser.id}/admin/basic">내블로그 관리</a></li> 
							</c:when>
						</c:choose>
						<li><a href="/basicBlog/user/logout">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		
		
		<div id="wrapper">
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li class="selected"><a href="/basicBlog/${authUser.id}/admin/basic">기본설정</a></li>
					<li><a href="/basicBlog/${authUser.id}/admin/category">카테고리</a></li>
					<li><a href="/basicBlog/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
				<form action="/basicBlog/${authUser.id}/admin/blogSetting" method="post" enctype="multipart/form-data">
	 		      	<table class="admin-config">
			      		<tr>
			      			<td class="t">블로그 제목</td>
			      			<td><input type="text" size="40" name="blogTitle" value="${basic.blogTitle}"></td>
			      		</tr>
			      		<tr>
			      			<td class="t">로고이미지</td>
			      			<td><img src=""></td>   
			      		</tr>      		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td><input type="file" name="file"></td>      			
			      		</tr>           		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td class="s">
			      				<input type="submit" value="기본설정 변경">
			      			</td>      			
			      		</tr>           		
			      	</table>
				</form>
			</div>
		</div>
		
		
		<!-- 푸터-->
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by basicBlog (c)2023
			</p>
		</div>
	
	</div>
</body>

</html>
