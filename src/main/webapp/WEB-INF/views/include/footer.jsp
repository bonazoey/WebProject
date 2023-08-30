<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>	
<style>
.fbtn {
border: none;
background-color: transparent;
cursor: pointer;
}
</style>
<div class="footer">
	<button class="fbtn" onclick="location.href='board?cmd=main'"><img src="${pageContext.request.contextPath}/img/feed_icon.png" alt="메인화면" style="width: 50px; padding: 10px"></button>
	<button class="fbtn" onclick="searchIssue();"><img src="${pageContext.request.contextPath}/img/search_icon.png" alt="탐색" style="width: 50px; padding: 10px"></button>
	<button class="fbtn" onclick="location.href='board?cmd=new'"><img src="${pageContext.request.contextPath}/img/write_icon.png" alt="글쓰기" style="width: 50px; padding: 10px"></button>
	<button class="fbtn" onclick="secureIssue();"><img src="${pageContext.request.contextPath}/img/profile_icon.png" alt="프로필" style="width: 50px; padding: 10px"></button>
</div>
<script>
function searchIssue() {
	alert('헉, 탐색 버튼을 누른 당신!\n\n애석하게도 사생활 염탐 이슈로 베타버전에선 지원하지 않습니다!');
}
function secureIssue() {
	alert('앗, 프로필 버튼을 누른 당신!\n\n애석하게도 개인정보유출 이슈로 베타버전에선 지원하지 않습니다!');
}
</script>
</body>
</html>