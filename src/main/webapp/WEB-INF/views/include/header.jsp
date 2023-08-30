<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zenstagram</title>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js" defer></script> --%>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/additional-methods.js"></script>
<script src="${pageContext.request.contextPath}/js/fileupload_validate.js"></script>
<style>
	.header {
	position: fixed;
	background-color: #ccc;
	display: flex;
	justify-content: center;
	width: 100%;
	height: 80px;
	top: 0px;
	}
	
	.float {
	display: inline-block;
	position: fixed;
	right: 20px;
	top: 25px;
	z-index: 1;
	float: right;
	}
</style>
</head>
<body>
<header>
	<h1 style="text-shadow: 2px 2px 8px #555; color: white; font-weight: bold; line-height: 80px;" class="header">Zenstagram<span style="text-shadow: 2px 2px 8px #555; color: #fff; font-size: 15px; margin: 0;">&nbsp;beta</span></h1>
		<c:choose>
			<c:when test="${sessionScope.mvo == null }">
				<button type="button" id="login" name="login" class="sbtn float" onclick="location.href='member?cmd=login'" style="right: 100px">로 그 인</button>
				<button type="button" id="register" name="register" class="sbtn float" onclick="location.href='member?cmd=register'" style="right: 20px">회원가입</button>
			</c:when>
			<c:otherwise>
				<p style="font-weight: bold; padding: 10px; text-shadow: 2px 2px 5px #aaa; text-align: right; right: 120px; top: 15px; font-size: 20px;" class="float">${sessionScope.mvo.name}</p>
				<button type="button" id="logout" name="logout" class="sbtn float" onclick="location.href='member?cmd=logout'">로그아웃</button>
			</c:otherwise>
		</c:choose>
</header>