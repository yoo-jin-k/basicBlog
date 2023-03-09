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
	var sel_file = [];
	$(document).ready(function() {
		var authUserId = $("#authUserId").val();
		if (typeof authUserId == null || authUserId == "") {
			alert("로그인 하셔야 합니다.");
			location.href = "/basicBlog/user/loginForm";
		}

		var message = $("#msg").val();
		if (message == "success") {
			alert("수정 완료되었습니다.");
		} else if (message == "fail") {
			alert("수정 실패하였습니다.");
		}

		//------------- 이미지 미리보기 시작 ------------------
		$("#input_img").on("change", handleImgFileSelect);

		//e : change 이벤트 객체
		// change 이벤트 설정하면  e는 이벤트가 된다. handleImgFileSelect에 파라미터 주면 e가 이벤트가 아니라 그냥 파라미터가 됨.
		function handleImgFileSelect(e) {

			console.log("여길봐라: " + JSON.stringify(e));
			//e.target : 파일객체
			//e.target.files : 파일객체 안의 파일들
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);

			//f : 파일 객체
			filesArr.forEach(function(f) {
				//미리보기는 이미지만 가능함
				if (!f.type.match("image.*")) {
					alert("이미지만 가능합니다");
					return;
				}

				// 파일객체 복사
				sel_file.push(f);

				//파일을 읽어주는 객체 생성
				var reader = new FileReader();
				reader.onload = function(e) {
					//forEach 반복 하면서 img 객체 생성
					var img_html = "<img src=\"" + e.target.result + "\" />";
					$(".img_wrap").append(img_html);
				}
				reader.readAsDataURL(f);
			});
		}

		//------------- 이미지 미리보기 끝 ------------------

		//첨부파일의 확장자가 exe, sh, zip, alz 경우 업로드를 제한
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		//최대 5MB까지만 업로드 가능
		var maxSize = 5242880; //5MB
		//확장자, 크기 체크
		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			//체크 통과
			return true;
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
						<ul class="blog_men">
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
													<a href="/basicBlog/${authUser.id}/admin/basic">내블로그 관리</a>
												</button></li>
										</c:when>
									</c:choose>
									<li><button type="button" class="btn btn-primary">
											<a href="/basicBlog/user/logout">로그아웃</a>
										</button></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<div class="blog_info">
						<div id="wrapper">
							<div id="content">
								<ul class="admin-menu">
									<li class="selected"><a
										href="/basicBlog/${authUser.id}/admin/basic">기본설정</a></li>
									<li><a href="/basicBlog/${authUser.id}/admin/category">카테고리</a></li>
									<li><a href="/basicBlog/${authUser.id}/admin/write">글작성</a></li>
								</ul>

								<form action="/basicBlog/${authUser.id}/admin/blogSetting"
									method="post" enctype="multipart/form-data">
									<table class="admin-config">
										<tr>
											<td class="t">블로그 제목</td>
											<td><input type="text" size="40" name="blogTitle"
												value="${basic.blogTitle}"></td>
										</tr>
										<tr>
											<td class="t">로고이미지</td>
											<td><c:choose>
													<c:when
														test="${basic.logoFile eq 'notExist' || empty basic.logoFile}">
														<img
															src="${pageContext.request.contextPath}/assets/images/basicblog_setting.jpg">
													</c:when>
													<c:otherwise>
														<img
															src="${pageContext.request.contextPath}/assets/upload/${basic.logoFile}">
													</c:otherwise>
												</c:choose></td>
										</tr>
										<tr>
											<td class="t">&nbsp;</td>
											<td>
												<!-- <input type="file" name="file"> -->
												<div class="uploadDiv">
													<input type="file" id="input_img" name="file"  />
												</div>
											</td>
										</tr>
										<tr>
											<td class="t">&nbsp;</td>
											<td class="s"><input type="submit" value="기본설정 변경">
											</td>
										</tr>
									</table>

									<!-- 
			      	<h3>ajax test</h3>
			      	<div class="uploadDiv">
						<input type="file" id="input_img" name="uploadFile" />
					</div>
					
					<button id="uploadBtn">Upload</button>
					<div class="img_wrap"></div> -->


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
