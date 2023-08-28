<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>Zenstagram</h1>
		<div id="question" name="question">
			<h2 id="first">처음이신가요?</h2>
			<button id="yes" name="yes" onclick="showYesNext();">네</button>
			<button id="no" name="no" onclick="showNoNext();">아니오</button>
		</div>
			<button id="register" name="register" onclick="location.href='member?cmd=register'" style="display: none;">회원가입</button>
			<button id="login" name="login" onclick="location.href='member?cmd=login'" style="display: none;">로그인</button>
			<button id="notlogin" name="notlogin" onclick="location.href='board'" style="display: none;">그냥 둘러볼래요..</button>
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
		
		$("#login").css("display", "block");
		$("#notlogin").css("display", "block");
	}
/*=======================================
* '네' 선택
*=======================================*/
	function showYesNext() {
		$("#yes").css("display", "none");
		$("#no").css("display", "none");
		$("#first").css("display", "none");
		
		$("#register").css("display", "block");
		$("#notlogin").css("display", "block");
	}
</script>
</body>
</html>