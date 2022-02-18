<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>



<script type="text/javascript">
function fn_movingPage(uri) {
	location.href = fn_getContextPath()+uri;
}
</script>


<c:set var="currentURI" value="${ requestScope['javax.servlet.forward.request_uri'] }"/>

		<div class="leftMenuWrap">
			<ul class="leftM">
<c:forEach items="${userDataVO.menu }" var="menu">
<c:if test="${menu.display_yn eq 'Y' }">
	<c:choose>
		<c:when test="${menu.brd_type eq '03' }">
			<li class="preM <c:if test="${ param.brd_cat eq menu.url }">ov</c:if>" onclick="fn_movingPage('/qna/list?brd_cat=${menu.url}'); ">${menu.brd_name }</li>
		</c:when>
		<c:otherwise>
			<li class="preM <c:if test="${ param.brd_cat eq menu.url }">ov</c:if>" onclick="fn_movingPage('/brd/list?brd_cat=${menu.url}'); ">${menu.brd_name }</li>
		</c:otherwise>
	</c:choose>
</c:if>
</c:forEach>
<c:if test="${ userDataVO.usr_cat >= 90 }">
				<li class="preM <c:if test="${ fn:contains(currentURI, '/adm/') }">ov</c:if>" onclick="fn_movingPage('/adm/QnA-mng');">관리자 전용</li>
	<c:if test="${ userDataVO.usr_cat eq '99' }">
				<li class="soM <c:if test="${ fn:contains(currentURI, '/mem-mng') }">ov</c:if>" onclick="fn_movingPage('/adm/mem-mng');">회원관리</li>
				<li class="soM <c:if test="${ fn:contains(currentURI, '/brd-mng') }">ov</c:if>" onclick="fn_movingPage('/adm/brd-mng');">게시판관리</li>
	</c:if>
				<li class="soM <c:if test="${ fn:contains(currentURI, '/QnA-mng') }">ov</c:if>" onclick="fn_movingPage('/adm/QnA-mng');">Q＆A관리</li>
				<li class="soM <c:if test="${ fn:contains(currentURI, '/dist') }">ov</c:if>" onclick="fn_movingPage('/adm/dist');">배포관리</li>
</c:if>
			</ul>
		</div>
		
		
