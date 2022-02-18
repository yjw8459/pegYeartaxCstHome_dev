<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>
<script type="text/javascript">
function fn_pageMove(pageNum) {
// 	var f = document.boardForm;
// 	f.action = fn_getContextPath()+"/b/list";
// 	f.method = "post";
// 	f.pageNum.value = pageNum;
// 	f.submit();
}
</script>



<c:if test="${result.paging.totalCount > 0 }">
	<div class="paginate">
		<a href="javascript:fn_pageMove('${result.paging.firstPageNum}');" class="prevEnd"></a>
		<a href="javascript:fn_pageMove('${result.paging.prevPageNum}');" class="prev"></a>
		
		<c:forEach begin="${result.paging.startPageNum}" end="${result.paging.endPageNum}" step="1" var="page">
			<c:choose>
				<c:when test="${page eq result.paging.pageNum}">
					<a href="javascript:fn_pageMove('${page}');" title="${page }" class="num_current">${page }</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:fn_pageMove('${page}');" title="${page }" class="num">${page }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<a href="javascript:fn_pageMove('${result.paging.nextPageNum}');" class="next"></a>
		<a href="javascript:fn_pageMove('${result.paging.finalPageNum}');" class="nextEnd"></a>
	</div>
</c:if>
${result.paging.totalCount }
<c:if test="${result.paging.totalCount > 0 }">
	<div class="page_Container">
		<div class="paginate">
			<a href="javascript:;" class="prevEnd"></a>
			<a href="javascript:;" class="prev"></a>
			<a href="javascript:;" class="num_current">1</a>
			<a href="javascript:;" class="num">2</a>
			<a href="javascript:;" class="num">3</a>
			<a href="javascript:;" class="num">4</a>
			<a href="javascript" class="next"></a>
			<a href="javascript:;" class="nextEnd"></a>
		</div>
	</div>
</c:if>



                           

                            
