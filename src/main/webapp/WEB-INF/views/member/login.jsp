<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<meta charset="UTF-8">
<title>Zenstagram : 로그인</title>
</head>
	<style>
	form {
		text-align: left;
		width: 300px;
		padding-left: 100px;
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
<body>
<main>
<div style="padding-top: 100px"></div>
<h1 style="text-shadow: 2px 2px 8px #555; color: white; font-weight: bold;">Zenstagram</h1>
<h5 style="text-shadow: 2px 2px 8px #fff; color: #ccc;">beta</h5>
<div style="height: 20px"></div>
	<div style="height: 20px"></div>
	<small>지금 당장 로그인하고 도파민을 과도하게 분비시키세요!</small>
	<div style="height: 50px"></div>
<form action="member?cmd=login" method="post">
	<table>
		<div class="box-body">	
			<div class="form-group row">
				<label for="name" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
				<input type="text" name="id" id="id" size="22" class="form-control" maxlength='20'  placeholder="아이디 입력" required="required">										
				</div>
			</div>
			<div style="height:20px"></div>
			<div class="form-group row">
				<label for="name" class="col-sm-2 col-form-label">패스워드</label>
				<div class="col-sm-10">
				<input type="password" name="pwd" id="pwd" size="22" class="form-control" maxlength='20'  placeholder="패스워드 입력" required="required">										
				</div>
			</div>				
			<div style="height:40px"></div>
			<div class="form-group text-center" style="padding-left: 20px;">
				<button type="submit" class="btn btn-primary sbtn">로 그 인</button>
				<button type="reset" class="btn btn-danger sbtn" onclick="location.href='index.jsp'">취 소</button>
			</div>
			<div style="height: 20px;"></div>
			<div style="font-size: 12px; margin-left: -30px;">${message}</div>
		</div>
	</table>
</form>
</main>
</body>
</html>