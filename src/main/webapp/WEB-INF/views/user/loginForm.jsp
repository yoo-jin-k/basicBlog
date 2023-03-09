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

				<h1 class="logo">Login</h1>


				<!-- <ul class="menu">
					로그인 전 메뉴
					<li><a href="/basicBlog/user/loginForm">로그인</a></li>
					<li><a href="/basicBlog/user/joinForm">회원가입</a></li>
				</ul> -->

				<form class="login-form" method="post"
					action="${pageContext.request.contextPath}/user/doLogin">

					<div class="input-group">
						<span class="input-group-text">아이디</span> <input type="text"
							name="id" id="id" required="required" class="form-control"
							placeholder="Username">
					</div>

					<div class="input-group">
						<span class="input-group-text">패스워드</span> <input type="password"
							name="password" id="password" required="required"
							class="form-control" placeholder="password">
					</div>

					<div>
						<c:if test="${fail == 0}">

							<p class="form-error">
								로그인 실패<br> 아이디/패스워드를 확인해 주세요
							</p>
						</c:if>
					</div>




					<%-- <label>아이디</label> <input type="text" name="id" id="id" required="required"> 
						<label>패스워드</label> <input
						type="password" name="password" id="password" required="required" style="width: 240px; height: 27px;">

					<c:if test="${fail == 0}">
						<p class="form-error">
							로그인 실패<br> 아이디/패스워드를 확인해 주세요
						</p>
					</c:if> --%>

					<button class="btn btn-primary" type="submit" value="로그인" style="margin-bottom:15px;">
						로그인</button>
						<button type="button" class="btn btn-primary"><a href="/basicBlog/user/joinForm">회원가입</a></button>

				</form>
			</div>
		</div>

	</div>
</body>

</html>