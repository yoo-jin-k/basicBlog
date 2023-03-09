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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function() {
		var authUserId = $("#authUserId").val();
		if (typeof authUserId == null || authUserId == "") {
			alert("로그인 하셔야 합니다.");
			location.href = "/basicBlog/user/loginForm";
		}

		$(document)
				.on(
						"click",
						"input[id='btnAddCate']",
						function() {
							var id = $("#authUserId").val();
							var cateName = $("#cateName").val();
							var description = $("#description").val();
							var userNo = $("#userNo").val();
							//console.log("cateName: "+cateName);
							//console.log("description: "+description);
							//console.log("userNo: "+userNo);

							//contentType: "application/json" 꼭 써주기
							$
									.ajax({
										url : "${pageContext.servletContext.contextPath}/"
												+ id + "/admin/addCate",
										type : "POST",
										dataType : "json",
										contentType : "application/json",
										data : JSON.stringify({
											"userNo" : userNo,
											"cateName" : cateName,
											"description" : description
										}),
										success : function(res) {
											// URL 주소에 존재하는 HTML 코드에서 <div>요소를 읽은 후에 id가 "container"인 요소에 배치한다.
											$("#container")
													.load(
															"/basicBlog/"
																	+ id
																	+ "/admin/category div");
										},
										error : function(xhr, error) { //xmlHttpRequest?
											console.error("error : " + error);
										}
									});
						});

		var countPost;
		var id;
		var cateName;
		var userNo;
		var cateNo;
		//삭제버튼 눌렀을 때
		$(document).on(
				"click",
				"td[id='btnDelete']",
				function() {
					id = $("#authUserId").val();
					cateNo = $(this).closest('td').children('input').attr(
							'value');
					userNo = $("#userNo").val();
					$.ajax({
						url : "${pageContext.servletContext.contextPath}/" + id
								+ "/admin/countPost",
						type : "POST",
						dataType : "json",
						async : false, //ajax가 두개 실행되기 때문에 async: false를 사용해서 해당 ajax가 먼저 실행된 후 밑 ajax가 실행되도록 설정
						contentType : "application/json",
						data : JSON.stringify({
							"userNo" : userNo,
							"cateNo" : cateNo
						}),
						success : function(cv) {
							console.log("success countPost: " + cv.countPost);
							countPost = cv.countPost;
						},
						error : function(xhr, error) {
							console.error("error : " + error);
						}
					})

					if (countPost > 0) {
						alert("삭제할 수 없습니다.");
					} else {
						$.ajax({
							url : "${pageContext.servletContext.contextPath}/"
									+ id + "/admin/deleteCate",
							type : "POST",
							dataType : "json",
							contentType : "application/json",
							data : JSON.stringify({
								"userNo" : userNo,
								"cateNo" : cateNo
							}),
							success : function(catevo) {
								alert("삭제되었습니다.");
								// URL 주소에 존재하는 HTML 코드에서 <div>요소를 읽은 후에 id가 "container"인 요소에 배치한다.
								$("#container").load(
										"/basicBlog/" + id
												+ "/admin/category div");
							},
							error : function(xhr, error) { //xmlHttpRequest?
								console.error("error : " + error);
							}
						})
					}

				});
	});
</script>
</head>
<body id="body">
	<div class="center-content">
		<div class="container_bg">
			<div id="container">
				<a href="/basicBlog/main">
					<h1 class="logo">Basic Blog</h1>
				</a>
				<div class="blog_box">
					<!-- 블로그 해더 -->
					<div id="header">
						<input type="hidden" id="authUserId" value="${authUser.id}">
						<input type="hidden" id="userNo" value="${userNo}">
						<h1>
							<a href="/basicBlog/main">${basic.blogTitle}</a>
						</h1>
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
								<li class="selected">
								<li><a href="/basicBlog/${authUser.id}/admin/category">카테고리</a></li>
								<li><a href="/basicBlog/${authUser.id}/admin/write">글작성</a></li>
							</ul>
							<table class="admin-cat" id="catTable">
								<thead>
									<tr>
										<th>번호</th>
										<th>카테고리명</th>
										<th>포스트 수</th>
										<th>설명</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody id="cateList">
									<c:set var="cateVoLength" value="${fn:length(cateVo)}" />
									<c:forEach items="${cateVo}" var="cateVo" varStatus="status">
										<tr>
											<td>${cateVoLength-status.count+1}</td>
											<td>${cateVo.cateName}</td>
											<td>${cateVo.countPost}</td>
											<td>${cateVo.description}</td>
											<td id="btnDelete"><img
												src='${pageContext.request.contextPath}/assets/images/delete.jpg'>
												<input id="cateNo" type="hidden" value="${cateVo.cateNo}">
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<h4 class="n-c">새로운 카테고리 추가</h4>
							<table id="admin-cat-add">
								<tr>
									<td class="t">카테고리명</td>
									<td><input type="text" name="name" value="" id="cateName"></td>
								</tr>
								<tr>
									<td class="t">설명</td>
									<td><input type="text" name="desc" id="description"></td>
								</tr>
								<tr>
									<td class="s">&nbsp;</td>
									<td><input id="btnAddCate" type="submit" value="카테고리 추가"></td>
								</tr>
							</table>
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