<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>
<style>
.tag {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: 5px;
	margin: 5px; 
	cursor: pointer;
	color: #555;
	text-decoration: none;
}/*  */
</style>
<form action="board?cmd=new" method="post" enctype="multipart/form-data" onsubmit="return enterFn()" id="sendForm">
	<table>
			<tr>
				<td>
				<input type="text">
				<input type="hidden" id="id" name="id" value="${sessionScope.mvo.id}">
					<input type="file" name="file" id="file" onchange="imgSet()"> <small
					class="text-muted">(파일크기 : 10MB / 이미지 파일만 가능)</small> <small id="file"
					class="text-info"></small>
				</td>
			</tr>
		<tr>
			<td class="imgFirst"style="display: none">
				<textarea id="content" name="content" placeholder="내용을 입력해주세요"></textarea>
			</td>
		</tr>
		<tr>
			<td class="imgFirst" style="display: none">
				<input id="tag" name="tag" type="text" onkeyup="enterFn(this)" placeholder="태그는 최대 10개 까지 가능합니다">
			</td>
		</tr>
		<tr>		
			<td>
			<div style="height: 20px;"></div>
				<p><small id="tags" name="tags"></small></p>
				<input id="tagcnt" name="tagcnt" type="hidden" value="0">
				<p id="tagsend" name="tagsend" style="display: block;"></p>
			</td>
		</tr>
	</table>
	<button type="button" onclick="send()"class="btn btn-success">등록</button> &nbsp; 
	<button type="button" onclick="location.href='board?cmd=main'" class="btn btn-secondary">취소</button>
</form>


<script type="text/javascript">
/*=============================================
* ready fun
*=============================================*/
$(document).ready(function(){
	let blank = "";
	if(blank == "${sessionScope.mvo.id}") {
		location.href='board?cmd=main';
	}
});
/*=============================================
* 엔터시 태그 추가
*=============================================*/
function enterFn() {
	if (window.event.keyCode == 13) {
		if ($("#tagcnt").val() < 10) {
			if ($("#tags").html() == "") {
				$("#tags").html("<a onclick='deltag(this, this.text)' class='tag'>"+$("#tag").val().trim()+"</a>");
				$("#tagsend").html("^/"+$("#tag").val().trim());
			} else {
				let content = $("#tags").html();
				let sendcontent = $("#tagsend").html();
				$("#tags").html("");
				$("#tags").html(content+" "+"<a onclick='deltag(this, this.text)' class='tag'>"+$("#tag").val().trim()+"</a>");
				$("#tagsend").html("");
				$("#tagsend").html(sendcontent+"/^"+$("#tag").val().trim());
				//$("#tagsend").html($("#tags").html())
				//.removeattr('a')
			}
			$("#tag").val("");
			$("#tag").focus();
			$("#tagcnt").val(parseInt($("#tagcnt").val())+1);
		}
	}
}
/*=============================================
* 이미지 등록시 글 상자 보이기
*=============================================*/
function imgSet() {
	$(".imgFirst").css("display", "block");
}
/*=============================================
* 전송하기
*=============================================*/
function send() {
	document.getElementById("sendForm").submit();
}
/*=============================================
* 태그 삭제
*=============================================*/
function deltag(a, b) {
	a.remove();
	console.log(a);
	console.log(b);
	$("#tagsend").html($("#tagsend").html().replace("/^"+b,""));
	$("#tagcnt").val(parseInt($("#tagcnt").val())-1);
}
</script>
<%@ include file="../include/footer.jsp"%>