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
}

textarea {
	border: 5px solid #ddd;
	border-radius: 10px;
	background-color: #eee;
	padding: 20px;
	font-size: 12px;
	width: 500px;
	height: 100px;
	resize: none;
	transition: 0.3s;
}

#tag {
	width: 300px;
	height: 30px;
	border: none;
	border-radius: 5px;
	background-color: #eee;
	transition: 0.3s;
}
#tag::placeholder {
	text-align: center;
	line-height: 30px;
}

#tag:hover {
	background-color: #ddd;
	transition: 0.3s;
}

#imgShow {
	width: 400px;
	cursor:pointer;
	transition: 0.2s;
}
#imgShow:hover {
	transform: scale(1.05);
	transition: 0.3s;
}

textarea:hover {
	background-color: #ddd;
	border: 5px solid #ccc;
	transition: 0.3s;
}
</style>
<form action="board?cmd=new" method="post" enctype="multipart/form-data"  id="sendForm">
	<table>
			<tr>
				<td>
				<div style="height: 150px"></div>
				<input type="hidden" id="id" name="id" value="${sessionScope.mvo.id}">
					<input type="file" onchange='readURL(this);' name="file" id="file" style="display: none;" accept=".jpg, .jpeg, .png, .gif" >
					<img id="imgShow" src="${pageContext.request.contextPath}/img/img_into.png"  onclick='imgclick();'>
					<div style="height:30px;"></div>
					<small
					class="text-muted">(파일크기 : 10MB / 이미지 파일만 가능)</small> <small id="file"
					class="text-info"></small>
					<div style="height: 20px;"></div>
				</td>
			</tr>
		<tr>
			<td class="imgFirst" style="display: none">
				<textarea id="content" name="content"></textarea>
				<div style="height: 20px;"></div>
			</td>
		</tr>
		<tr>
			<td class="imgFirst" style="display: none;">
				<img id="tagicon" src="${pageContext.request.contextPath}/img/tag.png" style="width:30px; display: inline; vertical-align: middle;">
				<input id="tag" name="tag" type="text" onkeyup="enterFn(this)" placeholder="태그는 최대 10개 까지 가능합니다" style="display: inline;">
			</td>
		</tr>
		<tr>		
			<td>
			<div style="height: 20px;"></div>
				<p><small id="tags" name="tags"></small></p>
				<input id="tagcnt" name="tagcnt" type="hidden" value="0">
				<p id="tagsend" name="tagsend" style="display: none;"></p>
			</td>
		</tr>
	</table>
	<div style="margin: 20px auto; width: 140px;">
		<button type="button" onclick="send()" class="sbtn">등록</button> &nbsp; 
		<button type="button" onclick="location.href='board?cmd=main'" class="sbtn">취소</button>
	</div>
	<div style="height: 100px"></div>
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
/*=============================================
* 이미지 등록 이미지 클릭
*=============================================*/
function imgclick() {
	$("#file").click();
}
/*=============================================
* 이미지 미리보기
*=============================================*/
function readURL(input) {
	  if (input.files && input.files[0]) {
	    let reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('imgShow').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	    imgSet();
	    $("#content").val("");
	    $("#tag").val("")
	    $("#tags").html("")
	    $("#tagsend").html("")
	    $("#tagcnt").val(0)
	  } else {
	    document.getElementById('imgShow').src = "";
	  }
	  
	}
</script>
<%@ include file="../include/footer.jsp"%>