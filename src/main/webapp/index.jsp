<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>Zenstagram</title>
</head><!--  -->
<body>
<main style="">
	<div style="text-align: center; margin: 0 auto; padding-top: 300px">
		<h1 style="text-shadow: 2px 2px 8px #555; color: white; font-weight: bold;">Zenstagram</h1>
		<h5 style="text-shadow: 2px 2px 8px #fff; color: #ccc;">beta</h5>
		<div style="height: 10px"></div>
			<h5 id="first">처음이신가요?</h5>
			<div style="height: 20px"></div>
			<div style="hegith: 20px; padding: 20px; width:500px; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;">
				<button class="sbtn" id="yes" name="yes" onclick="showYesNext();">네</button>
				<button class="sbtn" id="no" name="no" onclick="showNoNext();">아니오</button>
				<button class="sbtn" id="register" name="register" onclick="location.href='member?cmd=register'" style="display: none;">회원가입</button>
				<button class="sbtn" id="login" name="login" onclick="location.href='member?cmd=login'" style="display: none;">로그인</button>
				<button class="sbtn" id="notlogin" name="notlogin" onclick="location.href='board'" style="display: none;">그냥 둘러볼래요..</button>
			</div>
	</div>
</main>
<script type="text/javascript">
/*=============================================
* ready fun
*=============================================*/
$(document).ready(function(){
	let blank = "";
	if(blank != "${sessionScope.mvo.id}") {
		location.href='board?cmd=main';
	}
});
/*=======================================
* '아니오' 선택
*=======================================*/
	function showNoNext() {
		$("#yes").css("display", "none");
		$("#no").css("display", "none");
		$("#first").css("display", "none");
		
		$("#login").css("display", "inline-block");
		$("#notlogin").css("display", "inline-block");
	}
/*=======================================
* '네' 선택
*=======================================*/
	function showYesNext() {
		$("#yes").css("display", "none");
		$("#no").css("display", "none");
		$("#first").css("display", "none");
		
		$("#register").css("display", "inline-block");
		$("#notlogin").css("display", "inline-block");
	}
</script>
</body>
</html>