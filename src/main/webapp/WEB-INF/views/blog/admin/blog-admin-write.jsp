<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BasicBlog</title>
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/basicBlog.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function() {
		var authUserId = $("#authUserId").val();
		if (typeof authUserId == null || authUserId == "") {
			alert("로그인 하셔야 합니다.");
			location.href = "/basicBlog/user/loginForm";
		}

		var message = $("#msg").val();
		if (message == "success") {
			alert("게시글이 등록되었습니다.");
		} else if (message == "fail") {
			alert("게시글 등록에 실패했습니다.");
		}
	});
</script>
</head>
<body id="body">
	<div class="center-content">
		<div class="container_bg">
			<input type="hidden" id="authUserId" value="${authUser.id}">
			<input type="hidden" id="msg" value="${msg}">
			<div id="container">
				<a href="/basicBlog/main">
					<h1 class="logo">Basic Blog</h1>
				</a>

				<div class="blog_box">
					<!-- 블로그 해더 -->
					<div id="header">
						<h1>
							<a href="/basicBlog/${authUser.id}">${basic.blogTitle}님의 블로그</a>
						</h1>
						<ul class="menu">
							<c:choose>
								<c:when test='${empty authUser}'>
									<!-- 로그인 전 메뉴 -->
									<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/user/loginForm">로그인</a>
										</button></li>
									<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/user/joinForm">회원가입</a>
										</button></li>
								</c:when>
								<c:otherwise>
									<!-- 로그인 후 메뉴 -->
									<%--<li>로그인한 사용자: ${authUser.id}</li>
				  			<li>현재 방문한 페이지: ${userVo.id}</li> --%>
									<c:choose>
										<c:when test="${authUser.id eq userVo.id}">
											<li><button type="button" class="btn btn-primary"><a href="/basicBlog/${authUser.id}/admin/basic">내블로그
													관리</a></button></li>
										</c:when>
									</c:choose>
									<li><button type="button" class="btn btn-primary"><a href="/basicBlog/user/logout">로그아웃</a></button></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<div class="blog_info">


						<div id="wrapper">
							<div id="content" class="full-screen">
								<ul class="admin-menu">
									<li><a href="/basicBlog/${authUser.id}/admin/basic">기본설정</a></li>
									<li><a href="/basicBlog/${authUser.id}/admin/category">카테고리</a></li>
									<li class="selected"><a
										href="/basicBlog/${authUser.id}/admin/write">글작성</a></li>
								</ul>


								<form action="/basicBlog/${authUser.id}/admin/writePost"
									method="post">
									<table class="admin-cat-write">
										<tr>
											<td class="t" id="title">제목</td>
											<td><input type="text" size="60" name="postTitle">
												<select name="cateNo" id="cateNo">
													<c:forEach items="${cateVo}" var="cateVo"
														varStatus="status">
														<option value="${cateVo.cateNo}">${cateVo.cateName}</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr>
											<td class="t">내용</td>
											<td><textarea name="postContent"></textarea></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td class="s"><input id="btnWrite" type="submit"
												value="포스트하기"></td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>

					<!-- 푸터-->
					<div id="footer">
						<p>
							<strong>Spring 이야기</strong> is powered by basicBlog (c)2023
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>