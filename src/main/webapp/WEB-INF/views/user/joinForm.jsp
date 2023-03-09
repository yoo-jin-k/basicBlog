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
	// 정규표현식
	//공백
	var regExp = /\s/g;
	//이름 체크 정규표현식: 한글과 영어 대/소문자만 가능
	var acceptName = /^[가-힣a-zA-Z]+$/;
	//비밀번호 체크: 소문자/숫자/특수문자를 사용,  8~16자리로 제한
	var acceptPassword = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
	var success = "";
	$(function() {
		$('#btn-checkid').click(function() {
			idDuplicateCheck();
		});
	});
	function idDuplicateCheck() {
		var id = $('#id').val();
		if (id == null || regExp.test(id)) {
			alert("아이디에 공백은 허용하지 않습니다.");
			$('#id').focus();
			$('#id').val("");
			result = false;
			return;
		} else {
			// contentType: "application/json" 꼭 써주기
			$.ajax({
				url : "${pageContext.servletContext.contextPath}/user/checkId",
				type : "POST",
				dataType : "json",
				async : true,
				contentType : "application/json",
				data : JSON.stringify({
					"id" : id
				}),
				success : function(result) {
					if (result == 1) {
						$('#id').focus();
						$('#id').val("");
						$('#checkid-msg').text("다른 아이디로 가입해 주세요.").css({"color":
								"red","display" :"flex"});
						success = false;
						console.log("1. checkId success결과 : " + success);
						return false;
					} else {
						$('#checkid-msg').text("사용할 수 있는 아이디 입니다.").css(
								{"color": "green","display" :"flex"});
						success = true;
						console.log("1. checkId success결과 : " + success);
					}
					$('#check-button').hide();

				},
				error : function(xhr, error) { //xmlHttpRequest?
					console.error("error : " + error);
				}
			});
		}
	}

	function joinCheck() {
		idDuplicateCheck();
		if (success == false) {
			console.log("fasle뜸");
			return;
		} else {
			console.log("dmdkdkdkdkdkd");
		}

		var userName = $('#userName').val();
		var password = $('#password').val();
		//이름
		if (userName == null || regExp.test(userName)
				|| !acceptName.test(userName)) {
			alert("이름에 공백 또는 특수문자는 허용되지 않습니다.");
			$('#userName').focus();
			$('#userName').val("");
			success = false;
			console.log("2. userName success결과 : " + success);
			return;
		} else {
			success = true;
			console.log("2. userName success결과 : " + success);
		}
		//패스워드
		if (password == null || regExp.test(password)) {
			alert("비밀번호에 공백은 허용되지 않습니다.");
			$('#password').focus();
			$('#password').val("");
			success = false;
			console.log("2. password success결과 : " + success);
			return;
		} else {
			success = true;
			console.log("2. password success결과 : " + success);
		}
		console.log("3. 최종 success결과 : " + success);

		if (success == false) {
			return;
		} else {
			$('#join-form').submit();
		}
	}
</script>
</head>
<body>
	<div class="center-content">
		<div class="container_bg">
			<div class="container_box">

				<h1 class="logo">Join</h1>


				<!-- 메인해더 -->
				<%-- <a href="/basicBlog/main">
			<img class="logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg">
		</a> --%>
				<ul class="menu">
					<!-- 로그인 전 메뉴 -->
					<button type="button" class="btn btn-primary">
						<a href="/basicBlog/user/loginForm">로그인</a>
					</button>

				</ul>

				<form class="join-form" id="join-form" method="post"
					action="${pageContext.servletContext.contextPath}/user/doJoin">
					<div class="input-group">
						<span class="input-group-text" for="name">이름</span> <input
							type="text" name="userName" id="userName" value=""
							required="required" class="form-control" placeholder="userName">
					</div>
					<div>
						<div class="join-id-check">
							<div>
							<div class="input-group">
								<span class="input-group-text" for="id">ID</span>
								<input
									type="text" name="id" id="id" value="" required="required"
									class="form-control">
							</div>

							<p id="checkid-msg" class="form-error">&nbsp;</p>
							</div>
							
							<div>
								<button class="btn btn-primary" id="btn-checkid" type="button"
									value="id 중복체크">체크</button>
							</div>


						</div>
					</div>
					<div class="input-group">
						<span class="input-group-text" for="password">PW</span> <input
							type="password" name="password" id="password" value=""
							required="required" class="form-control" placeholder="password">
					</div>
					<div>
						<input id="agree-prov" type="checkbox" name="agreeProv" value="y"
							style="margin-right: 8px"> <label class="l-float">서비스
							약관에 동의합니다.</label>
					</div>
					<div>
						<button type="button" id="btn-join" onclick="joinCheck()"
							class="btn btn-primary">가입하기</button>
					</div>







					<!-- <label class="block-label" for="name">이름</label> <input type="text"
						id="userName" name="userName" value="" required="required" /> <label
						class="block-label" for="id">아이디</label> <input type="text"
						name="id" value="" id="id" required="required" /> <input
						id="btn-checkid" type="button" value="id 중복체크">
					<p id="checkid-msg" class="form-error">&nbsp;</p>

					<label class="block-label" for="password">패스워드</label> <input
						type="password" id="password" name="password" value=""
						required="required" />
 -->
					<!-- <fieldset>
						<legend>약관동의</legend>
						<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
						<label class="l-float">서비스 약관에 동의합니다.</label>
					</fieldset> -->

					<!-- <input type="button" id="btn-join" onclick="joinCheck()"
						value="가입하기"> -->

				</form>
			</div>
		</div>
	</div>

</body>



</html>