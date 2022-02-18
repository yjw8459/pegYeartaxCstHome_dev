<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link type="image/x-icon" rel="shortcut icon" href="${contextPath }/resources/images/main/favicon.ico" />
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
	fn_search(1);
});


function fn_searchCallback(data) {
	let list = data.list;
	let length = list.length;
// 	if(length < 1) alert('데이터가 존재하지 않습니다.');
	let html = '';
	if(length > 0) {
		// 순번을 만들기 위한 기본값은 페이징 객체를 이용
		let paging = data.paging;
		let totalCount = paging.totalCount;
		let pageNum = paging.pageNum;
		let pageSize = paging.pageSize;
		
		for(var i=0; i<length; i++) {
			let brdIndex = totalCount - (((pageNum - 1) * pageSize) + i);	// 순번
			let board = list[i];
			let brdCode = board.brd_code;
			let brdIdx = board.brd_idx;
			let sacYy = board.sac_yy;
			let wrkCatName = board.wrk_cat_name;
			let qstCatName = board.qst_cat_name;
			let ntcYn = board.ntc_yn;
			let subject = board.subject;
			let attachCount = board.attach_count;
			let brdHit = board.brd_hit;
			let entUno = board.ent_uno;
			let entDtm = board.ent_dtm;
			
			html += '<tr>';
			html += '	<td>'+brdIndex+'</td>';
			html += '	<td>'+sacYy+'</td>';
			html += '	<td>'+wrkCatName+'</td>';
			html += '	<td>'+qstCatName+'</td>';
			html += '	<td class="titleList '+(attachCount > 0 ? 'detachFile' : '')+'">';
			html += '		<a href="javascript:fn_boardDetail(\'' + brdCode + '\',\'' + brdIdx + '\');">';
			html += 			(ntcYn == 'Y' ? '[공지] ' : '') + subject;
			html += '		</a>';
			html += '	</td>';
			html += '	<td>'+brdHit+'</td>';
			html += '	<td>'+entUno+'</td>';
			html += '	<td>'+entDtm+'</td>';
			html += '</tr>';
		}
	} else {
		html += '<tr>';
		html += '	<td colspan="8">데이터가 없습니다.</td>';
		html += '</tr>';
	}
	$("#boardList tbody").html(html);
	fn_setPagingNavigation(data);
}


function fn_pageMove(page_num) {
	fn_search(page_num);
}


function fn_boardDetail(brd_code, brd_idx) {
	let f = document.searchForm;
	f.brd_code.value = brd_code;
	f.brd_idx.value = brd_idx;
	f.method = 'post';
	f.action = fn_getContextPath() + '/brd/content';
	f.submit();
}
</script>
</head>
<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>
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
				<div class="searchArea">
<form name="searchForm" id="searchForm" onsubmit="return false;">
	<input type="hidden" name="brd_code" value="${result.brdMst.brd_code }" />
	<input type="hidden" name="brd_cat" value="${result.brdMst.url }" />
	<input type="hidden" name="brd_idx" />
	<input type="hidden" name="page_num" />
					<table class="tblSerach">
						<tr>
							<th>정산년도</th>
							<td>
								<select name="sac_yy" id="sac_yy">
<c:forEach items="${result.c007 }" var="code">
									<option value="${code.cd }">${code.cd_nm }</option>
</c:forEach>
									<option value="">전체</option>
								</select>
							</td>
							<th>업무구분</th>
							<td>
								<select name="wrk_cat" id="wrk_cat">
<c:forEach items="${result.c001 }" var="code" varStatus="i">
	<c:if test="${fn:substring(userDataVO.comp_role, i.index, i.index + 1) eq 'Y' }">
									<option value="${code.cd }">${code.cd_nm }</option>
	</c:if>
</c:forEach>
								</select>
							</td>
							<th>질문구분</th>
							<td>
								<select name="qst_cat" id="qst_cat">
									<option value="">전체</option>
<c:forEach items="${result.c002 }" var="code">
									<option value="${code.cd }">${code.cd_nm }</option>
</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>제목 및 내용</th>
							<td>
								<input type="text" name="keyword" id="keyword" class="keyword" onkeypress="javascript:if(event.keyCode==13) { fn_search(1); }" />
							</td>
						</tr>
					</table>
</form>
					<div class="searchBtnArea">
						<div class="hp_btnSearch" title="검색" onclick="fn_search(1);"></div>
						<div class="hp_btnReset" title="초기화" onclick="fn_searchFormReset();"></div>
					</div>
				</div>
				
				<div class="cntHeader bgImg8">
					<div class="title">${result.brdMst.brd_name }</div>
				</div>
				
				<div class="cntBody">
					<div class="tblWrap">
						<table class="tbl_list notice" id="boardList">
							<thead>
								<tr>
									<th class="col_1">No.</th>
									<th class="col_2">정산년도</th>
									<th class="col_3">업무구분</th>
									<th class="col_4">질문구분</th>
									<th class="col_5">제목</th>
									<th class="col_6">조회수</th>
									<th class="col_7">작성자</th>
									<th class="col_8">작성일시</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					<div class="tblBtnArea">
<%-- <c:if test="${userDataVO.usr_cat eq '99' }"> --%>
						<div class="btnBasic" onclick="fn_boardForm('${result.brdMst.brd_code }', 0);">등록하기</div>
<%-- </c:if> --%>
					</div>
					
					<div id="pageNavigation"></div>
				</div>
				
				
				
				
				
			</div>
		</div>
		
	</div>


</body>
</html>


