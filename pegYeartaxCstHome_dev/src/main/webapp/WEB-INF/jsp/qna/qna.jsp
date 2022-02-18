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
	
	$( "#dialog_stsForm" ).dialog({
		autoOpen: false,
		height: "auto",
		width: 1000,
		modal: true
	});
	
	fn_qna_loadInitProc();
});

function fn_qna_loadInitProc(){
	
	let usr_cat = '${userDataVO.usr_cat}';
	let shr_yn = '${condition.shr_yn}';
	//관리자는 default UnChecked
	if ( shr_yn == '' ) {
		if ( usr_cat == '99' )	$('#shr_yn').attr('checked', false);
		else 					$('#shr_yn').attr('checked', true);		
	}
	
	
	let pageNum = '${condition.page_num}';
	if ( pageNum == '' ) 	pageNum = 1;
	
	fn_qna_search(pageNum);
}



function fn_qna_searchCallback(data) {
	let list = data.list;
	let page = data.page;
	let totalCount = page.totalCount;
	let pageNum = page.pageNum;
	let pageSize = page.pageSize;
	let startPageNum = page.startPageNum;
	let prevPageNum = page.prevPageNum;
	let endPageNum = page.endPageNum;
	let nextPageNum = page.nextPageNum;
	let finalPageNum = page.finalPageNum;

	let html = '';
	let pageHtml = '<div class="page_Container"><div class="paginate">';
	pageHtml += '<a href="javascript:fn_pageMove(' + startPageNum + ');" class="prevEnd"></a>';
	pageHtml += '<a href="javascript:fn_pageMove(' + prevPageNum + ');" class="prev"></a>';
	if ( list.length > 0 ) {
		for (var i = 0; i < list.length; i++) {
			let qna = list[i];
			let qnaIndex = totalCount - (( (pageNum - 1) * pageSize ) + i );
			let brd_code = qna.brd_code;
			let brd_idx = qna.brd_idx;
			let subject = qna.subject;
			let sac_yy = qna.sac_yy;
			let wrkNm = qna.wrk_cat_name;
			let qstNm = qna.qst_cat_name;
			let hit = qna.qna_hit;
			let ent_uno = qna.ent_uno;
			let dtm = qna.qna_dtm;
			let lstNm = qna.lst_sts_name;
			let file_cnt = qna.file_cnt;
			let className = file_cnt > 0 ?   'class="titleList detachFile"' : 'class="titleList"';
			html += '<tr>';
			html += '<td>' + qnaIndex + '</td>';
//			html += '<td>' + qna.brd_idx + '</td>';
			html += '<td>' + sac_yy + '</td>' ;
			html += '<td>' + wrkNm + '</td>';
			html += '<td><div class="ellipsis type1" title="' + qstNm + '">' + qstNm + '</div></td>';
			html += '<td ' + className + '>';
			html += '<a href="javascript:fn_qnaDetail(\'' + brd_code + '\',\'' + brd_idx + '\');">' + subject + '</a>'
			html += '</td>';
			html += '<td>' + hit + '</td>';
			html += '<td><div class="ellipsis type2" title="' + ent_uno + '">' + ent_uno + '</div></td>';
			html += '<td>' + dtm + '</td>';
			html += '<td><a class="lstPotinter" onclick="fn_search_sts(' + brd_idx + ',\'' + brd_code + '\');">' + lstNm + '</a></td>';
			html += '</tr>';
		}
		
		for (var i = startPageNum; i <= endPageNum; i++) {
			let className = i == pageNum ? 'num_current' : 'num';
			pageHtml += '<a href="javascript:fn_pageMove(' + i + ');" class="' + className + '">' + i + '</a>';
		}
		
	}
	else{
		html += '<tr>';
		html += '<td colspan="9">데이터가 없습니다.</td>';
		html += '</tr>';
		pageHtml += '<a href="javascript:fn_pageMove(1);" class="num_current">1</a>';
	}

	pageHtml += '<a href="javascript:fn_pageMove(' + nextPageNum + ');" class="next"></a>';
	pageHtml += '<a href="javascript:fn_pageMove(' + finalPageNum + ');" class="nextEnd"></a>';
	pageHtml += '</div></div>';
	
	$('#qnaList tbody').html(html);
	$('#pageNavigation').html(pageHtml);
	
}



function fn_pageMove(page_num) {
	fn_qna_search(page_num);
}


function fn_qnaDetail(brd_code, brd_idx) {
	let f = document.searchForm;
	f.brd_idx.value = brd_idx;
	f.brd_code.value = brd_code;
	f.method = 'post';
	f.action = fn_getContextPath() + '/qna/content';
	f.submit();
}

function fn_conditionSearch(pageNum){
	let f = document.searchForm;
	f.action = fn_getContextPath() + '/qna/list';
	fn_initShrValue();
	f.submit();
}


</script>
</head>
<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>
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
				<div class="searchArea">
<form name="searchForm" id="searchForm" onsubmit="return false;">
	<input type="hidden" name="brd_code" value="${result.brdMst.brd_code }" />
	<input type="hidden" name="brd_cat" value="${result.brdMst.url }" />
	<input type="hidden" name="usr_id" value="${userDataVO.usr_id }">
	<input type="hidden" name="brd_idx" value="0" />
	<input type="hidden" name="usr_cat" value="${userDataVO.usr_cat }">
	<input type="hidden" name="page_num" />
	<input type="hidden" name="comp_code" value="${userDataVO.comp_code }">
					<table class="tblSerach">
						<tr>
							<th>정산년도</th>
							<td>
								<select name="sac_yy" id="sac_yy">
								<option value="">전체</option>
<c:forEach items="${result.c007 }" var="code">
									<option value="${code.cd }" <c:if test="${condition.sac_yy eq code.cd }">selected="selected"</c:if> >${code.cd_nm }</option>
</c:forEach>
									
								</select>
							</td>
							<th>업무구분</th>
							<td>
								<select name="wrk_cat" id="wrk_cat">
								<option value="">전체</option>
<c:forEach items="${result.c001 }" var="code" varStatus="i">
	<c:if test="${fn:substring(sessionScope.userDataVO.comp_role, i.index, i.index + 1) eq 'Y' }">
									<option value="${code.cd }" <c:if test="${condition.wrk_cat eq code.cd }">selected="selected"</c:if> >${code.cd_nm }</option>
	</c:if>
</c:forEach>
								</select>
							</td>
							<th>질문구분</th>
							<td>
								<select name="qst_cat" id="qst_cat">
									<option value="">전체</option>
<c:forEach items="${result.c002 }" var="code">
									<option value="${code.cd }" <c:if test="${condition.qst_cat eq code.cd }">selected="selected"</c:if> >${code.cd_nm }</option>
</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>제목 및 내용</th>
							<td>
								<input type="text" name="keyword" id="keyword" class="keyword" onkeypress="javascript:if(event.keyCode==13) { fn_search(); }" value="${condition.keyword }" />
							</td>
							<th >내가 쓴 글만 보기</th>
							<td >
								<input id="shr_yn" name="shr_yn" type="checkbox" value="N" class="onlyMyBrd" <c:if test="${condition.shr_yn eq 'N' }">checked="checked"</c:if>  >
								<input id="shr_yn_hidden" name="shr_yn" type="hidden" value="Y" >
							</td>
							<th>진행상태</th>
							<td>
								<select name="lst_sts" id="lst_sts">
									<option value="">전체</option>
<c:forEach items="${result.c004 }" var="code">
									<option value="${code.cd }" <c:if test="${condition.lst_sts eq code.cd }">selected="selected"</c:if> >${code.cd_nm }</option>
</c:forEach>
								</select>
							</td>
						</tr>
					</table>
</form>
					<div class="searchBtnArea">
						<div class="hp_btnSearch" title="검색" onclick="fn_conditionSearch(1);"></div>
						<div class="hp_btnReset" title="초기화" onclick="fn_searchFormReset();"></div>
					</div>
				</div>
				
				<div class="cntHeader bgImg3">
					<div class="title">${result.brdMst.brd_name }</div>
					
					<div class="tblBtnTop">
<%-- <c:if test="${sessionScope.userDataVO.usr_cat eq '99' }"> --%>
						<!-- <div class="btnBasic" onclick="fn_qnaForm('${result.brdMst.brd_code }', 0);">등록하기</div> --> 
<%-- </c:if> --%>
					</div>
					
					
				</div>
					
				<div class="cntBody">
					<div class="tblWrap">
						<table class="tbl_list qna" id="qnaList">
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
									<th class="col_9">진행상태</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					<div class="tblBtnArea">
<%-- <c:if test="${sessionScope.userDataVO.usr_cat eq '99' }"> --%>
						<div class="btnBasic" onclick="fn_qnaForm('${result.brdMst.brd_code }', 0);">등록하기</div>
<%-- </c:if> --%>
					</div>
					
					<div id="pageNavigation"></div>
				</div>
				
				
				
				
				
			</div>
		</div>
		
	</div>


</body>
</html>


