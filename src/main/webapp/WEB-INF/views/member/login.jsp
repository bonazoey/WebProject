<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지금 당장 로그인 하고 도파민을 과도하게 분비시키세요!</title>
</head>
<body>
<h3>로그인 테스트</h3>
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
			<div style="height:20px"></div>
			<div class="form-group text-center">
				<button type="submit" class="btn btn-primary">로 그 인</button>
				<button type="reset" class="btn btn-danger" onclick="location.href='index.html'">취 소</button>
			</div>
			<div style="height: 20px;"></div>
			<div>${message}</div>
		</div>
	</table>
</form>
</body>
</html>