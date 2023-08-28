<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp" %>
	<style>
	</style>
	<h3>게시물</h3>
		<c:forEach items="${list}" var="post" varStatus="sts">
		<table>
			<tr>
				<td><a href="#">${sts.id}</a>
				</td>
			</tr>
			<tr>
				<td>
				<img style = "height: 500px;" src="#">
				</td>
			</tr>
		</table>
	</c:forEach>
	<h3>인기 게시물</h3>
<%@ include file="../include/footer.jsp" %>