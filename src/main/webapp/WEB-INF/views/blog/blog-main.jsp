<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('#showPost').hide();

		var lastPostNo = $('#liiiiiiiiii').children('input').attr('value');
		console.log("lastPostNo:  " + lastPostNo);

		var postNo;
		console.log("postNo:  " + postNo);

		$(document)
				.on(
						"click",
						"a[id='postTitle']",
						function() {
							var parentID = $(this).closest('li').attr('id');
							console.log(parentID);

							postNo = $(this).closest('li').children('input')
									.attr('value');
							console.log("clicked postNo: " + postNo);
							$('#lastPost').hide();
							$('#showPost').show();

							// contentType: "application/json" 꼭 써주기
							$
									.ajax({
										url : "${pageContext.servletContext.contextPath}/showPost",
										type : "POST",
										dataType : "json",
										contentType : "application/json",
										data : JSON.stringify({
											"postNo" : postNo
										}),
										success : function(res) {
											$("#showPost").empty(); // 해결!
											var results = res;
											var str = '<h4 id="resultPostTitle">'
													+ results.postTitle
													+ '</h4>';
											str += '<p id="resultPostContent">'
													+ results.postContent
													+ '</p>';
											$("#showPost").append(str);
										},
										error : function(xhr, error) { //xmlHttpRequest?
											console.error("error : " + error);
										}
									});
						});

		//카테고리 클릭했을때 해당 카테고리의 포스팅만 나오기
		$(document)
				.on(
						"click",
						"a[id='cateName']",
						function() {
							//현재 방문한 블로그 주인의 id: ${userVo.id}
							var userNo = $("#userNo").val();
							var id = $("#userId").val();
							//cateNo가져오기
							var parentID = $(this).closest('li').attr('id')
							var cateNo = $(this).closest('li')
									.children('input').attr('value');
							console.log("clicked cateNo: " + cateNo);

							// contentType: "application/json" 꼭 써주기
							$
									.ajax({
										url : "${pageContext.servletContext.contextPath}/cateTitle",
										type : "POST",
										dataType : "json",
										contentType : "application/json",
										data : JSON.stringify({
											"cateNo" : cateNo,
											"userNo" : userNo
										}),
										success : function(res) {
											$(".blog-list").empty(); // 해결!
											var results = res;
											var str = '<ul>';
											$
													.each(
															results,
															function(i) {
																str += '<li id="나왔다li">';
																str += '<input type="hidden" name="postNo" value="'+results[i].postNo+'\">';
																str += '<a id="postTitle">'
																		+ results[i].postTitle
																		+ '</a>';
																str += '<span>'
																		+ results[i].regDate
																		+ '</span>';
																str += '</li>';
																str += '</ul>';
															});
											$(".blog-list").append(str);
										},
										error : function(xhr, error) { //xmlHttpRequest?
											console.error("error : " + error);
										}
									});
						});
	});
</script>
</head>
<body id="body">
	<div class="center-content">
		<div class="container_bg">

			<!-- 블로그 주인의 아이디 -->
			<input type="hidden" id="userNo" value="${userVo.userNo}"> <input
				type="hidden" id="userId" value="${userVo.id}">
			<div id="container">
				<a href="/basicBlog/main">
					<h1 class="logo">Basic Blog</h1>
				</a>

				<div class="blog_box">
					<!-- 블로그 해더 -->
					<div id="header">
						<h1>
							<a href="/basicBlog/${userVo.id}">${basic.blogTitle}님의 블로그</a>
						</h1>
						<ul class="blog_menu">
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
											<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/${authUser.id}/admin/basic">내블로그
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
							<div id="content">
								<!-- 최신의 게시글 표출 -->
								<div class="blog-content" id="lastPost">
									<h4>${lastPostVo.postTitle}</h4>
									<p>
										${lastPostVo.postContent}<br>
									</p>
								</div>
								<!-- 선택한 게시글의 내용 표출 -->
								<div class="blog-content" id="showPost">
									<h4 id="resultPostTitle"></h4>
									<p id="resultPostContent"></p>
								</div>

								<!-- 작성된 게시글리스트 표출 -->
								<ul class="blog-list"
									style="border-color: #eeeeee; border-style: solid;">
									<c:choose>
										<c:when test='${empty postVo}'>
											<p>등록된 글이 없습니다.</p>
										</c:when>
										<c:otherwise>
											<c:forEach items="${postVo}" var="postVo" varStatus="status">
												<li id="liiiiiiiiii"><input type="hidden" name="postNo"
													value="${postVo.postNo}"> <a id="postTitle">${postVo.postTitle}</a>
													<span>${postVo.regDate}</span></li>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
						</div>
						
						<div class="blog_side">
						<div id="extra">
							<div class="blog-logo">
								<c:choose>
									<c:when
										test="${basic.logoFile eq 'notExist' || empty basic.logoFile}">
										<img
											src="${pageContext.request.contextPath}/assets/images/basicblog_setting.jpg">
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/assets/upload/${basic.logoFile}">
									</c:otherwise>
								</c:choose>
							</div>
						</div>


						<div id="navigation">
							<h2>카테고리</h2>
							<ul>
								<c:forEach items="${categoryVo}" var="categoryVo"
									varStatus="status">
									<li><a id="cateName">${categoryVo.cateName}</a> <input
										type="hidden" id="cateNo" value="${categoryVo.cateNo}">
									</li>
								</c:forEach>
							</ul>
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