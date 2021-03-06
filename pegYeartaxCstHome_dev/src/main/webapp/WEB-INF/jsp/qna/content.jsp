<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/basic.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/yeartaxhelp.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/jquery-ui.css" />
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/ajaxUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/messageUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/qna_common.js"></script>
<title>PEGSYSTEM</title>
<script type="text/javascript">
$(document).ready(function() {
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
});

function fn_list(brd_cat) {
//	location.href = fn_getContextPath() + '/brd/list?brd_cat=' + brd_cat;
//	location.href = fn_getContextPath() + '/qna/list?brd_cat=' + brd_cat;
	let f = document.searchForm;
	f.action = fn_getContextPath() + '/qna/list';
	f.submit();
}


function fn_deleteCallback(data){
	let retCode = data.retCode;
	if(retCode > 0) {
		alert("삭제가 완료되었습니다.");
		$('.list').click();	// 목록보기 버튼
	} else {
		var retMsg = data.retMsg;
		alert(retMsg);
	}
}
</script>
</head>
<body class="yeartaxHelp_main">
	<div class="mainWrap">
		<div class="header">
			<div class="userFr">
				<div class="userArea">${sessionScope.userDataVO.usr_id }(${sessionScope.userDataVO.usr_name })</div>
				<div class="userInfoArea">
					<div class="userInfo" onclick="fn_modifyUserData();">회원정보변경</div>
					<div class="userInfo" onclick="fn_logout();">로그아웃</div>
				</div>
			</div>
		</div>
		<div class="contentsWrap">
            <%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>
			<div class="contents">
			 <div class="topBnr3"></div>
				<div class="cntHeader bgImg3">
					<div class="title">${result.brdMst.brd_name }</div>
				</div>
				<div class="cntBody">
				
					<form name="searchForm" id="searchForm" onsubmit="return false;">
						<input type="hidden" name="brd_code" value="${result.board.brd_code }" />
						<input type="hidden" name="brd_idx" value="${result.board.brd_idx }" />
						<input type="hidden" name="parent_no" value="${result.board.brd_idx }" />
						<input type="hidden" name="brd_cat" value="${result.brdMst.url }" />
						<input id="usr_id" type="hidden" value="${userDataVO.usr_id }">
	
						<!-- 검색 조건 유지  -->
						<input type="hidden" name="sac_yy" value="${condition.sac_yy }">
						<input type="hidden" name="wrk_cat" value="${condition.wrk_cat }">
						<input type="hidden" name="qst_cat" value="${condition.qst_cat }">
						<input type="hidden" name="lst_sts" value="${condition.lst_sts }">
						<input type="hidden" name="shr_yn" value="${condition.shr_yn }">
						<input type="hidden" name="keyword" value="${condition.keyword }">
						<input type="hidden" name="page_num" value="${condition.page_num }">
						<!-- 검색 조건 유지  -->
	
						<input type="hidden" id="usr_id" value="${sessionScope.userDataVO.usr_id }" />
					
					<div class="tblWrap">
						<table class="tbl_view qna question">
							<tr>
								<td colspan="4" class="title">${result.board.subject }</td>
							</tr>
							<tr>
								<th>업무구분</th>
								<td>${result.board.wrk_cat_name }</td>
								<th>정산년도</th>
								<td>${result.board.sac_yy }</td>
								<th></th>
								<td></td>
							</tr>
							<tr>
								<th>상세구분</th>
								<td>${result.board.qst_cat_name }</td>
								<th>공유여부</th>
								<td>${result.board.shr_yn_name }</td>
								<th></th>
								<td></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>${result.board.usr_name }</td>
								<th>사업장</th>
								<td>${result.board.comp_name }</td>
								<th>문의일시</th>
								<td>
									<fmt:parseDate value="${result.board.ent_dtm }" pattern="yyyyMMddHHmmss" var="qDate" />
									<fmt:formatDate value="${qDate }" pattern="yyyy년MM월dd일 HH:mm"/>
								</td>
							</tr>
							<c:if test="${sessionScope.userDataVO.usr_cat eq '99' }">
							  <tr>
								<th>문의방법</th>
								<td>${result.board.req_cat_name }</td>
							  </tr>
							</c:if>
							<tr>
								<th>질문</th>
								<td colspan="6" class="textarea">${result.board.question }</td>
							</tr>
							<c:if test="${result.attachFiles ne null and fn:length(result.attachFiles) > 0 }">
							  <tr>
								<th>첨부</th>
								<td colspan="6">
							      <c:forEach items="${result.attachFiles }" var="attachFile">
									<div class="filename">
										<a href="/brd/download?brd_code=${attachFile.brd_code}&brd_idx=${attachFile.brd_idx}&file_idx=${attachFile.file_idx }">${attachFile.org_name }</a>
									</div>
							      </c:forEach>
								</td>
							  </tr>
							</c:if>
						</table>
					    <c:if test="${result.board.answer ne null }">
						   <table class="tbl_view qna reply">
							  <tr>
								<td colspan="6" class="title">RE : ${result.board.subject }</td>
							  </tr>
							  <tr>
								<th class="th_A">답변</th>
								<td colspan="6" class="textarea">${result.board.answer }</td>
							  </tr>
<%-- 							  
							  <c:if test="${result.answerFiles ne null and fn:length(result.answerFiles) > 0 }">
							    <tr>
							    	<th class="th_a_bg">첨부</th>
								    <td colspan="6">
							          <c:forEach items="${result.answerFiles }" var="attachFile">
								 	    <div class="filename">
										  <a href="/brd/download?brd_code=${attachFile.brd_code}&brd_idx=${attachFile.brd_idx}&file_idx=${attachFile.file_idx }">${attachFile.org_name }</a>
									    </div>
							          </c:forEach>
								   </td>
							   </tr>
							 </c:if>
							  --%>
						  </table>
					    </c:if>	
					  </div>
					</form>

					<div class="tblBtnArea">
						<div class="btnBasic list" onclick="fn_list('${result.brdMst.url }');">목록보기</div>
<%-- <c:if test="${sessionScope.userDataVO.usr_cat eq '99' }"> --%>
<!-- 확인 완료가 아닐 경우만 버튼 생성  -->
					    <c:if test="${result.board.lst_sts eq '01' }">
							<div class="btnBasic del" onclick="fn_qna_delete('${result.board.brd_code}', ${result.board.brd_idx});">삭제</div>
							<div class="btnBasic edit" onclick="fn_qnaForm('${result.board.brd_code}', ${result.board.brd_idx});">수정</div>
						</c:if>
<%-- </c:if> --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>


