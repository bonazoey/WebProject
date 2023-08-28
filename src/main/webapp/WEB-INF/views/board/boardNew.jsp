<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>
<form action="board?cmd=new" method="post" enctype="multipart/form-data" id="frmBoard" onsubmit="return " >
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
				<input id="tag" name="tag" type="text" onkeydown="enterFn()" placeholder="태그는 최대 10개 까지 가능합니다">
				<br>
				
				<small id="tags" name="tags"></small>
				<input id="tagcnt" name="tagcnt" type="hidden" value="0">
			</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-success">등록</button> &nbsp; 
	<button type="button" onclick="location.href='board?cmd=main'" class="btn btn-secondary">취소</button>
</form>


<script>
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
		console.log($("#tagcnt").val());
		if ($("#tagcnt").val() < 10) {
			if ($("#tags").html() == "") {
				$("#tags").html($("#tag").val());
			} else {
				let content = $("#tags").html();
				$("#tags").html("");
				$("#tags").html(content+", "+$("#tag").val());
			}
			$("#tag").val("");
			$("#tag").focus();
			$("#tagcnt").val(parseInt($("#tagcnt").val())+1);
		}
		window.event.keyCode=11;
	
		//$('form[name=frmBoard]').submit(false);
	}
	alert(window.event.keyCode);
	return;

}
/*=============================================
* 이미지 등록시 글 상자 보이기
*=============================================*/
function imgSet() {
	$(".imgFirst").css("display", "block");
}
</script>
<%@ include file="../include/footer.jsp"%>