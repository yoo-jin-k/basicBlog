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

							// contentType:??"application/json" ??? ?????????
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
											$("#showPost").empty(); //????????!
											var results = res;
											var str = '<div class="card">'
													+ '<div class="card-body">'
													+ '<h5 class="card-title" id="resultPostTitle">'
													+ results.postTitle
													+ '</h5>'
													+ '<p class="card-text" id="resultPostContent">'
													+ results.postContent
													+ '</p>'
													+ '</div>'
													+ '</div>';
											$("#showPost").append(str);
										},
										error : function(xhr, error) { //xmlHttpRequest?
											console.error("error : " + error);
										}
									});
						});

		//???????????? ??????????????? ?????? ??????????????? ???????????? ?????????
		$(document)
				.on(
						"click",
						"a[id='cateName']",
						function() {
							//?????? ????????? ????????? ????????? id: ${userVo.id}
							var userNo = $("#userNo").val();
							var id = $("#userId").val();
							//cateNo????????????
							var parentID = $(this).closest('li').attr('id')
							var cateNo = $(this).closest('li')
									.children('input').attr('value');
							console.log("clicked cateNo: " + cateNo);

							// contentType:??"application/json" ??? ?????????
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
											$(".blog-list").empty();
											var results = res;
											var str = '<ul>';
											$
													.each(
															results,
															function(i) {
																str += '<li id="?????????li">';
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

			<!-- ????????? ????????? ????????? -->
			<input type="hidden" id="userNo" value="${userVo.userNo}"> <input
				type="hidden" id="userId" value="${userVo.id}">
			<div id="container">
				<a href="/basicBlog/main">
					<h1 class="logo">Basic Blog</h1>
				</a>

				<div class="blog_box">
					<!-- ????????? ?????? -->
					<div id="header">
						<h1>
							<a href="/basicBlog/${userVo.id}">${basic.blogTitle}?????? ?????????</a>
						</h1>
						<%-- <c:import url='/WEB-INF/views/include/blog_header.jsp' /> --%>
						<ul class="blog_menu">
							<c:choose>
								<c:when test='${empty authUser}'>
									<!-- ????????? ??? ?????? -->
									<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/user/loginForm">?????????</a>
										</button></li>
									<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/user/joinForm">????????????</a>
										</button></li>
								</c:when>
								<c:otherwise>
									<!-- ????????? ??? ?????? -->
									<%--<li>???????????? ?????????: ${authUser.id}</li>
				  			<li>?????? ????????? ?????????: ${userVo.id}</li> --%>
									<c:choose>
										<c:when test="${authUser.id eq userVo.id}">
											<li><button type="button" class="btn btn-primary">
													<a href="/basicBlog/${authUser.id}/admin/basic">???????????? ??????</a>
												</button></li>
										</c:when>
									</c:choose>
									<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/user/logout">????????????</a>
										</button></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>

					<div class="blog_info">
						<div id="wrapper">
							<div id="content">
								<!-- ????????? ????????? ?????? -->
								<div class="blog-content" id="lastPost">
									<div class="card" >
										<div class="card-body">
											<h5 class="card-title">${lastPostVo.postTitle}</h5>

											<p class="card-text">${lastPostVo.postContent}</p>

										</div>
									</div>
									<%-- <h4>${lastPostVo.postTitle}</h4>
									<p>
										${lastPostVo.postContent}<br>
									</p> --%>
								</div>
								<!-- ????????? ???????????? ?????? ?????? -->
								<div class="blog-content" id="showPost">
								<div class="card">
										<div class="card-body">
											<h5 class="card-title" id="resultPostTitle"></h5>

											<p class="card-text" id="resultPostContent"></p>

										</div>
									</div>
									
									


<!-- 
									<div>
										<h4 id="resultPostTitle"></h4>
									</div>
									<div>
										<p id="resultPostContent"></p>
									</div> -->

								</div>

								<!-- ????????? ?????????????????? ?????? -->
								<ul class="blog-list">
									<c:choose>
										<c:when test='${empty postVo}'>
											<p>????????? ?????? ????????????.</p>
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
											<%-- <img
												src="${pageContext.request.contextPath}/assets/upload/${basic.logoFile}"> --%>
											<img
												src="${pageContext.request.contextPath}/assets/images/basicblog_setting.jpg">
										</c:otherwise>
									</c:choose>
								</div>
							</div>


							<div id="navigation">
								<h2>????????????</h2>
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

					<!-- ??????-->
					<div id="footer">
						<p>
							<strong>Spring ?????????</strong> is powered by basicBlog (c)2023
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>