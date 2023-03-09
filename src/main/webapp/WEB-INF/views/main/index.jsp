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
</head>
<body>
	<div class="center-content">
		<div class="container_bg">
		
		
			<div class="container_box">


				<!-- 메인해더 -->
				<a href="/basicBlog/main">
					<h1 class="logo">Basic Blog</h1>
				</a>
				<ul class="menu">
					<c:choose>
						<c:when test='${empty authUser}'>
							<!-- 로그인 전 메뉴 -->
							<li><button type="button" class="btn btn-primary"><a href="/basicBlog/user/loginForm">로그인</a></button></li>
							<li><button type="button" class="btn btn-primary"><a href="/basicBlog/user/joinForm">회원가입</a></button></li>
						</c:when>
						<c:otherwise>
							<!-- 로그인 후 메뉴 -->
							<li><button type="button" class="btn btn-primary"><a href="/basicBlog/user/logout">로그아웃</a></button></li>
							<li><button type="button" class="btn btn-primary"><a href="/basicBlog/${authUser.id}">내블로그</a></button></li>
						</c:otherwise>
					</c:choose>
				</ul>

				<form class="search-form">
					<div class="search_box1">
  						<input type="text" name="keyword" id="floatingInput" placeholder="Search">
  					
					<button class="btn btn-primary" type="submit" value="검색">
						Search
					</button>
					</div>
					<div class="search_box2">
					<!-- <input type="radio" name="which" value="blog-title"> <label>블로그
							제목</label> <input type="radio" name="which" value="blog-user"> <label>블로거</label>
					</div> -->
					
					
					
				</form>
			</div>
		</div>
	</div>
</body>
</html>