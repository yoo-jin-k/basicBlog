<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BasicBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicBlog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>

	<div id="container">

		<!-- 블로그 해더 -->
		<div id="header">
			<h1><a href="/basicBlog/main">메인으로 돌아가기</a></h1>
		</div>
		<div>
			<h1 style="text-align: center; height: 300px;">존재하지 않는 회원입니다. 다시한번 확인해주세요</h1>
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