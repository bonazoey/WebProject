<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zenstagram : 회원가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js" defer>
	</script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<style>
	form {
		text-align: left;
		width: 300px;
		padding-left: 80px;
		padding-top: 80px;
		padding-bottom: 50px;
		border: 1px none;
		border-radius: 50px;
		box-shadow: 0px 0px 20px 20px #ccc;
		transition: 0.5s;
	}
		form:hover {
		box-shadow: 0px 0px 25px 25px #aaa;
		transition: 0.5s;
	}
	</style>
</head>
<body>
<main>
<div style="padding-top: 100px"></div>
<h1 style="text-shadow: 2px 2px 8px #555; color: white; font-weight: bold;">Zenstagram</h1>
<h5 style="text-shadow: 2px 2px 8px #fff; color: #ccc;">beta</h5>
<div style="height: 20px"></div>
	<div style="height: 20px"></div>
	<small>지금 당장 일원이 되어 exclusive한 모든 혜택을 누리세요!</small>
	<div style="height: 50px"></div>
	<form action="member?cmd=register" onsubmit="return register()" method="post" name="registerForm">
		<table>
			<div class="box-body">
				<div class="form-group row">
				<small style="color: #999"> * 표시된 항목은 필수 입력 항목입니다.<br><br></small>
					<label for="name" class="col-sm-2 col-form-label">아이디 *</label>
					<div class="col-sm-10">
						<input type="text" name="id" id="id" size="22"
							class="form-control" maxlength='20' placeholder="아이디 입력"
							required="required" onkeydown="changeId();">
						<button type="button" id="checkid" name="checkid"
							onclick="idcheck();" class="sbtn">중복검사</button>&nbsp;<div id="message"style="color: #aaa; font-size: 12px">&nbsp;</div>
						<input type="hidden" id="ischeck" name="ischeck" value="2">
				</div>
				<div style="height: 8px"></div>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">패스워드 *</label>
					<div class="col-sm-10">
						<input type="password" name="pwd" id="pwd" size="22"
							class="form-control" maxlength='20' placeholder="패스워드 입력" required="required">
					</div>
				</div>
				<div style="height: 20px"></div>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">이름 *</label>
					<div class="col-sm-10">
						<input type="text" name="name" id="name" size="22"
							class="form-control" maxlength='20' placeholder="이름 입력" required="required">
					</div>
				</div>
				<div style="height: 20px"></div>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">닉네임 *</label>
					<div class="col-sm-10">
						<input type="text" name="nick" id="nick" size="22"
							class="form-control" maxlength='20' placeholder="닉네임 입력" required="required">
					</div>
				</div>
				<div style="height: 20px"></div>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10">
						<input type="email" name="email" id="email" size="22"
							class="form-control" maxlength='20' placeholder="이메일 입력" required="required">
					</div>
				</div>
				<div style="height: 20px"></div>
				<div class="form-gr
				oup row">
					<label for="name" class="col-sm-2 col-form-label">연락처 *</label>
					<div class="col-sm-10">
						<input type="text" name="phone" id="phone" size="22"
							class="form-control" maxlength='20' placeholder="연락처 입력" required="required">
					</div>
				</div>
				<div style="height: 20px; "></div>
				<div class="form-group text-center" style="margin: 0 auto; padding-left: 30px;">
					<button type="submit" class="btn btn-primary sbtn">회원가입</button>
					<button type="button" class="btn btn-danger sbtn"
						onclick="location.href='index.jsp'">취 소</button>
				</div>
				<div style="height: 20px;"></div>
			</div>
		</table>
	</form>
	</main>
	</body>
<script>
/*=============================================
* ready fun 호출
*=============================================*/
$(document).ready(function(){
	if("${checkReg}" !== "")
		if("${checkReg}" == "0" ) 	{
		alert('다시 한 번 확인해 주세요')	
		}	
});
/*=======================
 * 회원가입 버튼
 =======================*/
function register() {
	let ischeck = $("#ischeck").val();
	if (ischeck == 1) {
		alert('중복된 아이디 입니다.');
		$("#id").focus();
		return false;
	}
	else if(ischeck == 2) {
		alert('아이디 중복을 확인해주세요');	
		$("#id").focus();
		return false;
	}
	return true;
}
/*=======================
 * 아이디 중복 검사 버튼
 =======================*/
function idcheck() {
	let id = $("#id").val().trim();
	if (id == "") {
		alert('아이디를 입력하세요');
		$("#id").focus();
	} else {
		let url = "member?cmd=idcheck";
		let param = {
			"id" : id
		}
		doAjaxHtml(url, param, idcheckAfter);
	}
}
/*=======================
 * 아이디 중복 검사 했는지
 =======================*/
function idcheckAfter(data) {
	let retData = JSON.parse(data);
	$("#ischeck").val(retData.result);
	$("#message").html(retData.message);
}
/*=======================
 * 아이디 변경 되었을 때
 =======================*/
 function changeId() {
	$("#ischeck").val(2);
	$("#message").html("&nbsp;");
}
</script>
</html>