<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>



<script type="text/javascript">
function fn_movingPage(uri) {
	location.href = fn_getContextPath()+uri;
}
</script>





		<div class="leftMenuWrap">
			<ul class="leftM">
<c:forEach items="${userDataVO.menu }" var="menu">
				<li class="preM <c:if test="${ param.brd_cat eq menu.url }">ov</c:if>" onclick="fn_movingPage('/brd/list?brd_cat=${menu.url}'); ">${menu.brd_name }</li>
</c:forEach>
<c:if test="${userDataVO.usr_cat eq '99' }">
				<li class="preM">관리자 전용</li>
				<li class="soM" onclick="location.href = '/member'; ">회원관리</li>
				<li class="soM" onclick="location.href = '/board'; ">게시판관리</li>
				<li class="soM" onclick="location.href = '/cmmn/main'; ">Q&#38;A관리</li>
</c:if>
			</ul>
		</div>
		
		
