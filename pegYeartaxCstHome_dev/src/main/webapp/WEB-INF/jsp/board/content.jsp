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
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/board_common.js"></script>
<title>PEGSYSTEM</title>
<script type="text/javascript">
$(document).ready(function() {
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
});

function fn_list(brd_cat) {
	location.href = fn_getContextPath() + '/brd/list?brd_cat=' + brd_cat;
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
				<div class="userArea">${userDataVO.usr_id }(${userDataVO.usr_name })</div>
				<div class="userInfoArea">
					<div class="userInfo" onclick="fn_modifyUserData();">회원정보변경</div>
					<div class="userInfo" onclick="fn_logout();">로그아웃</div>
				</div>
			</div>
		</div>
		<div class="contentsWrap">

<%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>
			
			<div class="contents">
			 <div class="topBnr2"></div>
				<div class="cntHeader bgImg8">
					<div class="title">${result.brdMst.brd_name }</div>
				</div>
				
				<div class="cntBody">
				
<form name="searchForm" id="searchForm" onsubmit="return false;">
	<input type="hidden" name="brd_code" value="${result.board.brd_code }" />
	<input type="hidden" name="brd_idx" value="${result.board.brd_idx }" />
	<input type="hidden" name="parent_no" value="${result.board.brd_idx }" />
	<input type="hidden" name="brd_cat" value="${result.brdMst.url }" />
	<input type="hidden" id="usr_id" value="${userDataVO.usr_id }" />
					<div class="tblWrap">
						<table class="tbl_view qna">
							<tr>
								<td colspan="4" class="title">${result.board.subject }</td>
							</tr>
							<tr>
								<th>업무구분</th>
								<td>${result.board.wrk_cat_name }</td>
								<th>정산년도</th>
								<td>${result.board.sac_yy }</td>
							</tr>
							<tr>
								<th>상세구분</th>
								<td>${result.board.qst_cat_name }</td>
								<th style="display: none;">문의방법</th>
								<td></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" class="textarea">${result.board.content }</td>
							</tr>
<c:if test="${result.attachFiles ne null and fn:length(result.attachFiles) > 0 }">
							<tr>
								<th>첨부</th>
								<td colspan="3">
	<c:forEach items="${result.attachFiles }" var="attachFile">
									<div class="filename">
										<a href="/brd/download?brd_code=${attachFile.brd_code}&brd_idx=${attachFile.brd_idx}&file_idx=${attachFile.file_idx }">${attachFile.org_name }</a>
									</div>
	</c:forEach>
								</td>
							</tr>
</c:if>
						</table>
					</div>
</form>	
					<div class="tblBtnArea">
						<div class="btnBasic list" onclick="fn_list('${result.brdMst.url }');">목록보기</div>
<%-- <c:if test="${userDataVO.usr_cat eq '99' }"> --%>
						<div class="btnBasic del" onclick="fn_delete('${result.board.brd_code}', ${result.board.brd_idx});">삭제</div>
						<div class="btnBasic edit" onclick="fn_boardForm('${result.board.brd_code}', ${result.board.brd_idx});">수정</div>
<%-- </c:if> --%>
					</div>
					
				</div>
				
				
			</div>
		</div>
		
	</div>


</body>
</html>


