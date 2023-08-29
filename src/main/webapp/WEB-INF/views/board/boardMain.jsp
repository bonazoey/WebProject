<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp"%>
<style>
.feed {
	border: 1px solid #bbb;
	padding: 20px;
	margin: 20px;
}/*  */
</style>
<main>
<h3>최근 게시물</h3>
<div id="div_NewPage">
	<c:forEach items="${list}" var="post" varStatus="sts">
		<div class="feed">
			<table>
				<tr>
					<td><a href="#">${post.id}</a></td>
				</tr>
				<tr>
					<td><img style="height: 200px;"
						src="board?cmd=imgDown&upload=${post.savepath}&savedFname=${post.savefilename}&originFname=${post.srcfilename}"
						alt="no-img"></td>
				</tr>
				<tr>
					<td>
						<p>${post.content}</p>
					</td>
				</tr>
				<tr>
					<td>
						<p>좋아요 댓글</p>
					</td>
				</tr>
				<tr>
					<td>
						<p>댓글들</p>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>
<input type="hidden" name="NewPage" id="NewPage" value="0">
<button type="button" id="NewNext" style="display: none"
	onclick="showMoreNew()">이전 게시물 보기</button>

<h3>인기 게시물</h3>
<input type="hidden" name="famousPage" id="famousPage" value="0">
<button type="button" id="famousNext" style="display: none"
	onclick="showMoreFam()">더보기</button>
</main>
<script type="text/javascript">
	/*=============================================
	* ready fun 호출
	*=============================================*/
	//$(document).ready(function(){
	//	$("#NewPage").val(0);
	//	showMoreNew();
	//});
	
	/*=============================================
	*	댓글 가져오기 수행 ajax : doAjax(url, param, callback)
	*	- 보내는 데이터 : bno, page
	*	- 받아오는 데이터 : json(더보기 버튼 활성화 여부,출력할 데이터(배열))	
	*=============================================*/
	/* function showMoreNew(){
			let url="board?cmd=feed";
			let param={//"bno":$("#bno").val(),
					   "page":$("#NewPage").val()*1+1
					   };
			//증가한 페이지를 적용
			$("#NewPage").val($("#NewPage").val()*1+1);
			console.log(param);
			doAjax(url, param, showMoreNewAfter);
	} */
	
	/*=============================================
	*	댓글 가져오기 수행 후 해야 할 일
	*	- 받아오는 데이터 : json를 table 태그 내에 출력	
	*=============================================*/
	/* function showMoreNewAfter(data){
		if(data=="err"){
			console.log("err");
	 		// 표시할 자료 없음
	 	} else{
		 		//data 배열에 있는 값을 tbl_star 에 html 태그로 조립해서 출력 
		 		let NewList=data.arr;
		 		let html="";
		 		for(let vo of NewList){//js foreach
	 				//<c:forEach items="'+${list}+'" var="post" varStatus="sts">';
					html+='<div class="feed">';
					html+='<table>';
		 			html+='<tr>';
		 			html+='<td>';
		 			html+='<a href="#">'+vo.id+'</a>';
		 			html+='</td>';
		 			html+='</tr>';
		 			html+='<tr>';
		 			html+='<td>';
					html+='<img style="height: 200px;" src="board?cmd=imgDown&upload='+vo.savepath+'&savedFname='+vo.savefilename+'&originFname='+vo.srcfilename+'" alt="no-img">';
		 			html+='</td>';
		 			html+='</tr>';	 	
		 			html+='<tr>';
		 			html+='<td>';
		 			html+='<p>'+vo.content+'</p>';			
		 			html+='</td>';
		 			html+='</tr>';	 	
		 			html+='<tr>';
		 			html+='<td>';
		 			html+='<p>좋아요 댓글</p>';
		 			html+='</td>';
		 			html+='</tr>';	 	
		 			html+='<tr>';
		 			html+='<td>';
		 			html+='<p>댓글들</p>';
		 			html+='</td>';
		 			html+='</tr>';	 	
		 			html+='</table>';
	 				html+='</div>';
					//</c:forEach>';
					console.log('제발 몇개?');
		 		}//for
		 		$("#div_NewPage").append(html);
		 		//let next=data.next;//true, false
		 		//console.log(next);
		 		if(data.next){//더보기 버튼을 보여주기
		 			$("#NewNext").css("display","block");
		 		}else $("#NewNext").css("display","none");
		 		// loding 중인 별점을 보여주는 작업
		 		// let ratingStar=$(".rating-loading");
		 		//if(ratingStar.length){//별점보여주기가 1개 이상 있으면
		 		//	ratingStar.removeClass("rating-loading").addClass("rating-loading").rating();
		 		//}
	 	}
	} */
	</script>

<%@ include file="../include/footer.jsp"%>